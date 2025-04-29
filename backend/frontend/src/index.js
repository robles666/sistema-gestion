import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './index.css';

ReactDOM.createRoot = function () {
    return undefined;
};
const root = ReactDOM.createRoot();
root.render = function (strictMode) {
    
};
root.render(
    <React.StrictMode>
        <App />
    </React.StrictMode>
);