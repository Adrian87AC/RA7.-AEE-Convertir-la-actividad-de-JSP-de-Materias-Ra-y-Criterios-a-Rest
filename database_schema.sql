-- =====================================================
-- Base de datos para Sistema de Gestión Académica
-- CRUD con JSP, MySQL y Bootstrap
-- =====================================================

DROP DATABASE IF EXISTS gestion_academica;
CREATE DATABASE gestion_academica CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gestion_academica;

-- =====================================================
-- Tabla: Asignaturas
-- =====================================================
CREATE TABLE asignaturas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    descripcion TEXT,
    creditos INT DEFAULT 0,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_codigo (codigo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- Tabla: Resultados de Aprendizaje (RA)
-- =====================================================
CREATE TABLE resultados_aprendizaje (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL,
    descripcion TEXT NOT NULL,
    asignatura_id INT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (asignatura_id) REFERENCES asignaturas(id) ON DELETE CASCADE,
    INDEX idx_asignatura (asignatura_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- Tabla: Criterios de Evaluación
-- =====================================================
CREATE TABLE criterios_evaluacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL,
    descripcion TEXT NOT NULL,
    resultado_aprendizaje_id INT NOT NULL,
    ponderacion DECIMAL(5,2) DEFAULT 0.00,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (resultado_aprendizaje_id) REFERENCES resultados_aprendizaje(id) ON DELETE CASCADE,
    INDEX idx_resultado (resultado_aprendizaje_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- Datos de ejemplo
-- =====================================================

-- Insertar asignaturas de ejemplo
INSERT INTO asignaturas (nombre, codigo, descripcion, creditos) VALUES
('Desarrollo Web en Entorno Cliente', 'DWEC', 'Desarrollo de aplicaciones web del lado del cliente', 6),
('Desarrollo Web en Entorno Servidor', 'DWES', 'Desarrollo de aplicaciones web del lado del servidor', 8),
('Bases de Datos', 'BBDD', 'Diseño y administración de bases de datos', 6);

-- Insertar resultados de aprendizaje para DWEC
INSERT INTO resultados_aprendizaje (codigo, descripcion, asignatura_id) VALUES
('RA1', 'Selecciona las arquitecturas y tecnologías de programación sobre clientes Web', 1),
('RA2', 'Escribe sentencias simples aplicando la sintaxis del lenguaje', 1),
('RA6', 'Desarrolla aplicaciones Web interactivas integrando mecanismos de manejo de eventos', 1);

-- Insertar criterios de evaluación para RA6
INSERT INTO criterios_evaluacion (codigo, descripcion, resultado_aprendizaje_id, ponderacion) VALUES
('CEV-a', 'Se han analizado las tecnologías que permiten el acceso mediante programación a la información', 3, 10.00),
('CEV-b', 'Se han creado aplicaciones que establezcan conexiones con bases de datos', 3, 15.00),
('CEV-c', 'Se ha recuperado información almacenada en bases de datos', 3, 15.00),
('CEV-d', 'Se ha publicado en aplicaciones Web la información recuperada', 3, 15.00),
('CEV-e', 'Se han utilizado conjuntos de datos para almacenar la información', 3, 10.00),
('CEV-f', 'Se han creado aplicaciones Web que permitan la actualización y eliminación de información', 3, 20.00),
('CEV-g', 'Se han utilizado transacciones para mantener la consistencia de la información', 3, 10.00),
('CEV-h', 'Se han probado y documentado las aplicaciones', 3, 5.00);

-- Verificar la estructura
SHOW TABLES;