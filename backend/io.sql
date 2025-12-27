-- Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS `inventario_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Usar la base de datos
USE `inventario_db`;

-- Tabla: productos
CREATE TABLE IF NOT EXISTS `productos` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(255) NOT NULL,
    `codigo` VARCHAR(100) NOT NULL UNIQUE,
    `descripcion` TEXT,
    `categoria` VARCHAR(100),
    `precio` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    `stock` INT NOT NULL DEFAULT 0,
    `fecha_creacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: usuarios (con contraseña encriptada)
CREATE TABLE IF NOT EXISTS `usuarios` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL, -- Almacenará hash de bcrypt
    `rol` ENUM('admin', 'usuario') NOT NULL DEFAULT 'usuario',
    `fecha_registro` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insertar un usuario administrador predeterminado (contraseña: admin123)
-- ⚠️ IMPORTANTE: En producción, cámbialo o elimina esta línea
INSERT INTO `usuarios` (`nombre`, `email`, `password`, `rol`)
VALUES (
    'Admin',
    'admin@inventario.com',
    '$2a$10$wK1d5lD8XqRfT6x7s9Qq.eDv4mWzQ1J1N3rZ0T6j4V8v7vZ1s1T2e', -- hash de "admin123"
    'admin'
)
ON DUPLICATE KEY UPDATE email = email;

-- Tabla: movimientos (entradas y salidas de inventario)
CREATE TABLE IF NOT EXISTS `movimientos` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `producto_id` INT NOT NULL,
    `tipo` ENUM('entrada', 'salida') NOT NULL,
    `cantidad` INT NOT NULL,
    `fecha` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`producto_id`) REFERENCES `productos`(`id`) ON DELETE CASCADE
);