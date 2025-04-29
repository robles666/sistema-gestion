import api from './api';

export const login = async (credentials) => {
    try {
        const response = await api.post('/auth/login', credentials);
        localStorage.setItem('token', response.data.token);
        return response.data;
    } catch (error) {
        throw new Error(error.response?.data?.message || 'Error de autenticación');
    }
};

export const logout = () => {
    localStorage.removeItem('token');
};

export const getCurrentUser = () => {
    const token = localStorage.getItem('token');
    if (!token) return null;

    // Decodificar token (sin verificación, solo para UI)
    try {
        const payload = JSON.parse(atob(token.split('.')[1]));
        return {
            username: payload.sub,
            rol: payload.rol
        };
    } catch {
        return null;
    }
};