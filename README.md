# 🚀 HR Admin System

Полнофункциональная система управления HR-процессами с интеграцией Telegram и Notion.

## 🎯 Возможности

- **Управление кандидатами**: Добавление, редактирование, отслеживание статуса
- **Интервью**: Проведение и запись результатов интервью
- **Метрики**: Аналитика и отчеты по кандидатам
- **Уведомления**: Интеграция с Telegram для уведомлений
- **Notion интеграция**: Синхронизация с Notion
- **Telegram Mini Apps**: Поддержка Telegram ботов
- **Внешний API**: REST API для интеграции с внешними системами

## 🚀 Быстрый запуск

### 🐳 Полный запуск с Docker (рекомендуется)

```bash
./start-full-docker.sh
```

Этот скрипт:
- ✅ Проверяет все зависимости (Docker, cloudflared)
- ✅ Запускает PostgreSQL в Docker
- ✅ Запускает backend в Docker
- ✅ Запускает frontend в Docker
- ✅ Настраивает Cloudflare Tunnel
- ✅ Создает тестовые данные
- ✅ Предоставляет полную информацию о доступе

### 🐳 Запуск только с Docker (без туннеля)

```bash
./start-docker-only.sh
```

Этот скрипт:
- ✅ Проверяет зависимости (Docker)
- ✅ Запускает PostgreSQL в Docker
- ✅ Запускает backend в Docker
- ✅ Запускает frontend в Docker
- ✅ Создает тестовые данные
- ✅ Предоставляет информацию о доступе

### 📱 Локальная установка

```bash
./start-app.sh
```

## 🛑 Остановка

### Для Docker версии:
```bash
./stop-full-docker.sh
```

### Для локальной версии:
Нажмите `Ctrl+C` в терминале, где запущен скрипт.

## 📊 Доступ к системе

После запуска система будет доступна:

- **Frontend**: http://localhost:3002 (Docker) или http://localhost:3000 (локально)
- **Backend API**: http://localhost:8000
- **API документация**: http://localhost:8000/docs
- **Проверка здоровья**: http://localhost:8000/api/health

## 🔧 Требования

- Docker Desktop (для Docker версии)
- Python 3.8+ (для локальной версии)
- Node.js 14+ (для локальной версии)
- cloudflared (устанавливается автоматически)

## 📚 Документация

- [QUICK_START.md](QUICK_START.md) - Быстрый старт
- [README_DOCKER.md](README_DOCKER.md) - Подробная документация по Docker
- [EXTERNAL_ACCESS_GUIDE.md](EXTERNAL_ACCESS_GUIDE.md) - Настройка внешнего доступа
- [TELEGRAM_SETUP.md](TELEGRAM_SETUP.md) - Настройка Telegram интеграции

## 🏗️ Архитектура

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Frontend      │    │   Backend       │    │   Database      │
│   (React)       │◄──►│   (FastAPI)     │◄──►│   (PostgreSQL)  │
│   Port: 3002    │    │   Port: 8000    │    │   Port: 5432    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Nginx         │    │   Telegram      │    │   Notion        │
│   (Proxy)       │    │   Bot           │    │   Integration   │
│   Port: 80      │    │   (Optional)    │    │   (Optional)    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 🔑 Тестовые данные

После запуска создается тестовый админ:
- **Email**: `admin@example.com`
- **Пароль**: `admin123`

И 15 тестовых кандидатов с различными статусами.

## 🌐 Внешний доступ

Для доступа из интернета используйте:

1. **Cloudflare Tunnel** (автоматически настраивается):
   ```bash
   ./start-full-docker.sh
   ```

2. **Прямой доступ** (если порт открыт):
   ```bash
   ./start-direct-access.sh
   ```

3. **Ngrok туннель**:
   ```bash
   ./setup-ngrok-tunnel.sh
   ```

## 🔍 Отладка

### Просмотр логов

```bash
# Docker версия
docker-compose logs -f

# Локальная версия
# Логи выводятся в консоль
```

### Проверка здоровья

```bash
curl http://localhost:8000/api/health
```

### Подключение к базе данных

```bash
# Docker версия
docker-compose exec db psql -U postgres -d hr_admin

# Локальная версия
sqlite3 backend/hr_admin.db
```

## 🚨 Устранение неполадок

### Проблема: "Port already in use"
```bash
# Найдите процесс
lsof -i :8000
lsof -i :3002

# Остановите процесс
kill -9 <PID>
```

### Проблема: "Database connection failed"
```bash
# Docker версия
docker-compose restart db

# Локальная версия
cd backend && python3 init_db.py
```

### Проблема: "Docker not found"
```bash
# Установите Docker Desktop
# https://www.docker.com/products/docker-desktop
```

## 🤝 Поддержка

При возникновении проблем:

1. Проверьте логи: `docker-compose logs -f`
2. Убедитесь, что все порты свободны
3. Проверьте, что Docker запущен
4. Обратитесь к разделу "Устранение неполадок"

## 📄 Лицензия

MIT License - см. файл [LICENSE](LICENSE)

## 🎉 Готово!

Система готова к использованию! 🚀

Для получения дополнительной информации см. документацию в папке проекта. 