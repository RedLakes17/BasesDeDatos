
-- Paso 1: Eliminar y crear la base de datos
DROP DATABASE IF EXISTS seguros_final;
CREATE DATABASE seguros_final;
USE seguros_final;

-- ##################################################################
-- Paso 2: Creación de tablas
-- ##################################################################

-- Catálogo de Ramos
CREATE TABLE c_ramos (
    id_ramo INT PRIMARY KEY,
    descripcion_ramo VARCHAR(50) NOT NULL
);

-- Catálogo de Ciudades
CREATE TABLE c_ciudades (
    id_ciudad INT PRIMARY KEY,
    nombre_ciudad VARCHAR(50) NOT NULL
);

-- Catálogo de Ocupaciones
CREATE TABLE c_ocupaciones (
    id_ocupacion INT PRIMARY KEY,
    descripcion_ocupacion VARCHAR(50) NOT NULL
);

-- Catálogo de Negocios (NUEVA TABLA)
CREATE TABLE c_negocios (
    id_negocio INT PRIMARY KEY,
    nombre_negocio VARCHAR(100) NOT NULL
);

-- Catálogo de Contratos (NUEVA TABLA)
CREATE TABLE c_contratos (
    id_contrato INT PRIMARY KEY,
    id_negocio INT,
    tipo_servicio VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_negocio) REFERENCES c_negocios(id_negocio)
);

-- Catálogo de Agentes
CREATE TABLE agentes (
    id_agente INT PRIMARY KEY,
    nombre_agente VARCHAR(100) NOT NULL,
    id_ciudad INT,
    FOREIGN KEY (id_ciudad) REFERENCES c_ciudades(id_ciudad)
);

-- Tabla de Clientes
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    genero CHAR(1) NOT NULL,
    id_ciudad INT,
    id_ocupacion INT,
    FOREIGN KEY (id_ciudad) REFERENCES c_ciudades(id_ciudad),
    FOREIGN KEY (id_ocupacion) REFERENCES c_ocupaciones(id_ocupacion)
);

-- Tabla de Pólizas (AHORA INCLUYE id_contrato)
CREATE TABLE polizas (
    id_poliza INT PRIMARY KEY,
    id_cliente INT,
    id_agente INT,
    id_ramo INT,
    id_contrato INT, -- RELACIONADO AL NEGOCIO
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    monto_prima DECIMAL(10, 2) NOT NULL,
    estado_poliza VARCHAR(15) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_agente) REFERENCES agentes(id_agente),
    FOREIGN KEY (id_ramo) REFERENCES c_ramos(id_ramo),
    FOREIGN KEY (id_contrato) REFERENCES c_contratos(id_contrato)
);

-- Tabla de Siniestros (utilizaremos la versión extendida de los inserts)
CREATE TABLE siniestros (
    id_siniestro INT PRIMARY KEY,
    id_poliza INT,
    fecha_siniestro DATE NOT NULL,
    monto_pago DECIMAL(10, 2),
    estado_siniestro VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_poliza) REFERENCES polizas(id_poliza)
);

-- ##################################################################
-- Paso 3: Inserción de datos de prueba (MÁS DATOS Y CONTEXTO EMPRESARIAL)
-- ##################################################################

-- Catálogos básicos (Iguales)
INSERT INTO c_ramos (id_ramo, descripcion_ramo) VALUES
(1, 'Autos'), (2, 'Vida'), (3, 'GMM'), (4, 'Daños');

INSERT INTO c_ciudades (id_ciudad, nombre_ciudad) VALUES
(101, 'CDMX'), (102, 'Guadalajara'), (103, 'Monterrey'), (104, 'Puebla'), (105, 'Tijuana');

INSERT INTO c_ocupaciones (id_ocupacion, descripcion_ocupacion) VALUES
(1, 'Ingeniero'), (2, 'Doctor'), (3, 'Estudiante'), (4, 'Administrativo'), (5, 'Vendedor');

-- Catálogo de Negocios
INSERT INTO c_negocios (id_negocio, nombre_negocio) VALUES
(1, 'Amazon México'), (2, 'Google LATAM'), (3, 'Apple Retail'), (4, 'Megacable'), (5, 'PyME Local');

-- Catálogo de Contratos
INSERT INTO c_contratos (id_contrato, id_negocio, tipo_servicio) VALUES
(1, 1, 'GMM Colectivo'), (2, 2, 'Flotilla Autos'), (3, 3, 'Daños Corporativos'), (4, 4, 'Vida Grupo'), (5, 5, 'Pólizas Individuales');

-- Agentes (Iguales)
INSERT INTO agentes (id_agente, nombre_agente, id_ciudad) VALUES
(1, 'Erick Matla', 101), (2, 'Ana Quiroz', 101), (3, 'Carlos Zavala', 102), (4, 'Sofía Ruiz', 103),
(5, 'Juana Hernández', 104), (6, 'Felipe Ángeles', 102), (7, 'Ricardo Salinas', 101), (8, 'Pablo Picasso', 105);

-- Clientes (30 Clientes, iguales para correlación)
INSERT INTO clientes (id_cliente, nombre, apellido_paterno, fecha_nacimiento, genero, id_ciudad, id_ocupacion) VALUES
(1, 'Juan', 'Pérez', '1985-05-15', 'M', 101, 1), (2, 'María', 'López', '1992-08-20', 'F', 101, 4),
(3, 'Pedro', 'Gómez', '1978-11-10', 'M', 102, 2), (4, 'Laura', 'García', '2001-02-25', 'F', 103, 3),
(5, 'Ana', 'Hernández', '1995-07-07', 'F', 104, 5), (6, 'Luis', 'Sánchez', '1980-03-30', 'M', 101, 1),
(7, 'Elena', 'Díaz', '1998-09-12', 'F', 102, 2), (8, 'Miguel', 'Rojas', '1975-01-22', 'M', 103, 4),
(9, 'Sofía', 'Castro', '1990-04-05', 'F', 104, 3), (10, 'Javier', 'Vidal', '1988-12-01', 'M', 101, 5),
(11, 'Carolina', 'Morales', '1993-06-18', 'F', 102, 1), (12, 'Roberto', 'Vega', '1982-10-28', 'M', 103, 2),
(13, 'Gabriela', 'Torres', '2000-03-03', 'F', 104, 4), (14, 'Andrés', 'Lara', '1970-11-11', 'M', 101, 3),
(15, 'Fernanda', 'Cruz', '1997-12-31', 'F', 102, 5), (16, 'David', 'Mendoza', '1984-08-16', 'M', 103, 1),
(17, 'Isabel', 'Flores', '1991-01-01', 'F', 104, 2), (18, 'Héctor', 'Chávez', '1987-02-02', 'M', 101, 4),
(19, 'Valeria', 'Reyes', '1994-07-23', 'F', 102, 3), (20, 'Pablo', 'Muñoz', '1979-04-14', 'M', 103, 5),
(21, 'Martha', 'Guzmán', '1981-06-01', 'F', 104, 1), (22, 'Raúl', 'Ochoa', '1977-08-08', 'M', 101, 2),
(23, 'Nicole', 'Blanco', '1996-02-14', 'F', 102, 4), (24, 'Alan', 'Delgado', '1989-10-20', 'M', 103, 5),
(25, 'Lorena', 'Rios', '2002-12-12', 'F', 104, 3), (26, 'Sergio', 'Vargas', '1983-05-23', 'M', 101, 1),
(27, 'Diana', 'Zúñiga', '1999-01-05', 'F', 102, 2), (28, 'Omar', 'Trejo', '1976-04-17', 'M', 103, 4),
(29, 'Karen', 'Mejía', '1991-07-28', 'F', 104, 5), (30, 'Hugo', 'Palacios', '1986-09-09', 'M', 101, 3),
(31, 'Héctor', 'Zamora', '2004-11-20', 'M', 105, 3),
(32, 'Brenda', 'Cruz', '1990-01-15', 'F', 101, 4),
(33, 'Alan', 'Mendieta', '1983-04-10', 'M', 102, 1),
(34, 'Ximena', 'Rojas', '1997-08-05', 'F', 104, 5),
(35, 'Diego', 'Ochoa', '1976-02-28', 'M', 103, 2);

-- Pólizas (40 Pólizas con Contratos Asignados)
INSERT INTO polizas (id_poliza, id_cliente, id_agente, id_ramo, id_contrato, fecha_emision, fecha_vencimiento, monto_prima, estado_poliza) VALUES
(1, 1, 1, 1, 2, '2025-01-01', '2026-01-01', 8500.50, 'Vigente'), (2, 2, 2, 2, 4, '2024-06-10', '2025-06-10', 4500.00, 'Vencida'),
(3, 3, 1, 3, 1, '2025-02-20', '2026-02-20', 12000.75, 'Vigente'), (4, 4, 3, 1, 5, '2024-09-15', '2025-09-15', 7200.25, 'Vigente'),
(5, 5, 2, 4, 3, '2025-03-05', '2026-03-05', 5100.00, 'Vigente'), (6, 6, 4, 2, 4, '2023-11-01', '2024-11-01', 3800.00, 'Vencida'),
(7, 7, 5, 3, 1, '2025-04-10', '2026-04-10', 15500.00, 'Vigente'), (8, 8, 6, 1, 2, '2024-12-20', '2025-12-20', 9800.00, 'Vigente'),
(9, 9, 7, 2, 4, '2025-05-01', '2026-05-01', 6300.00, 'Vigente'), (10, 10, 8, 4, 3, '2024-07-15', '2025-07-15', 4900.00, 'Vencida'),
(11, 11, 1, 1, 5, '2023-08-22', '2024-08-22', 6800.00, 'Vencida'), (12, 12, 2, 3, 1, '2025-06-01', '2026-06-01', 11500.00, 'Vigente'),
(13, 13, 3, 2, 4, '2024-10-01', '2025-10-01', 5400.00, 'Vigente'), (14, 14, 4, 4, 3, '2025-01-15', '2026-01-15', 3100.00, 'Vigente'),
(15, 15, 5, 1, 2, '2025-02-01', '2026-02-01', 10500.00, 'Vigente'), (16, 16, 6, 3, 1, '2024-05-20', '2025-05-20', 9000.00, 'Vencida'),
(17, 17, 7, 2, 4, '2025-03-15', '2026-03-15', 7800.00, 'Vigente'), (18, 18, 8, 4, 3, '2023-10-01', '2024-10-01', 4200.00, 'Vencida'),
(19, 19, 1, 1, 5, '2025-04-01', '2026-04-01', 7500.00, 'Vigente'), (20, 20, 2, 3, 1, '2024-11-10', '2025-11-10', 13200.00, 'Vigente'),
(21, 21, 5, 4, 3, '2025-05-10', '2026-05-10', 4800.00, 'Vigente'), (22, 22, 6, 1, 2, '2024-01-01', '2025-01-01', 6500.00, 'Vencida'),
(23, 23, 7, 2, 4, '2025-06-05', '2026-06-05', 8900.00, 'Vigente'), (24, 24, 8, 3, 1, '2023-07-25', '2024-07-25', 10000.00, 'Vencida'),
(25, 25, 1, 4, 3, '2025-01-20', '2026-01-20', 3500.00, 'Vigente'), (26, 26, 2, 1, 5, '2025-03-01', '2026-03-01', 9200.00, 'Vigente'),
(27, 27, 3, 2, 4, '2024-08-15', '2025-08-15', 5700.00, 'Vigente'), (28, 28, 4, 3, 1, '2025-02-14', '2026-02-14', 14000.00, 'Vigente'),
(29, 29, 5, 4, 3, '2024-04-04', '2025-04-04', 6000.00, 'Vencida'), (30, 30, 6, 1, 2, '2025-05-25', '2026-05-25', 8100.00, 'Vigente'),
(31, 1, 7, 2, 4, '2024-03-01', '2025-03-01', 5800.00, 'Vencida'), (32, 2, 8, 3, 1, '2025-01-01', '2026-01-01', 11000.00, 'Vigente'),
(33, 3, 1, 4, 3, '2023-09-10', '2024-09-10', 4100.00, 'Vencida'), (34, 4, 2, 1, 5, '2025-04-15', '2026-04-15', 7900.00, 'Vigente'),
(35, 5, 3, 2, 4, '2024-07-20', '2025-07-20', 6600.00, 'Vigente'), (36, 6, 4, 3, 1, '2023-12-01', '2024-12-01', 12500.00, 'Vencida'),
(37, 7, 5, 1, 2, '2025-01-25', '2026-01-25', 9500.00, 'Vigente'), (38, 8, 6, 4, 3, '2024-02-10', '2025-02-10', 4700.00, 'Vencida'),
(39, 9, 7, 2, 4, '2025-03-20', '2026-03-20', 7000.00, 'Vigente'), (40, 10, 8, 3, 1, '2024-08-05', '2025-08-05', 13500.00, 'Vigente');

-- Siniestros (Versión aumentada)
INSERT INTO siniestros (id_siniestro, id_poliza, fecha_siniestro, monto_pago, estado_siniestro) VALUES
(1, 1, '2025-03-10', 25000.00, 'Cerrado'), (2, 1, '2025-05-01', 5000.00, 'Cerrado'), (3, 1, '2025-06-15', 0.00, 'Rechazado'),
(4, 3, '2025-05-20', 8000.50, 'En proceso'), (5, 3, '2025-08-01', 2000.00, 'En proceso'),
(6, 4, '2025-01-30', 15000.00, 'Cerrado'),
(7, 6, '2024-02-18', 0.00, 'Rechazado'),
(8, 8, '2025-01-05', 5000.00, 'Cerrado'), (9, 8, '2025-02-28', 1000.00, 'Cerrado'), (10, 8, '2025-04-10', 0.00, 'Rechazado'),
(11, 12, '2025-07-01', 12000.00, 'En proceso'), (12, 12, '2025-07-20', 3000.00, 'Cerrado'),
(13, 15, '2025-03-25', 12000.00, 'Cerrado'), (14, 15, '2025-05-05', 1000.00, 'En proceso'),
(15, 19, '2025-04-15', 4000.00, 'Cerrado'), (16, 19, '2025-05-01', 2000.00, 'En proceso'),
(17, 26, '2025-04-20', 7500.00, 'En proceso'),
(18, 34, '2025-05-20', 3000.00, 'Cerrado'), (19, 34, '2025-06-01', 1000.00, 'Cerrado'),
(20, 37, '2025-02-01', 2000.00, 'Cerrado'),
(21, 40, '2024-09-01', 15000.00, 'Vencido'),
(22, 1, '2025-07-15', 500.00, 'En proceso'); -- Siniestro extra para Póliza 1