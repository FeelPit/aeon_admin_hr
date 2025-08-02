#!/bin/bash

# Скрипт для запуска приложения с Ngrok туннелем

echo "🚀 Запуск приложения с Ngrok туннелем..."

# Проверяем, установлен ли ngrok
if ! command -v ngrok &> /dev/null; then
    echo "❌ ngrok не установлен. Установите его с https://ngrok.com/download"
    exit 1
fi

# Проверяем, работает ли backend
echo "📡 Проверка backend..."
if ! curl -s http://localhost:8001/api/health > /dev/null; then
    echo "❌ Backend не работает на порту 8001"
    echo "Запустите сначала: ./start-backend.sh"
    exit 1
fi

echo "✅ Backend работает"

# Запускаем ngrok туннель
echo "🌐 Запуск Ngrok туннеля..."
echo "📱 Приложение будет доступно по URL, который покажет Ngrok"
echo ""

# Запускаем ngrok с подробным выводом
ngrok http 8001 --log=stdout 