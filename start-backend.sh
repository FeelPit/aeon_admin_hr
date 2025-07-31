#!/bin/bash

# HR Admin System - Быстрый запуск бэкенда
# Этот скрипт запускает только бэкенд для разработки

set -e

echo "🚀 Быстрый запуск бэкенда HR Admin System..."

# Цвета для вывода
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
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

# Остановка существующих процессов
log "Остановка существующих процессов..."
pkill -f "uvicorn main:app" || true
sleep 2

# Переход в папку backend
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

# Запуск сервера
log "Запуск бэкенда на http://localhost:8001"
log "Для остановки нажмите Ctrl+C"
echo ""

python3 -m uvicorn main:app --host 0.0.0.0 --port 8001 --reload 