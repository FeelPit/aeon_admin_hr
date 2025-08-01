#!/bin/bash

echo "🚀 Настройка внешнего доступа через Ngrok"
echo "=========================================="

# Проверяем, что backend работает
echo "📡 Проверка backend..."
if ! curl -s http://localhost:8001/api/health > /dev/null; then
    echo "❌ Backend не работает на порту 8001"
    echo "Запустите сначала: ./start-backend.sh"
    exit 1
fi

echo "✅ Backend работает"

# Проверяем, установлен ли ngrok
if ! command -v ngrok &> /dev/null; then
    echo "❌ ngrok не установлен"
    echo "Установите: brew install ngrok"
    exit 1
fi

echo "✅ ngrok установлен"

# Проверяем авторизацию ngrok
echo "🔐 Проверка авторизации ngrok..."
if ! ngrok config check &> /dev/null; then
    echo "⚠️  ngrok не авторизован"
    echo "Для авторизации выполните:"
    echo "1. Зарегистрируйтесь на https://ngrok.com"
    echo "2. Получите authtoken в настройках"
    echo "3. Выполните: ngrok authtoken YOUR_TOKEN"
    echo ""
    echo "Или запустите без авторизации (ограниченная функциональность):"
    echo "ngrok http 8001"
    exit 1
fi

echo "✅ ngrok авторизован"

# Останавливаем существующие процессы
echo "🛑 Остановка существующих процессов..."
pkill -f ngrok 2>/dev/null
sleep 2

# Запускаем ngrok
echo "🌐 Запуск ngrok туннеля..."
echo "Это может занять несколько секунд..."

# Запускаем ngrok в фоне
ngrok http 8001 --log=stdout > ngrok.log 2>&1 &
NGROK_PID=$!

# Ждем и ищем URL
echo "⏳ Ожидание создания туннеля..."
for i in {1..30}; do
    if grep -q "https://.*ngrok.io" ngrok.log; then
        echo ""
        echo "🎉 Туннель создан!"
        echo "📱 Публичная ссылка:"
        grep "https://.*ngrok.io" ngrok.log | tail -1 | sed 's/.*https/https/'
        echo ""
        echo "🔗 Приложение доступно по ссылке выше"
        echo "📊 Веб-интерфейс ngrok: http://localhost:4040"
        echo "🛑 Для остановки нажмите Ctrl+C"
        break
    fi
    echo -n "."
    sleep 2
done

if ! grep -q "https://.*ngrok.io" ngrok.log; then
    echo ""
    echo "❌ Не удалось создать туннель за 60 секунд"
    echo "Проверьте логи в файле ngrok.log"
    kill $NGROK_PID 2>/dev/null
    exit 1
fi

# Ждем завершения
wait $NGROK_PID 