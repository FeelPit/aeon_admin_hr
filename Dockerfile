# Универсальный Dockerfile для Heroku (backend + frontend + nginx)

# 1. Сборка фронтенда
FROM node:18-alpine as frontend-build
WORKDIR /app
COPY frontend/package*.json ./frontend/
RUN cd frontend && npm install
COPY frontend ./frontend
RUN cd frontend && npm run build

# 2. Сборка backend
FROM python:3.11-slim as backend-build
WORKDIR /app
COPY backend/requirements.txt ./backend/
RUN pip install --no-cache-dir -r backend/requirements.txt
COPY backend ./backend

# 3. Финальный образ
FROM python:3.11-slim
WORKDIR /app

# Установка nginx и nodejs для serve (если нужно)
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Копируем backend
COPY --from=backend-build /app/backend ./backend

# Копируем собранный frontend
COPY --from=frontend-build /app/frontend/build ./frontend_build

# Копируем nginx.conf
COPY nginx.conf /etc/nginx/nginx.conf

# Копируем requirements.txt для запуска
COPY backend/requirements.txt ./backend/requirements.txt
RUN pip install --no-cache-dir -r backend/requirements.txt

# Копируем точку входа backend
COPY backend/main.py ./backend/main.py

# Открываем порты
EXPOSE 80

# Скрипт запуска всех сервисов
COPY start.sh ./start.sh
RUN chmod +x ./start.sh

CMD ["./start.sh"] 