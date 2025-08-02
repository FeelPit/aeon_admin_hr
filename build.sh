#!/bin/bash

# Скрипт сборки для Render
echo "🚀 Начинаем сборку проекта..."

# Устанавливаем зависимости Python
echo "📦 Устанавливаем Python зависимости..."
pip install -r backend/requirements.txt

# Создаем необходимые директории
echo "📁 Создаем директории..."
mkdir -p backend/static

# Копируем статические файлы фронтенда в бэкенд
echo "📋 Копируем статические файлы..."
if [ -d "frontend/build" ]; then
    cp -r frontend/build/* backend/static/
    echo "✅ Статические файлы скопированы"
else
    echo "⚠️  Директория frontend/build не найдена, создаем пустую"
    mkdir -p backend/static
fi

# Инициализируем базу данных
echo "🗄️  Инициализируем базу данных..."
cd backend
python init_heroku_db.py

echo "✅ Сборка завершена!" 