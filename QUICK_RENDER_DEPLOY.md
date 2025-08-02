# 🚀 Быстрый деплой на Render

## Подготовка (5 минут)

1. **Проверьте готовность проекта:**
   ```bash
   python3 check-render-readiness.py
   ```

2. **Запушьте код в Git:**
   ```bash
   git add .
   git commit -m "Подготовка к деплою на Render"
   git push origin main
   ```

## Деплой на Render (10 минут)

### 1. Создание аккаунта
- Зайдите на [render.com](https://render.com)
- Зарегистрируйтесь через GitHub

### 2. Автоматический деплой
1. Нажмите "New +" → "Blueprint"
2. Подключите ваш GitHub репозиторий
3. Выберите файл `render.yaml`
4. Нажмите "Apply"

### 3. Настройка переменных окружения
После создания сервисов настройте переменные:

**Обязательные:**
- `BOT_TOKEN` - токен вашего Telegram бота

**Опциональные:**
- `NOTION_TOKEN` - для интеграции с Notion
- `NOTION_DATABASE_ID` - ID базы данных Notion

## Проверка деплоя

1. **Бэкенд:** `https://hr-admin-backend.onrender.com/health`
2. **Фронтенд:** `https://hr-admin-frontend.onrender.com`
3. **API Docs:** `https://hr-admin-backend.onrender.com/docs`

## Получение Telegram Bot Token

1. Найдите @BotFather в Telegram
2. Отправьте `/newbot`
3. Следуйте инструкциям
4. Скопируйте токен в переменную `BOT_TOKEN`

## Структура URL

- **Frontend:** `https://hr-admin-frontend.onrender.com`
- **Backend:** `https://hr-admin-backend.onrender.com`
- **API Docs:** `https://hr-admin-backend.onrender.com/docs`

## Обновления

Для обновления приложения:
```bash
git push origin main
```
Render автоматически пересоберет и перезапустит сервисы.

## Поддержка

- 📖 Подробное руководство: `RENDER_DEPLOYMENT.md`
- 🔍 Проверка готовности: `python3 check-render-readiness.py`
- 📧 Поддержка Render: [support.render.com](https://support.render.com) 