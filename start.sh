#!/bin/sh

# Запуск backend (FastAPI)
cd /app/backend && uvicorn main:app --host 0.0.0.0 --port 8000 &

# Копируем статику фронта в директорию nginx (если нужно)
# cp -r /app/frontend_build/* /usr/share/nginx/html/

# Запуск nginx
nginx -g 'daemon off;' 