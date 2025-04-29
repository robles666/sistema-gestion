// api.js
import axios from 'axios';

const api = axios.create({
    baseURL: 'http://localhost:8080/api',
    headers: { 'Authorization': `Bearer ${localStorage.getItem('token')}` }
});

export default api;