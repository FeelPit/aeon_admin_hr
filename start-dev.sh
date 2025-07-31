#!/bin/bash

# HR Admin System - Режим разработки
# Этот скрипт запускает бэкенд и фронтенд отдельно для разработки

set -e

echo "🚀 Запуск HR Admin System в режиме разработки..."

# Цвета для вывода
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() {
    echo -e "${GREEN}[$(date +'%H:%M:%S')]${NC} $1"
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

# Функция очистки при выходе
cleanup() {
    log "Остановка приложения..."
    pkill -f "uvicorn main:app" || true
    pkill -f "react-scripts" || true
    log "✅ Приложение остановлено"
}

# Установка обработчика сигналов
trap cleanup EXIT INT TERM

# Остановка существующих процессов
log "Остановка существующих процессов..."
pkill -f "uvicorn main:app" || true
pkill -f "react-scripts" || true
sleep 2

# Запуск бэкенда в фоне
log "Запуск бэкенда..."
cd backend

# Проверка наличия файлов
if [ ! -f "main.py" ]; then
    error "Файл main.py не найден в папке backend"
fi

if [ ! -f "init_db.py" ]; then
    error "Файл init_db.py не найден в папке backend"
fi

# Установка переменной окружения
export DATABASE_URL="sqlite:///./hr_admin.db"

# Инициализация базы данных (если не существует)
if [ ! -f "hr_admin.db" ]; then
    log "Создание базы данных..."
    python3 init_db.py
fi

# Запуск бэкенда в фоне
python3 -m uvicorn main:app --host 0.0.0.0 --port 8001 --reload &
BACKEND_PID=$!

# Ожидание запуска бэкенда
sleep 5

# Проверка, что бэкенд запустился
if curl -s http://localhost:8001/health > /dev/null; then
    log "✅ Бэкенд запущен на http://localhost:8001"
else
    error "Не удалось запустить бэкенд"
fi

cd ..

# Запуск фронтенда в фоне
log "Запуск фронтенда..."
cd frontend

# Проверка наличия package.json
if [ ! -f "package.json" ]; then
    error "Файл package.json не найден в папке frontend"
fi

# Установка зависимостей (если node_modules не существует)
if [ ! -d "node_modules" ]; then
    log "Установка Node.js зависимостей..."
    npm install
fi

# Запуск фронтенда в фоне
npm start &
FRONTEND_PID=$!

cd ..

# Ожидание запуска фронтенда
sleep 10

log "🎉 HR Admin System запущена в режиме разработки!"
log ""
log "📱 Backend: http://localhost:8001"
log "🎨 Frontend: http://localhost:3000"
log "📊 API документация: http://localhost:8001/docs"
log ""
log "Для остановки нажмите Ctrl+C"
log ""

# Ожидание сигнала для остановки
wait 