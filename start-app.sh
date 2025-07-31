#!/bin/bash

# HR Admin System - Автоматический запуск
# Этот скрипт устанавливает зависимости, настраивает базу данных и запускает приложение

set -e  # Остановка при ошибке

echo "🚀 Запуск HR Admin System..."

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Функция для вывода сообщений
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

# Проверка наличия необходимых команд
check_requirements() {
    log "Проверка системных требований..."
    
    # Проверка Python
    if ! command -v python3 &> /dev/null; then
        error "Python3 не установлен. Установите Python 3.8+"
    fi
    
    # Проверка Node.js
    if ! command -v node &> /dev/null; then
        error "Node.js не установлен. Установите Node.js 14+"
    fi
    
    # Проверка npm
    if ! command -v npm &> /dev/null; then
        error "npm не установлен. Установите npm"
    fi
    
    # Проверка cloudflared (опционально)
    if ! command -v cloudflared &> /dev/null; then
        warning "cloudflared не установлен. Установите для внешнего доступа: brew install cloudflare/cloudflare/cloudflared"
    fi
    
    log "✅ Все системные требования выполнены"
}

# Установка Python зависимостей
install_backend_deps() {
    log "Установка Python зависимостей..."
    
    cd backend
    
    # Проверка наличия requirements.txt
    if [ ! -f "requirements.txt" ]; then
        error "Файл requirements.txt не найден в папке backend"
    fi
    
    # Установка зависимостей
    pip3 install -r requirements.txt
    
    log "✅ Python зависимости установлены"
    cd ..
}

# Установка Node.js зависимостей
install_frontend_deps() {
    log "Установка Node.js зависимостей..."
    
    cd frontend
    
    # Проверка наличия package.json
    if [ ! -f "package.json" ]; then
        error "Файл package.json не найден в папке frontend"
    fi
    
    # Установка зависимостей
    npm install
    
    log "✅ Node.js зависимости установлены"
    cd ..
}

# Настройка базы данных
setup_database() {
    log "Настройка базы данных..."
    
    cd backend
    
    # Установка переменной окружения
    export DATABASE_URL="sqlite:///./hr_admin.db"
    
    # Проверка наличия init_db.py
    if [ ! -f "init_db.py" ]; then
        error "Файл init_db.py не найден в папке backend"
    fi
    
    # Инициализация базы данных
    python3 init_db.py
    
    log "✅ База данных настроена"
    cd ..
}

# Сборка фронтенда
build_frontend() {
    log "Сборка фронтенда..."
    
    cd frontend
    
    # Сборка для продакшена
    npm run build
    
    # Создание папки static в backend если её нет
    mkdir -p ../backend/static
    
    # Копирование собранных файлов
    cp -r build/* ../backend/static/
    
    log "✅ Фронтенд собран и скопирован в backend/static"
    cd ..
}

# Остановка существующих процессов
stop_existing_processes() {
    log "Остановка существующих процессов..."
    
    # Остановка uvicorn процессов
    pkill -f "uvicorn main:app" || true
    
    # Остановка cloudflared процессов
    pkill -f "cloudflared tunnel" || true
    
    # Остановка react-scripts процессов
    pkill -f "react-scripts" || true
    
    log "✅ Существующие процессы остановлены"
}

# Запуск бэкенда
start_backend() {
    log "Запуск бэкенда..."
    
    cd backend
    
    # Установка переменной окружения
    export DATABASE_URL="sqlite:///./hr_admin.db"
    
    # Запуск в фоновом режиме
    python3 -m uvicorn main:app --host 0.0.0.0 --port 8001 &
    BACKEND_PID=$!
    
    # Сохранение PID для последующей остановки
    echo $BACKEND_PID > ../backend.pid
    
    # Ожидание запуска сервера
    sleep 5
    
    # Проверка, что сервер запустился
    if curl -s http://localhost:8001/health > /dev/null; then
        log "✅ Бэкенд запущен на http://localhost:8001"
    else
        error "Не удалось запустить бэкенд"
    fi
    
    cd ..
}

# Запуск Cloudflare Tunnel (опционально)
start_tunnel() {
    if command -v cloudflared &> /dev/null; then
        log "Запуск Cloudflare Tunnel..."
        
        cloudflared tunnel --url http://localhost:8001 &
        TUNNEL_PID=$!
        
        # Сохранение PID для последующей остановки
        echo $TUNNEL_PID > tunnel.pid
        
        # Ожидание запуска туннеля
        sleep 10
        
        log "✅ Cloudflare Tunnel запущен"
        log "🌐 Приложение будет доступно по URL, который покажет Cloudflare Tunnel"
    else
        warning "cloudflared не установлен. Приложение доступно только локально на http://localhost:8001"
    fi
}

# Функция очистки при выходе
cleanup() {
    log "Остановка приложения..."
    
    # Остановка бэкенда
    if [ -f "backend.pid" ]; then
        kill $(cat backend.pid) 2>/dev/null || true
        rm -f backend.pid
    fi
    
    # Остановка туннеля
    if [ -f "tunnel.pid" ]; then
        kill $(cat tunnel.pid) 2>/dev/null || true
        rm -f tunnel.pid
    fi
    
    # Остановка всех процессов
    pkill -f "uvicorn main:app" || true
    pkill -f "cloudflared tunnel" || true
    
    log "✅ Приложение остановлено"
}

# Установка обработчика сигналов
trap cleanup EXIT INT TERM

# Главная функция
main() {
    log "Начинаем запуск HR Admin System..."
    
    # Проверка системных требований
    check_requirements
    
    # Установка зависимостей
    install_backend_deps
    install_frontend_deps
    
    # Настройка базы данных
    setup_database
    
    # Сборка фронтенда
    build_frontend
    
    # Остановка существующих процессов
    stop_existing_processes
    
    # Запуск бэкенда
    start_backend
    
    # Запуск туннеля
    start_tunnel
    
    log "🎉 HR Admin System успешно запущена!"
    log ""
    log "📱 Локальный доступ: http://localhost:8001"
    log "📊 API документация: http://localhost:8001/docs"
    log "🔍 Проверка здоровья: http://localhost:8001/api/health"
    log ""
    log "Для остановки приложения нажмите Ctrl+C"
    log ""
    
    # Ожидание сигнала для остановки
    wait
}

# Проверка аргументов командной строки
case "${1:-}" in
    "help"|"-h"|"--help")
        echo "HR Admin System - Скрипт запуска"
        echo ""
        echo "Использование:"
        echo "  ./start-app.sh          - Запуск приложения"
        echo "  ./start-app.sh help     - Показать эту справку"
        echo ""
        echo "Что делает скрипт:"
        echo "  1. Проверяет системные требования"
        echo "  2. Устанавливает зависимости"
        echo "  3. Настраивает базу данных"
        echo "  4. Собирает фронтенд"
        echo "  5. Запускает бэкенд"
        echo "  6. Запускает Cloudflare Tunnel (если доступен)"
        echo ""
        echo "Требования:"
        echo "  - Python 3.8+"
        echo "  - Node.js 14+"
        echo "  - npm"
        echo "  - cloudflared (опционально)"
        exit 0
        ;;
    *)
        main
        ;;
esac 