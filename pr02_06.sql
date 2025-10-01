/*  Equipo 6:
    -Dueñas Jauregui Jenaro
    -Navarro Martínez Erick Israel
    -Rojas Lagunas Kevin Antonio
    -Serrano Álvarez Ricardo  */


/*1.2*/
DROP DATABASE IF EXISTS seguros_06;
CREATE DATABASE IF NOT EXISTS seguros_06;
USE seguros_06;


/*1.3*/
CREATE TABLE IF NOT EXISTS cliente(
    cliente_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(60) NOT NULL UNIQUE,
    PRIMARY KEY (cliente_id)
    );
DESCRIBE cliente;
SHOW CREATE TABLE cliente;


/*1.4*/
CREATE TABLE IF NOT EXISTS poliza(
    poliza_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    ramo CHAR(2) NOT NULL,
    prima INT UNSIGNED NULL,
    PRIMARY KEY (poliza_id)
);
DESCRIBE poliza;
SHOW CREATE TABLE poliza;


/*1.5*/
ALTER TABLE poliza
ADD COLUMN cliente_id INT UNSIGNED NOT NULL FIRST;

ALTER TABLE poliza
ADD COLUMN numero VARCHAR(20) NOT NULL UNIQUE;

ALTER TABLE poliza
ADD CONSTRAINT fk_poliza_cliente
FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id);
DESCRIBE poliza;
SHOW CREATE TABLE poliza;


/*1.6*/
INSERT IGNORE INTO cliente(nombre) VALUES
('Ana Pérez'),
('Luis Martínez'),
('Vanessa Hernández'),
('Carlos Ramírez'),
('María López');
SELECT * FROM cliente ORDER BY cliente_id;

INSERT IGNORE INTO poliza(cliente_id, ramo, prima, numero) VALUES
(1, 'AU', 18, 'AU-001-AP'),
(1, 'VI', 42, 'VI-002-AP'),
(3, 'GM', 25, 'GM-003-SH'),
(3, 'AU', 15, 'AU-004-SH'),
(3, 'HN', 9, 'HN-005-SH'),
(5, 'VI', 38, 'VI-006-ML');
SELECT * FROM poliza;


/*2.1*/
CREATE DATABASE IF NOT EXISTS carteraSeguros_06;
USE carteraSeguros_06;


/*2.2*/
CREATE TABLE IF NOT EXISTS asegurado(
    nombre VARCHAR(40) NOT NULL,
    f_nac DATE NOT NULL,
    pais VARCHAR(30) NOT NULL,
    f_def DATE NULL,
    genero VARCHAR(15) NOT NULL,
    PRIMARY KEY (nombre)
);
DESCRIBE asegurado;
SHOW CREATE TABLE asegurado;

CREATE TABLE IF NOT EXISTS poliza(
    nombre VARCHAR(40) NOT NULL,
    asegurado VARCHAR(40) NOT NULL,
    anio_emision INT NOT NULL,
    PRIMARY KEY (nombre),
    FOREIGN KEY (asegurado) REFERENCES asegurado(nombre)
);
DESCRIBE poliza;
SHOW CREATE TABLE poliza;

CREATE TABLE IF NOT EXISTS recibo(
    folio int NOT NULL, 
    anio_cobro int NOT NULL, 
    monto decimal(10,2) NOT NULL, 
    tipo varchar(10) NOT NULL,
    PRIMARY KEY (folio)
);
DESCRIBE recibo;
SHOW CREATE TABLE recibo;

CREATE TABLE IF NOT EXISTS aplicacion(
    folio int NOT NULL, 
    poliza varchar(40) NOT NULL, 
    cajero varchar(40) NOT NULL, 
    monto_aplicado int NOT NULL,
    FOREIGN KEY (folio) REFERENCES recibo(folio),
    FOREIGN KEY (poliza) REFERENCES poliza(nombre),
    PRIMARY KEY (folio, poliza)
);
DESCRIBE aplicacion;
SHOW CREATE TABLE aplicacion;


/*2.3*/
INSERT IGNORE INTO asegurado(nombre, f_nac, pais, f_def, genero) VALUES
('Juan García', '1985-03-21', 'Mexico', NULL, 'Masculino'),
('Laura Benítez', '1990-11-30', 'Mexico', NULL, 'Femenino'),
('Pedro Ruiz', '1978-06-01', 'Mexico', NULL, 'Masculino'),
('Daniela Ayala', '1992-06-03', 'Mexico', NULL, 'Femenino'),
('Héctor Barbosa', '1987-05-14', 'Mexico', NULL, 'Masculino'),
('Pablo Montero', '1989-04-01', 'Mexico', NULL, 'Masculino'),
('Vanessa Rach', '1983-02-28', 'Mexico', NULL, 'Femenino');
SELECT * FROM asegurado;

-- Asegurado faltante para respetar la FK
INSERT IGNORE INTO asegurado(nombre, f_nac, pais, f_def, genero) VALUES
('Sofía Rach', '1985-07-15', 'Mexico', NULL, 'Femenino');

-- Polizas
INSERT IGNORE INTO poliza(nombre, asegurado, anio_emision) VALUES
('Auto Básica', 'Juan García', 2010),
('Vida Integral', 'Pablo Montero', 2015),
('GMM Plan Oro', 'Sofía Rach', 2013),
('Auto Plus', 'Sofía Rach', 2018),
('Hogar Confort', 'Sofía Rach', 2011),
('Vida Tradicional', 'Héctor Barbosa', 2012),
('Hogar Clásico', 'Laura Benítez', 2020),
('Terceros Ampliada', 'Juan García', 2022),
('Auto Premium', 'Pedro Ruiz', 2008),
('Vida Dotal', 'Pedro Ruiz', 2014),
('GMM Familiar', 'Daniela Ayala', 2019);
SELECT * FROM poliza;

INSERT IGNORE INTO recibo(folio, anio_cobro, monto, tipo) VALUES
(519, 2022, 1050, 'CD'),
(5615, 2021, 1375, 'CD'),
(5801, 2020, 1815, 'PP'),
(44944, 2023, 1500, 'CD'),
(45818, 2023, 1800, 'CD'),
(47901, 2021, 3500, 'CD'),
(80264, 2022, 1250, 'CD'),
(198304, 2019, 800, 'PP'),
(415839, 2021, 1625, 'CD');
SELECT * FROM recibo;

INSERT IGNORE INTO aplicacion(folio, poliza, cajero, monto_aplicado) VALUES
(519, 'Terceros Ampliada', 'Sucursal Centro', 828),
(519, 'Hogar Confort', 'Sucursal Centro', 824),
(519, 'GMM Plan Oro', 'Sucursal Centro', 655),
(5615, 'Auto Básica', 'Kiosko Reforma', 740),
(5615, 'Auto Premium', 'Kiosko Reforma', 705),
(45818, 'GMM Plan Oro', 'App Movil', 505),
(47901, 'Auto Plus', 'Sucursal Norte', 2051),
(80264, 'Vida Integral', 'App Movil', 440),
(198304, 'Auto Básica', 'Call Center', 1302),
(198304, 'Auto Plus', 'Call Center', 1502),
(198304, 'Hogar Confort', 'Call Center', 916);
SELECT * FROM aplicacion;


