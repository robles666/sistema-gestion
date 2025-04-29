-- Creación de la base de datos
DROP DATABASE IF EXISTS gestion_empresarial;
CREATE DATABASE gestion_empresarial CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gestion_empresarial;

-- Tabla de usuarios/autenticación
CREATE TABLE usuarios (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          username VARCHAR(50) UNIQUE NOT NULL,
                          password VARCHAR(255) NOT NULL,  -- Almacenar hash BCrypt
                          email VARCHAR(100) UNIQUE NOT NULL,
                          rol ENUM('ADMIN', 'SUPERVISOR', 'USUARIO') DEFAULT 'USUARIO',
                          activo BOOLEAN DEFAULT TRUE,
                          fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla de registros empresariales
CREATE TABLE registros (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           tipo ENUM('ENTRADA', 'SALIDA', 'TRANSFERENCIA', 'MERMA') NOT NULL,
                           cantidad DECIMAL(12, 2) NOT NULL,
                           descripcion TEXT,
                           fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
                           usuario_id INT NOT NULL,
                           FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

-- Tabla de asignaciones de trabajo
CREATE TABLE asignaciones (
                              id INT AUTO_INCREMENT PRIMARY KEY,
                              titulo VARCHAR(100) NOT NULL,
                              descripcion TEXT,
                              fecha_asignacion DATETIME DEFAULT CURRENT_TIMESTAMP,
                              fecha_limite DATETIME NOT NULL,
                              completada BOOLEAN DEFAULT FALSE,
                              usuario_asignado INT NOT NULL,
                              usuario_creador INT NOT NULL,
                              FOREIGN KEY (usuario_asignado) REFERENCES usuarios(id),
                              FOREIGN KEY (usuario_creador) REFERENCES usuarios(id)
);

-- Tabla para control de seguridad (Capa 2: IPs autorizadas)
CREATE TABLE ips_autorizadas (
                                 id INT AUTO_INCREMENT PRIMARY KEY,
                                 direccion_ip VARCHAR(45) UNIQUE NOT NULL,
                                 descripcion VARCHAR(100),
                                 fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla para control de intentos fallidos (Capa 3)
CREATE TABLE intentos_login (
                                id INT AUTO_INCREMENT PRIMARY KEY,
                                username VARCHAR(50) NOT NULL,
                                direccion_ip VARCHAR(45) NOT NULL,
                                fecha_intento DATETIME DEFAULT CURRENT_TIMESTAMP,
                                exitoso BOOLEAN DEFAULT FALSE,
                                INDEX idx_username (username),
                                INDEX idx_ip (direccion_ip)
);

-- Tabla de auditoría
CREATE TABLE auditoria (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           usuario_id INT,
                           accion VARCHAR(50) NOT NULL,
                           tabla_afectada VARCHAR(50),
                           registro_id INT,
                           detalles TEXT,
                           fecha_evento DATETIME DEFAULT CURRENT_TIMESTAMP,
                           direccion_ip VARCHAR(45),
                           FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);