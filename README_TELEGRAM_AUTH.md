# HR Admin Panel - Telegram Mini Apps Аутентификация

## ✅ Реализованные функции

### 1. Убрана панель уведомлений
- Удалена кнопка уведомлений из Layout
- Убрано модальное окно уведомлений
- Удалены все связанные состояния и функции

### 2. Telegram Mini Apps Аутентификация
- **Бесшовная аутентификация** - пользователи автоматически авторизуются через Telegram
- **Автоматическое назначение первого пользователя администратором**
- **Валидация init_data** от Telegram с поддержкой тестового режима
- **JWT токены** для безопасной аутентификации

### 3. Управление администраторами
- **Страница управления админами** (`/admins`)
- **Добавление новых администраторов** по Telegram username
- **Список всех администраторов** с детальной информацией
- **Проверка прав доступа** для административных функций

## 🚀 Быстрый старт

### 1. Запуск бэкенда
```bash
cd backend
python3 -m pip install -r requirements.txt
python3 main.py
```

### 2. Запуск фронтенда
```bash
cd frontend
npm install
npm start
```

### 3. Тестирование API
```bash
python3 test_api.py
```

## 📁 Структура изменений

### Бэкенд
```
backend/
├── app/
│   ├── database.py          # Обновлена модель User
│   ├── models.py            # Новые Pydantic модели
│   └── routers/
│       └── telegram_auth.py # Новый роутер для Telegram аутентификации
├── main.py                  # Добавлен telegram_auth роутер
└── init_db_with_telegram.py # Скрипт инициализации БД
```

### Фронтенд
```
frontend/src/
├── hooks/
│   └── useTelegramAuth.ts   # Хук для Telegram аутентификации
├── pages/
│   └── Admins.tsx          # Страница управления админами
├── components/
│   └── Layout.tsx          # Обновлен для Telegram аутентификации
└── App.tsx                 # Добавлен маршрут /admins
```

## 🔧 API Endpoints

### Аутентификация
```http
POST /api/telegram/telegram-auth
Content-Type: application/json

{
  "init_data": "telegram_init_data_string"
}
```

**Ответ:**
```json
{
  "access_token": "jwt_token",
  "token_type": "bearer",
  "user": {
    "id": 1,
    "name": "Test User",
    "telegram_id": "123456789",
    "telegram_username": "testuser",
    "is_admin": true
  }
}
```

### Профиль пользователя
```http
GET /api/telegram/profile
Authorization: Bearer <token>
```

### Создание администратора
```http
POST /api/telegram/create-admin
Authorization: Bearer <admin_token>
Content-Type: application/json

{
  "telegram_username": "username"
}
```

### Список администраторов
```http
GET /api/telegram/admins
Authorization: Bearer <admin_token>
```

## 🧪 Тестирование

### 1. Тест API
```bash
python3 test_api.py
```

### 2. Тест в браузере
Откройте `test_telegram_auth.html` в браузере для тестирования в Telegram Web App.

### 3. Тест фронтенда
- Откройте `http://localhost:3000`
- Приложение автоматически попытается аутентифицироваться через Telegram
- Если аутентификация недоступна, появится кнопка "Авторизоваться"

## 🔐 Безопасность

### Валидация init_data
- Проверка подписи от Telegram (если настроен BOT_TOKEN)
- Парсинг и валидация данных пользователя
- Поддержка тестового режима без BOT_TOKEN

### Права доступа
- Только администраторы могут управлять другими администраторами
- JWT токены содержат информацию о правах пользователя
- Автоматическая проверка токенов на всех защищенных endpoints

## 📱 Использование в Telegram

### Для разработки
1. Создайте бота через @BotFather
2. Получите токен бота
3. Настройте Web App URL в настройках бота
4. Добавьте BOT_TOKEN в переменные окружения

### Для продакшена
1. Разместите фронтенд на HTTPS домене
2. Настройте Telegram Web App URL
3. Убедитесь, что BOT_TOKEN настроен правильно
4. Протестируйте аутентификацию в реальном Telegram

## 🎯 Логика работы

1. **Первый пользователь** автоматически становится администратором
2. **Последующие пользователи** создаются как обычные пользователи
3. **Администраторы** могут добавлять других пользователей как администраторов
4. **Аутентификация** происходит автоматически при открытии приложения в Telegram

## 🔄 Миграция данных

База данных автоматически создается с новой схемой при первом запуске. Если у вас есть существующие данные, выполните:

```bash
cd backend
python3 init_db_with_telegram.py
```

## 📝 Переменные окружения

Создайте файл `.env` в папке `backend`:

```env
BOT_TOKEN=your_telegram_bot_token
SECRET_KEY=your_jwt_secret_key
DATABASE_URL=sqlite:///./hr_admin.db
```

## 🎉 Готово!

Теперь ваше HR Admin Panel поддерживает:
- ✅ Бесшовную аутентификацию через Telegram
- ✅ Автоматическое управление администраторами
- ✅ Безопасную валидацию данных от Telegram
- ✅ Удобное управление правами доступа

Приложение готово к использованию в Telegram Mini Apps! 