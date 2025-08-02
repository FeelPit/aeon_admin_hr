# 🚀 Деплой на Railway - Бесплатное развертывание

## 📋 Что такое Railway?

Railway - это современная платформа для деплоя приложений с:
- **Бесплатным тарифом**: $5 кредитов в месяц
- **Автоматическим деплоем** из GitHub
- **Поддержкой Docker** и различных языков
- **Базами данных PostgreSQL** включены
- **SSL сертификатами** автоматически
- **Глобальными CDN**

## 🎯 Преимущества для нашего проекта

✅ **Бесплатно** - достаточно для тестирования  
✅ **Простота** - один клик для деплоя  
✅ **База данных** - PostgreSQL включена  
✅ **SSL** - HTTPS автоматически  
✅ **Домен** - бесплатный поддомен  
✅ **Мониторинг** - логи и метрики  

## 🚀 Пошаговый деплой

### 1. Подготовка репозитория

Убедитесь, что ваш код находится в GitHub репозитории:

```bash
# Если еще не создали репозиторий
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git push -u origin main
```

### 2. Регистрация на Railway

1. Перейдите на [railway.app](https://railway.app)
2. Нажмите "Start a New Project"
3. Выберите "Deploy from GitHub repo"
4. Подключите ваш GitHub аккаунт
5. Выберите ваш репозиторий

### 3. Настройка проекта

После подключения репозитория:

1. **Выберите ветку**: `main`
2. **Настройте переменные окружения**:
   ```
   DATABASE_URL=postgresql://... (Railway создаст автоматически)
   SECRET_KEY=your-super-secret-key-here
   BOT_TOKEN= (если используете Telegram)
   ```

3. **Настройте базу данных**:
   - В Railway Dashboard нажмите "New"
   - Выберите "Database" → "PostgreSQL"
   - Railway автоматически подключит базу к вашему приложению

### 4. Деплой

1. Railway автоматически обнаружит `railway.json` и `Dockerfile`
2. Нажмите "Deploy Now"
3. Дождитесь завершения сборки (5-10 минут)

### 5. Получение доступа

После успешного деплоя:

1. **URL приложения**: `https://your-app-name.railway.app`
2. **API документация**: `https://your-app-name.railway.app/docs`
3. **Тестовые данные**:
   - Email: `admin@example.com`
   - Пароль: `admin123`

## 🔧 Настройка переменных окружения

В Railway Dashboard → Variables:

```env
# Обязательные
SECRET_KEY=your-super-secret-key-here

# Опциональные (для Telegram)
BOT_TOKEN=your-telegram-bot-token

# База данных (Railway создаст автоматически)
DATABASE_URL=postgresql://...
```

## 📊 Мониторинг

### Логи
- Railway Dashboard → Deployments → View Logs
- Или через CLI: `railway logs`

### Метрики
- Railway Dashboard → Metrics
- CPU, память, сеть в реальном времени

### Health Check
- URL: `https://your-app-name.railway.app/api/health`
- Должен возвращать `{"status": "healthy"}`

## 🔄 Обновления

### Автоматические обновления
1. Push в `main` ветку
2. Railway автоматически пересоберет и перезапустит приложение

### Ручные обновления
```bash
# Установите Railway CLI
npm install -g @railway/cli

# Логин
railway login

# Деплой
railway up
```

## 💰 Стоимость

### Бесплатный тариф
- **$5 кредитов** в месяц
- **512MB RAM** на сервис
- **1GB хранилища**
- **Неограниченные деплои**

### Наш проект
- **Backend**: ~$2-3/месяц
- **Database**: ~$1-2/месяц
- **Итого**: ~$3-5/месяц (в пределах бесплатного тарифа)

## 🚨 Устранение неполадок

### Проблема: "Build failed"
```bash
# Проверьте логи сборки
railway logs

# Убедитесь, что Dockerfile корректен
docker build -t test .
```

### Проблема: "Database connection failed"
1. Проверьте переменную `DATABASE_URL`
2. Убедитесь, что база данных создана
3. Проверьте логи приложения

### Проблема: "Port not found"
1. Убедитесь, что приложение слушает на `$PORT`
2. Проверьте `railway.json` конфигурацию

### Проблема: "CORS errors"
1. Проверьте настройки CORS в `main.py`
2. Убедитесь, что домен добавлен в `allow_origins`

## 🔒 Безопасность

### Рекомендации
1. **Измените SECRET_KEY** на уникальный
2. **Не коммитьте** `.env` файлы
3. **Используйте HTTPS** (Railway предоставляет автоматически)
4. **Ограничьте CORS** в продакшене

### Переменные окружения
```env
# В Railway Dashboard
SECRET_KEY=your-super-secret-key-here
NODE_ENV=production
```

## 📱 Telegram интеграция

Если используете Telegram:

1. **Создайте бота** через @BotFather
2. **Получите токен**
3. **Добавьте в Railway**:
   ```env
   BOT_TOKEN=your-bot-token-here
   ```
4. **Настройте webhook**:
   ```
   https://api.telegram.org/bot<BOT_TOKEN>/setWebhook?url=https://your-app-name.railway.app/telegram/webhook
   ```

## 🎉 Готово!

После успешного деплоя:

1. **Откройте приложение**: `https://your-app-name.railway.app`
2. **Войдите**: `admin@example.com` / `admin123`
3. **Проверьте API**: `https://your-app-name.railway.app/docs`
4. **Поделитесь ссылкой** с командой

## 📞 Поддержка

- **Railway Docs**: [docs.railway.app](https://docs.railway.app)
- **Railway Discord**: [discord.gg/railway](https://discord.gg/railway)
- **GitHub Issues**: Создайте issue в репозитории

---

**Удачи с деплоем! 🚀** 