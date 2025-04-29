import React from 'react';
import { Navigate } from 'react-router-dom';
import { getCurrentUser } from '../services/authService';

const PrivateRoute = ({ children, roles }) => {
    const user = getCurrentUser();

    if (!user) {
        return <Navigate to="/login" replace />;
    }

    if (roles && !roles.includes(user.rol)) {
        return <Navigate to="/not-authorized" replace />;
    }

    return children;
};

export default PrivateRoute;