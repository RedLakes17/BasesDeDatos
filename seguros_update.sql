-- ##################################################################
-- Script para la Base de Datos de Seguros de la practica 4 (VERSIÓN EXTENDIDA)
-- ##################################################################

-- Paso 1: Eliminar y crear la base de datos
DROP DATABASE IF EXISTS seguros_update;
CREATE DATABASE seguros_update;
USE seguros_update;

-- ##################################################################
-- Paso 2: Creación de tablas
-- ##################################################################

-- Catálogo de Ramos
CREATE TABLE c_ramos (
    id_ramo INT PRIMARY KEY,
    descripcion_ramo VARCHAR(50) NOT NULL
);

-- Catálogo de Paquetes
CREATE TABLE c_paquetes (
    id_paquete INT PRIMARY KEY,
    nombre_paquete VARCHAR(50) NOT NULL,
    id_ramo INT,
    FOREIGN KEY (id_ramo) REFERENCES c_ramos(id_ramo)
);

-- Catálogo de Coberturas
CREATE TABLE c_coberturas (
    id_cobertura INT PRIMARY KEY,
    nombre_cobertura VARCHAR(50) NOT NULL,
    id_paquete INT,
    FOREIGN KEY (id_paquete) REFERENCES c_paquetes(id_paquete)
);

-- Catálogo de Agentes
CREATE TABLE agentes (
    id_agente INT PRIMARY KEY,
    nombre_agente VARCHAR(100) NOT NULL
);

-- Tabla de Clientes
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    genero CHAR(1) NOT NULL
);

-- Tabla de Pólizas
CREATE TABLE polizas (
    id_poliza INT PRIMARY KEY,
    id_cliente INT,
    id_agente INT,
    id_ramo INT,
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    monto_prima DECIMAL(10, 2) NOT NULL,
    estado_poliza VARCHAR(15) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_agente) REFERENCES agentes(id_agente),
    FOREIGN KEY (id_ramo) REFERENCES c_ramos(id_ramo)
);

-- Tabla de Siniestros
CREATE TABLE siniestros (
    id_siniestro INT PRIMARY KEY,
    id_poliza INT,
    fecha_siniestro DATE NOT NULL,
    monto_pago DECIMAL(10, 2),
    estado_siniestro VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_poliza) REFERENCES polizas(id_poliza)
);

-- ##################################################################
-- Paso 3: Inserción de datos de prueba
-- ##################################################################

-- Datos de Catálogo de Ramos (Iguales)
INSERT INTO c_ramos (id_ramo, descripcion_ramo) VALUES
(1, 'Autos'),
(2, 'Vida'),
(3, 'GMM'),
(4, 'Daños');

-- Datos de Catálogo de Paquetes (Añadimos más opciones)
INSERT INTO c_paquetes (id_paquete, nombre_paquete, id_ramo) VALUES
(101, 'Básico', 1), (102, 'Amplio', 1), (103, 'Premium', 1), (104, 'Limitada', 1),
(201, 'Individual', 2), (202, 'Familiar', 2), (203, 'Total', 2),
(301, 'Esencial', 3), (302, 'Completo', 3), (303, 'Internacional', 3),
(401, 'Hogar', 4), (402, 'Comercio', 4), (403, 'Aparatos', 4);

-- Datos de Catálogo de Coberturas (Más detalle)
INSERT INTO c_coberturas (id_cobertura, nombre_cobertura, id_paquete) VALUES
(1001, 'Daños a terceros', 101), (1002, 'Robo total', 102), (1003, 'Daños materiales', 102), (1004, 'Auto sustituto', 103), (1005, 'Grúa 24/7', 103), (1006, 'Asistencia vial', 104),
(2001, 'Muerte accidental', 201), (2002, 'Invalidez total', 202), (2003, 'Gastos funerarios', 203),
(3001, 'Atención hospitalaria', 301), (3002, 'Maternidad', 302), (3003, 'Deducible 0', 303), (3004, 'Emergencias', 303),
(4001, 'Incendio', 401), (4002, 'Fenómenos hidrometeorológicos', 402), (4003, 'Robo de contenidos', 401), (4004, 'Fallo eléctrico', 403);

-- Datos de Agentes (Más agentes)
INSERT INTO agentes (id_agente, nombre_agente) VALUES
(1, 'Erick Matla'), (2, 'Ana Quiroz'), (3, 'Carlos Zavala'), (4, 'Mario Gómez'),
(5, 'Juana Hernández'), (6, 'Felipe Ángeles'), (7, 'Sofía Del Valle'), (8, 'Ricardo Salinas');

-- Datos de Clientes (Muchos más clientes)
INSERT INTO clientes (id_cliente, nombre, apellido_paterno, fecha_nacimiento, genero) VALUES
(1, 'Juan', 'Pérez', '1985-05-15', 'M'), (2, 'María', 'López', '1992-08-20', 'F'),
(3, 'Pedro', 'Gómez', '1978-11-10', 'M'), (4, 'Laura', 'García', '2001-02-25', 'F'),
(5, 'Ana', 'Hernández', '1995-07-07', 'F'), (6, 'Luis', 'Sánchez', '1980-03-30', 'M'),
(7, 'Elena', 'Díaz', '1998-09-12', 'F'), (8, 'Miguel', 'Rojas', '1975-01-22', 'M'),
(9, 'Sofía', 'Castro', '1990-04-05', 'F'), (10, 'Javier', 'Vidal', '1988-12-01', 'M'),
(11, 'Carolina', 'Morales', '1993-06-18', 'F'), (12, 'Roberto', 'Vega', '1982-10-28', 'M'),
(13, 'Gabriela', 'Torres', '2000-03-03', 'F'), (14, 'Andrés', 'Lara', '1970-11-11', 'M'),
(15, 'Fernanda', 'Cruz', '1997-12-31', 'F'), (16, 'David', 'Mendoza', '1984-08-16', 'M'),
(17, 'Isabel', 'Flores', '1991-01-01', 'F'), (18, 'Héctor', 'Chávez', '1987-02-02', 'M'),
(19, 'Valeria', 'Reyes', '1994-07-23', 'F'), (20, 'Pablo', 'Muñoz', '1979-04-14', 'M');

-- Datos de Pólizas (Muchas más pólizas con distintos agentes y ramos)
INSERT INTO polizas (id_poliza, id_cliente, id_agente, id_ramo, fecha_emision, fecha_vencimiento, monto_prima, estado_poliza) VALUES
(1, 1, 1, 1, '2025-01-01', '2026-01-01', 8500.50, 'Vigente'), (2, 2, 2, 2, '2024-06-10', '2025-06-10', 4500.00, 'Vencida'),
(3, 3, 1, 3, '2025-02-20', '2026-02-20', 12000.75, 'Vigente'), (4, 4, 3, 1, '2024-09-15', '2025-09-15', 7200.25, 'Vigente'),
(5, 5, 2, 4, '2025-03-05', '2026-03-05', 5100.00, 'Vigente'), (6, 6, 4, 2, '2023-11-01', '2024-11-01', 3800.00, 'Vencida'),
(7, 7, 5, 3, '2025-04-10', '2026-04-10', 15500.00, 'Vigente'), (8, 8, 6, 1, '2024-12-20', '2025-12-20', 9800.00, 'Vigente'),
(9, 9, 7, 2, '2025-05-01', '2026-05-01', 6300.00, 'Vigente'), (10, 10, 8, 4, '2024-07-15', '2025-07-15', 4900.00, 'Vencida'),
(11, 11, 1, 1, '2023-08-22', '2024-08-22', 6800.00, 'Vencida'), (12, 12, 2, 3, '2025-06-01', '2026-06-01', 11500.00, 'Vigente'),
(13, 13, 3, 2, '2024-10-01', '2025-10-01', 5400.00, 'Vigente'), (14, 14, 4, 4, '2025-01-15', '2026-01-15', 3100.00, 'Vigente'),
(15, 15, 5, 1, '2025-02-01', '2026-02-01', 10500.00, 'Vigente'), (16, 16, 6, 3, '2024-05-20', '2025-05-20', 9000.00, 'Vencida'),
(17, 17, 7, 2, '2025-03-15', '2026-03-15', 7800.00, 'Vigente'), (18, 18, 8, 4, '2023-10-01', '2024-10-01', 4200.00, 'Vencida'),
(19, 19, 1, 1, '2025-04-01', '2026-04-01', 7500.00, 'Vigente'), (20, 20, 2, 3, '2024-11-10', '2025-11-10', 13200.00, 'Vigente'),
(21, 1, 5, 4, '2025-05-10', '2026-05-10', 4800.00, 'Vigente'), (22, 2, 6, 1, '2024-01-01', '2025-01-01', 6500.00, 'Vencida'),
(23, 3, 7, 2, '2025-06-05', '2026-06-05', 8900.00, 'Vigente'), (24, 4, 8, 3, '2023-07-25', '2024-07-25', 10000.00, 'Vencida'),
(25, 5, 1, 4, '2025-01-20', '2026-01-20', 3500.00, 'Vigente'), (26, 6, 2, 1, '2025-03-01', '2026-03-01', 9200.00, 'Vigente'),
(27, 7, 3, 2, '2024-08-15', '2025-08-15', 5700.00, 'Vigente'), (28, 8, 4, 3, '2025-02-14', '2026-02-14', 14000.00, 'Vigente'),
(29, 9, 5, 4, '2024-04-04', '2025-04-04', 6000.00, 'Vencida'), (30, 10, 6, 1, '2025-05-25', '2026-05-25', 8100.00, 'Vigente');

-- Datos de Siniestros (Más siniestros para diferentes pólizas)
INSERT INTO siniestros (id_siniestro, id_poliza, fecha_siniestro, monto_pago, estado_siniestro) VALUES
(1, 1, '2025-03-10', 25000.00, 'Cerrado'), (2, 2, '2024-07-05', 0.00, 'Rechazado'),
(3, 3, '2025-05-20', 8000.50, 'En proceso'), (4, 4, '2025-01-30', 15000.00, 'Cerrado'),
(5, 6, '2024-02-18', 0.00, 'Rechazado'), (6, 8, '2025-01-05', 5000.00, 'Cerrado'),
(7, 12, '2025-07-01', 0.00, 'En proceso'), (8, 15, '2025-03-25', 12000.00, 'Cerrado'),
(9, 16, '2024-06-01', 0.00, 'Rechazado'), (10, 19, '2025-04-15', 4000.00, 'Cerrado'),
(11, 22, '2024-02-10', 30000.00, 'Cerrado'), (12, 24, '2023-09-01', 0.00, 'Rechazado'),
(13, 26, '2025-04-20', 7500.00, 'En proceso'), (14, 29, '2024-05-01', 0.00, 'Rechazado'),
(15, 30, '2025-06-01', 1000.00, 'En proceso');