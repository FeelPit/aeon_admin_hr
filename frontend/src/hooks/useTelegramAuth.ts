import { useState, useEffect } from 'react';
import { retrieveRawInitData } from '@telegram-apps/sdk';

interface TelegramUser {
  id: number;
  name: string;
  email?: string;
  telegram_id?: string;
  telegram_username?: string;
  is_admin: boolean;
}

interface AuthResponse {
  access_token: string;
  token_type: string;
  user: TelegramUser;
}

export const useTelegramAuth = () => {
  const [user, setUser] = useState<TelegramUser | null>(null);
  const [token, setToken] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const authenticate = async () => {
    try {
      setLoading(true);
      setError(null);

      // Получаем init_data от Telegram
      const initDataRaw = retrieveRawInitData();
      
      console.log('Retrieved init_data:', initDataRaw);
      
      if (!initDataRaw) {
        throw new Error('Не удалось получить данные от Telegram');
      }

      // Отправляем запрос на аутентификацию
      const response = await fetch('/api/telegram/telegram-auth', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          init_data: initDataRaw,
        }),
      });

      if (!response.ok) {
        const errorData = await response.json();
        console.error('Auth error response:', errorData);
        throw new Error(errorData.detail || 'Ошибка аутентификации');
      }

      const data: AuthResponse = await response.json();
      console.log('Auth success:', data);
      console.log('User is_admin:', data.user.is_admin);
      console.log('User is_admin type:', typeof data.user.is_admin);
      
      // Сохраняем токен и данные пользователя
      console.log('Saving user data to localStorage:', data.user);
      console.log('Saving user is_admin to localStorage:', data.user.is_admin);
      setToken(data.access_token);
      setUser(data.user);
      localStorage.setItem('access_token', data.access_token);
      localStorage.setItem('user', JSON.stringify(data.user));
      console.log('User data saved to localStorage');
      
      return data;
    } catch (err) {
      const errorMessage = err instanceof Error ? err.message : 'Неизвестная ошибка';
      console.error('Authentication error:', err);
      setError(errorMessage);
      throw err;
    } finally {
      setLoading(false);
    }
  };

  const logout = () => {
    setToken(null);
    setUser(null);
    localStorage.removeItem('access_token');
    localStorage.removeItem('user');
  };

  const checkAuth = async () => {
    const savedToken = localStorage.getItem('access_token');
    const savedUser = localStorage.getItem('user');

    console.log('checkAuth: savedToken exists:', !!savedToken);
    console.log('checkAuth: savedUser exists:', !!savedUser);

    if (savedToken && savedUser) {
      try {
        console.log('Found saved user data:', savedUser);
        const parsedUser = JSON.parse(savedUser);
        console.log('Parsed user data:', parsedUser);
        console.log('Parsed user is_admin:', parsedUser.is_admin);
        console.log('Parsed user is_admin type:', typeof parsedUser.is_admin);
        console.log('Boolean(parsedUser.is_admin):', Boolean(parsedUser.is_admin));
        
        // Проверяем валидность токена
        const response = await fetch('/api/telegram/profile', {
          headers: {
            Authorization: `Bearer ${savedToken}`,
          },
        });

        if (response.ok) {
          const userData = await response.json();
          console.log('Profile check - user data:', userData);
          console.log('Profile check - is_admin:', userData.is_admin);
          console.log('Profile check - is_admin type:', typeof userData.is_admin);
          setToken(savedToken);
          setUser(userData);
        } else {
          // Токен недействителен, очищаем
          logout();
        }
      } catch (err) {
        logout();
      }
    } else {
      // Пытаемся аутентифицироваться через Telegram
      try {
        await authenticate();
      } catch (err) {
        // Если аутентификация не удалась, оставляем пользователя неавторизованным
        console.log('Telegram аутентификация недоступна:', err);
      }
    }
    
    setLoading(false);
  };

  useEffect(() => {
    checkAuth();
  }, []);

  return {
    user,
    token,
    loading,
    error,
    authenticate,
    logout,
    checkAuth,
  };
}; 