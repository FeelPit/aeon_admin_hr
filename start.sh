#!/bin/bash

# Скрипт запуска для Render
echo "🚀 Запускаем приложение..."

# Переходим в директорию бэкенда
cd backend

# Запускаем миграции базы данных
echo "🗄️  Применяем миграции базы данных..."
alembic upgrade head

# Запускаем приложение
echo "🌐 Запускаем FastAPI сервер..."
uvicorn main:app --host 0.0.0.0 --port $PORT 