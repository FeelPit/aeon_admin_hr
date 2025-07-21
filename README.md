# HR-админ панель (лайтовая версия)

Удобный инструмент для оперативной работы с кандидатами: отслеживание, уведомления, связь и базовая фильтрация.

## 🚀 Быстрый запуск

```bash
# Клонируйте репозиторий
git clone <repository-url>
cd aeon_admin_hr

# Запустите проект
./start.sh
```

Откройте в браузере:
- **Frontend**: http://localhost:3000
- **API Docs**: http://localhost:8000/docs

## ✨ Функциональность

### 📋 Управление кандидатами
- Список кандидатов с ключевой информацией
- Статусы: ожидает / прошёл / приглашён / отклонён
- Поиск и фильтрация по ФИО, статусу, дате
- Карточка кандидата с детальной информацией

### 📊 ÆON-интервью
- Краткий отчёт по интервью
- Оценка мотивации, вовлечённости, навыков, честности
- История ответов по ключевым вопросам
- Комментарии HR

### ⚡ Быстрые действия
- Пригласить на тест по софт-скиллам
- Написать в Telegram
- Отправить фидбэк
- Скопировать данные кандидата

### 🔔 Уведомления и интеграции
- Автоуведомления в Telegram HR-менеджеру
- Автоматическая синхронизация с Notion
- Создание задач с ссылками на карточки
- WebView для просмотра карточек из Telegram

### 📈 Метрики и аналитика
- Процент прохождения теста
- Самые слабые вопросы (топ-3)
- Количество активных кандидатов
- Распределение по статусам
- Активность по дням

## 🛠 Технологии

### Backend
- **Python FastAPI** - современный веб-фреймворк
- **SQLAlchemy** - ORM для работы с базой данных
- **PostgreSQL/SQLite** - база данных
- **Pydantic** - валидация данных

### Frontend
- **React 18** - пользовательский интерфейс
- **TypeScript** - типизация
- **Tailwind CSS** - стилизация
- **Lucide React** - иконки
- **React Router** - навигация

### Интеграции
- **Telegram Bot API** - уведомления и сообщения
- **Notion API** - автоматическая синхронизация
- **Docker** - контейнеризация

## 📁 Структура проекта

```
aeon_admin_hr/
├── backend/                 # FastAPI сервер
│   ├── app/
│   │   ├── database.py     # Модели базы данных
│   │   ├── models.py       # Pydantic модели
│   │   ├── routers/        # API роутеры
│   │   └── services/       # Сервисы интеграций
│   ├── main.py             # Точка входа
│   └── requirements.txt    # Python зависимости
├── frontend/               # React приложение
│   ├── src/
│   │   ├── components/     # React компоненты
│   │   ├── pages/          # Страницы приложения
│   │   └── App.tsx         # Главный компонент
│   └── package.json        # Node.js зависимости
├── docker-compose.yml      # Docker конфигурация
├── start.sh               # Скрипт запуска
└── SETUP.md               # Подробная настройка
```

## 🔧 Настройка

### Требования
- Docker и Docker Compose
- Или Python 3.11+ и Node.js 18+

### Интеграции

#### Telegram Bot
1. Создайте бота через @BotFather
2. Получите токен и ID чата
3. Добавьте в `.env`:
   ```
   TELEGRAM_BOT_TOKEN=your_bot_token
   TELEGRAM_CHAT_ID=your_chat_id
   ```

#### Notion
1. Создайте интеграцию в Notion
2. Создайте базы данных для кандидатов и задач
3. Добавьте в `.env`:
   ```
   NOTION_TOKEN=your_integration_token
   NOTION_DATABASE_ID=your_candidates_database_id
   NOTION_TASKS_DATABASE_ID=your_tasks_database_id
   ```

Подробная инструкция по настройке: [SETUP.md](SETUP.md)

## 🎯 Принципы дизайна

- **Простота > перегруженность** - минимум интерфейса, максимум пользы
- **Telegram + Notion = центр действий** - интеграция с привычными инструментами
- **1 клик → максимум действия** - быстрые действия без погружения в таблицы
- **Минимум текста — максимум сигналов** - иконки, статусы, цвета

## 📊 API Endpoints

### Кандидаты
- `GET /api/candidates` - Список кандидатов
- `POST /api/candidates` - Создать кандидата
- `GET /api/candidates/{id}` - Получить кандидата
- `PUT /api/candidates/{id}` - Обновить кандидата
- `DELETE /api/candidates/{id}` - Удалить кандидата

### Быстрые действия
- `POST /api/candidates/{id}/quick-action` - Выполнить действие

### Метрики
- `GET /api/metrics/overview` - Общие метрики
- `GET /api/metrics/status-distribution` - Распределение по статусам
- `GET /api/metrics/activity-timeline` - Активность по дням

Полная документация API: http://localhost:8000/docs

## 🚀 Разработка

### Локальная разработка
```bash
# Backend
cd backend
pip install -r requirements.txt
uvicorn main:app --reload

# Frontend
cd frontend
npm install
npm start
```

### Docker разработка
```bash
# Запуск всех сервисов
docker-compose up --build

# Просмотр логов
docker-compose logs -f backend
docker-compose logs -f frontend
```

## 📝 Лицензия

MIT License

---

**HR Admin Panel** - современное решение для управления кандидатами с интеграцией Telegram и Notion. 