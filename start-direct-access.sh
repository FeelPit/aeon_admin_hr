#!/bin/bash

# Скрипт для прямого доступа через публичный IP

echo "🚀 Запуск приложения с прямым доступом..."

# Получаем публичный IP
PUBLIC_IP=$(curl -s ifconfig.me)
echo "🌐 Ваш публичный IP: $PUBLIC_IP"

# Проверяем, работает ли backend
echo "📡 Проверка backend..."
if ! curl -s http://localhost:8001/api/health > /dev/null; then
    echo "❌ Backend не работает на порту 8001"
    echo "Запустите сначала: ./start-backend.sh"
    exit 1
fi

echo "✅ Backend работает"

# Запускаем backend на всех интерфейсах
echo "📦 Запуск backend на всех интерфейсах..."
cd backend
python3 -m uvicorn main:app --host 0.0.0.0 --port 8001 --reload &
BACKEND_PID=$!

# Ждем немного, чтобы backend запустился
sleep 3

echo ""
echo "🎉 Приложение запущено!"
echo ""
echo "📱 Локальный доступ:"
echo "   http://localhost:8001"
echo "   http://127.0.0.1:8001"
echo ""
echo "🌐 Внешний доступ (если порт 8001 открыт в файрволе):"
echo "   http://$PUBLIC_IP:8001"
echo ""
echo "📊 API документация:"
echo "   http://localhost:8001/docs"
echo "   http://$PUBLIC_IP:8001/docs"
echo ""
echo "🔍 Проверка здоровья:"
echo "   http://localhost:8001/api/health"
echo "   http://$PUBLIC_IP:8001/api/health"
echo ""
echo "⚠️  Важно:"
echo "   - Убедитесь, что порт 8001 открыт в файрволе"
echo "   - Настройте проброс порта в роутере, если необходимо"
echo "   - Для безопасности рекомендуется использовать VPN или SSH туннель"
echo ""
echo "🛑 Для остановки нажмите Ctrl+C"

# Очистка при завершении
trap "kill $BACKEND_PID 2>/dev/null" EXIT

# Ждем завершения
wait 