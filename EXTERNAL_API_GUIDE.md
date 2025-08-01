# 🌐 Внешний API для интеграции

## 📋 Обзор

Внешний API позволяет интегрировать HR Admin Panel с внешними сайтами и приложениями. API поддерживает отправку результатов интервью и получение данных кандидатов.

## 🌍 Внешний доступ

### Локальное тестирование
```bash
# Запуск backend
./start-backend.sh

# Тестирование API
./test-external-api.sh

# Веб-интерфейс для тестирования
http://localhost:8001/test-external-api
```

### Внешний доступ через туннель
```bash
# Настройка Cloudflare Tunnel
./start-cloudflare.sh

# Или Ngrok
./setup-ngrok-tunnel.sh

# Использование API через туннель
curl -X POST https://your-tunnel-url.com/api/external/submit-results \
  -H "Content-Type: application/json" \
  -d '{"full_name": "Тест", "results": "Результаты"}'
```

### URL для интеграции
- **Локально**: `http://localhost:8001`
- **Через туннель**: `https://your-tunnel-url.com`
- **Прямой доступ**: `http://46.211.115.16:8001` (если настроен проброс портов)

## 🚀 Endpoints

### 1. Отправка результатов интервью

**URL:** `POST /api/external/submit-results`

**Описание:** Отправка результатов интервью от внешнего сайта

**Поддерживаемые форматы:**
- JSON
- Form Data

**Параметры:**
```json
{
  "full_name": "Иван Иванов",
  "telegram_username": "@ivan_ivanov",
  "telegram_id": "123456789",
  "results": "Результаты интервью..."
}
```

**Обязательные поля:**
- `full_name` - ФИО кандидата

**Ответ (успех):**
```json
{
  "success": true,
  "message": "Результаты интервью успешно сохранены",
  "candidate_id": 123,
  "timestamp": "2025-08-01T14:30:00.000Z"
}
```

**Ответ (ошибка):**
```json
{
  "detail": "full_name обязателен"
}
```

### 2. Получение результатов интервью

**URL:** `GET /api/external/results/{candidate_id}`

**Описание:** Получение результатов интервью кандидата

**Параметры пути:**
- `candidate_id` - ID кандидата

**Ответ (успех):**
```json
{
  "id": 123,
  "full_name": "Иван Иванов",
  "telegram_username": "@ivan_ivanov",
  "results": "Результаты интервью...",
  "status": "ожидает",
  "created_at": "2025-08-01T14:30:00.000Z"
}
```

**Ответ (ошибка):**
```json
{
  "detail": "Кандидат не найден"
}
```

### 3. Проверка здоровья API

**URL:** `GET /api/external/health`

**Описание:** Проверка доступности внешнего API

**Ответ:**
```json
{
  "status": "healthy",
  "service": "external-api",
  "timestamp": "2025-08-01T14:30:00.000Z"
}
```

## 🔧 CORS настройки

API поддерживает запросы с любых источников:

```javascript
// Разрешенные методы
"GET", "POST", "PUT", "DELETE", "PATCH", "OPTIONS", "HEAD"

// Разрешенные заголовки
"Accept", "Content-Type", "Authorization", "X-Requested-With", "Origin", "*"

// Разрешенные источники
"*" // Все источники
```

## 📝 Примеры использования

### JavaScript (fetch)

```javascript
// Отправка результатов
async function submitResults(data) {
  try {
    // Замените на ваш URL туннеля
    const API_URL = 'https://your-tunnel-url.com'; // или http://localhost:8001 для локального тестирования
    
    const response = await fetch(`${API_URL}/api/external/submit-results`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: JSON.stringify({
        full_name: data.fullName,
        telegram_username: data.telegramUsername,
        telegram_id: data.telegramId,
        results: data.results
      })
    });

    const result = await response.json();
    
    if (response.ok) {
      console.log('Успешно:', result);
      return result;
    } else {
      console.error('Ошибка:', result);
      throw new Error(result.detail);
    }
  } catch (error) {
    console.error('Ошибка запроса:', error);
    throw error;
  }
}

// Получение результатов
async function getResults(candidateId) {
  try {
    const response = await fetch(`http://localhost:8001/api/external/results/${candidateId}`);
    const result = await response.json();
    
    if (response.ok) {
      return result;
    } else {
      throw new Error(result.detail);
    }
  } catch (error) {
    console.error('Ошибка получения результатов:', error);
    throw error;
  }
}
```

### cURL

```bash
# Отправка результатов
curl -X POST http://localhost:8001/api/external/submit-results \
  -H "Content-Type: application/json" \
  -d '{
    "full_name": "Иван Иванов",
    "telegram_username": "@ivan_ivanov",
    "results": "Результаты интервью..."
  }'

# Получение результатов
curl http://localhost:8001/api/external/results/123

# Проверка здоровья
curl http://localhost:8001/api/external/health
```

### Python (requests)

```python
import requests
import json

# Отправка результатов
def submit_results(data):
    url = "http://localhost:8001/api/external/submit-results"
    headers = {
        "Content-Type": "application/json",
        "Accept": "application/json"
    }
    
    response = requests.post(url, json=data, headers=headers)
    
    if response.status_code == 200:
        return response.json()
    else:
        raise Exception(response.json()["detail"])

# Пример использования
try:
    result = submit_results({
        "full_name": "Иван Иванов",
        "telegram_username": "@ivan_ivanov",
        "results": "Результаты интервью..."
    })
    print("Успешно:", result)
except Exception as e:
    print("Ошибка:", e)
```

## 🧪 Тестирование

### Веб-интерфейс для тестирования

Откройте в браузере: `http://localhost:8001/test-external-api`

Этот интерфейс позволяет:
- Тестировать отправку результатов
- Проверять ответы API
- Отлаживать CORS проблемы

### Автоматические тесты

```bash
# Тест подключения
curl http://localhost:8001/api/external/health

# Тест отправки результатов
curl -X POST http://localhost:8001/api/external/submit-results \
  -H "Content-Type: application/json" \
  -d '{"full_name": "Тестовый кандидат", "results": "Тестовые результаты"}'
```

## 🔒 Безопасность

### Валидация данных
- Проверка обязательных полей
- Валидация формата данных
- Обработка ошибок

### Ограничения
- Нет аутентификации (для простоты интеграции)
- Рекомендуется использовать HTTPS в продакшене
- Ограничение размера запросов

## 📊 Интеграция с системой

### Автоматические действия
При отправке результатов через внешний API:

1. **Создание кандидата** - автоматически создается запись в базе данных
2. **Интеграция с Notion** - создается карточка в Notion (если настроено)
3. **Уведомления** - отправляется уведомление администраторам в Telegram
4. **Статус** - кандидат получает статус "ожидает"

### Логирование
Все запросы логируются в консоль сервера:
```
INFO: Внешний API: получены результаты от Иван Иванов
INFO: Создан кандидат ID: 123
INFO: Уведомление отправлено администраторам
```

## 🚨 Устранение неполадок

### Ошибка 405 Method Not Allowed
**Причина:** Неправильный HTTP метод
**Решение:** Используйте POST для отправки результатов

### Ошибка CORS
**Причина:** Блокировка браузером
**Решение:** Проверьте настройки CORS в main.py

### Ошибка 500 Internal Server Error
**Причина:** Проблемы с базой данных
**Решение:** Проверьте логи сервера

### Ошибка 400 Bad Request
**Причина:** Неправильные данные
**Решение:** Проверьте обязательные поля

## 📈 Мониторинг

### Метрики
- Количество запросов к внешнему API
- Успешность обработки запросов
- Время ответа API

### Логи
- Все запросы к внешнему API
- Ошибки валидации
- Проблемы интеграции

## 🎯 Рекомендации

1. **Используйте HTTPS** в продакшене
2. **Валидируйте данные** на стороне клиента
3. **Обрабатывайте ошибки** в клиентском коде
4. **Логируйте запросы** для отладки
5. **Тестируйте интеграцию** перед развертыванием

## 📞 Поддержка

При возникновении проблем:
1. Проверьте логи сервера
2. Используйте тестовый интерфейс
3. Проверьте настройки CORS
4. Убедитесь в доступности базы данных 