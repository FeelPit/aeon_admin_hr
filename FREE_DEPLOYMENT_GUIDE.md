# 🚀 Бесплатный деплой HR-системы

## 🎯 Выбор платформы

Для бесплатного деплоя вашей HR-системы рекомендую **две отличные платформы**:

### 🥇 **Render** (Рекомендуется)
- **💰 Полностью бесплатно**: 750 часов в месяц
- **⚡ Простота**: один файл конфигурации
- **🗄️ База данных**: PostgreSQL включена
- **🔒 SSL**: HTTPS автоматически
- **🌍 Домен**: бесплатный поддомен

### 🥈 **Railway** (Альтернатива)
- **💰 $5 кредитов** в месяц (достаточно для тестирования)
- **⚡ Очень просто**: автоматический деплой
- **🗄️ База данных**: PostgreSQL включена
- **🔒 SSL**: HTTPS автоматически
- **🌍 Домен**: бесплатный поддомен

## 🚀 Быстрый старт

### Вариант 1: Render (Рекомендуется)

```bash
# 1. Запустите подготовительный скрипт
./deploy-railway.sh

# 2. Следуйте инструкциям для Render
# Откройте: https://render.com
```

**Время деплоя**: 5-10 минут  
**Стоимость**: БЕСПЛАТНО  
**Сложность**: ⭐⭐ (Легко)

### Вариант 2: Railway

```bash
# 1. Запустите подготовительный скрипт
./deploy-railway.sh

# 2. Следуйте инструкциям для Railway
# Откройте: https://railway.app
```

**Время деплоя**: 5-10 минут  
**Стоимость**: $5/месяц  
**Сложность**: ⭐ (Очень легко)

## 📋 Что уже готово

✅ **Dockerfile** - для сборки приложения  
✅ **railway.json** - конфигурация Railway  
✅ **render.yaml** - конфигурация Render  
✅ **deploy-railway.sh** - автоматический скрипт  
✅ **CORS настройки** - для внешнего доступа  
✅ **База данных** - PostgreSQL конфигурация  
✅ **Переменные окружения** - готовые шаблоны  

## 🎯 Пошаговый план

### Шаг 1: Подготовка (2 минуты)

```bash
# Убедитесь, что код в GitHub
git status
git add .
git commit -m "Ready for deployment"
git push origin main
```

### Шаг 2: Выбор платформы (1 минута)

**Рекомендую Render** для полной бесплатности:

- ✅ 750 часов бесплатно
- ✅ PostgreSQL включена
- ✅ SSL сертификат
- ✅ Простая настройка

### Шаг 3: Деплой (5-10 минут)

**Для Render:**
1. Откройте [render.com](https://render.com)
2. Нажмите "Get Started"
3. Подключите GitHub
4. Выберите репозиторий
5. Нажмите "Create Web Service"

**Для Railway:**
1. Откройте [railway.app](https://railway.app)
2. Нажмите "Start a New Project"
3. Выберите "Deploy from GitHub repo"
4. Выберите репозиторий
5. Нажмите "Deploy Now"

### Шаг 4: Настройка (2 минуты)

**Переменные окружения:**
```env
SECRET_KEY=your-super-secret-key-here
BOT_TOKEN= (если используете Telegram)
```

**База данных:**
- Render: автоматически создаст PostgreSQL
- Railway: добавьте PostgreSQL сервис

### Шаг 5: Готово! (1 минута)

**Доступ к приложению:**
- URL: `https://your-app-name.onrender.com` (Render)
- URL: `https://your-app-name.railway.app` (Railway)
- Логин: `admin@example.com`
- Пароль: `admin123`

## 🔧 Технические детали

### Архитектура деплоя

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Frontend      │    │   Backend       │    │   Database      │
│   (React)       │◄──►│   (FastAPI)     │◄──►│   (PostgreSQL)  │
│   (Built)       │    │   (Python)      │    │   (Cloud)       │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Static Files  │    │   API Routes    │    │   Cloud DB      │
│   (Served by    │    │   (FastAPI)     │    │   (Managed)     │
│   Backend)      │    │   (Port $PORT)  │    │   (Auto SSL)    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### Переменные окружения

**Обязательные:**
```env
DATABASE_URL=postgresql://... (создается автоматически)
SECRET_KEY=your-super-secret-key-here
PORT=8000 (устанавливается автоматически)
```

**Опциональные:**
```env
BOT_TOKEN=your-telegram-bot-token
NODE_ENV=production
```

### Health Check

После деплоя проверьте:
- `https://your-app-name.onrender.com/api/health` (Render)
- `https://your-app-name.railway.app/api/health` (Railway)

Должен вернуть: `{"status": "healthy"}`

## 🚨 Устранение неполадок

### Проблема: "Build failed"

**Решение:**
```bash
# Проверьте логи
# Render: Dashboard → Logs
# Railway: Dashboard → Deployments → View Logs

# Локальное тестирование
docker build -t test .
```

### Проблема: "Database connection failed"

**Решение:**
1. Проверьте переменную `DATABASE_URL`
2. Убедитесь, что база данных создана
3. Проверьте логи приложения

### Проблема: "CORS errors"

**Решение:**
1. Проверьте настройки CORS в `backend/main.py`
2. Убедитесь, что домен добавлен в `allow_origins`

### Проблема: "Port not found"

**Решение:**
1. Убедитесь, что приложение слушает на `$PORT`
2. Проверьте конфигурацию в `railway.json` или `render.yaml`

## 💰 Стоимость

### Render
- **Бесплатный тариф**: 750 часов в месяц
- **Наш проект**: ~$0/месяц (полностью бесплатно)
- **Ограничения**: сервис "засыпает" после 15 минут неактивности

### Railway
- **Бесплатный тариф**: $5 кредитов в месяц
- **Наш проект**: ~$3-5/месяц (в пределах бесплатного тарифа)
- **Ограничения**: нет "сна" сервиса

## 🔄 Обновления

### Автоматические обновления
1. Push в `main` ветку GitHub
2. Платформа автоматически пересоберет и перезапустит приложение

### Ручные обновления
```bash
# Render CLI
npm install -g @render/cli
render login
render deploy

# Railway CLI
npm install -g @railway/cli
railway login
railway up
```

## 📱 Telegram интеграция

Если используете Telegram:

1. **Создайте бота** через @BotFather
2. **Получите токен**
3. **Добавьте в переменные окружения**:
   ```env
   BOT_TOKEN=your-bot-token-here
   ```
4. **Настройте webhook**:
   ```
   https://api.telegram.org/bot<BOT_TOKEN>/setWebhook?url=https://your-app-name.onrender.com/telegram/webhook
   ```

## 🎉 Результат

После успешного деплоя у вас будет:

✅ **Рабочее приложение** с HTTPS  
✅ **База данных PostgreSQL** в облаке  
✅ **API документация** доступна  
✅ **Тестовые данные** готовы  
✅ **Telegram интеграция** (если настроена)  
✅ **Мониторинг** и логи  
✅ **Автоматические обновления**  

## 📞 Поддержка

### Документация
- [RAILWAY_DEPLOY.md](RAILWAY_DEPLOY.md) - подробно про Railway
- [RENDER_DEPLOY.md](RENDER_DEPLOY.md) - подробно про Render

### Полезные ссылки
- **Render**: [render.com](https://render.com) | [docs.render.com](https://docs.render.com)
- **Railway**: [railway.app](https://railway.app) | [docs.railway.app](https://docs.railway.app)

### Сообщества
- **Render Discord**: [discord.gg/render](https://discord.gg/render)
- **Railway Discord**: [discord.gg/railway](https://discord.gg/railway)

## 🏆 Рекомендация

**Для тестирования рекомендую Render**:
- ✅ Полностью бесплатно
- ✅ Простая настройка
- ✅ PostgreSQL включена
- ✅ SSL автоматически
- ✅ Хорошая документация

**Для продакшена рассмотрите Railway**:
- ✅ Нет "сна" сервиса
- ✅ Больше ресурсов
- ✅ Лучшая производительность

---

**Удачи с деплоем! 🚀**

Ваша HR-система будет доступна из любой точки мира! 🌍 