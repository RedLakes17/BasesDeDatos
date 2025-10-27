/* Proyecto Integrador Etapa 2. Bases de dato 
Equipo 6:
    -Dueñas Jauregui Jenaro
    -Navarro Martínez Erick Israel
    -Rojas Lagunas Kevin Antonio
    -Serrano Álvarez Ricardo  */

-- Dropeamos y creamos la base de datos
DROP DATABASE IF EXISTS candela_06;
CREATE DATABASE IF NOT EXISTS candela_06;
USE candela_06;



-- Creamos la primera tabla del DER, de izquierda a derecha
CREATE TABLE alumno(
    id_alumno INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(60) NOT NULL,
    edad TINYINT UNSIGNED NOT NULL,
    sexo VARCHAR(20),
    estatus VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_alumno) 
);



-- Creamos la tabla curso
CREATE TABLE curso(
    id_curso INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre_curso VARCHAR(60) NOT NULL,
    cupo INT UNSIGNED NOT NULL,
    horario_dias VARCHAR(60) NOT NULL,
    duracion_semanas INT UNSIGNED NOT NULL,
    precio DECIMAL(7,2) NOT NULL,
    nivel TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY(id_curso)
);



-- Creamos la tabla profesor
CREATE TABLE profesor(
    id_profesor INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(60) NOT NULL,
    edad TINYINT UNSIGNED NOT NULL,
    sexo VARCHAR(20),
    rfc VARCHAR(13) NOT NULL UNIQUE, -- el rfc es unico y tiene 13 caracteres
    fecha_contratacion DATE NOT NULL,
    sueldo DECIMAL(10,2) UNSIGNED NOT NULL, -- suficiente espacio para registrar grandes cantidades
    PRIMARY KEY (id_profesor)
);



-- Creamos la tabla sucursal
CREATE TABLE sucursal(
    id_sucursal INT UNSIGNED NOT NULL AUTO_INCREMENT,
    ubicacion VARCHAR(60) NOT NULL,
    telefono VARCHAR(20) NOT NULL UNIQUE,
    PRIMARY KEY (id_sucursal)
);



-- Creamos la tabla eventos
CREATE TABLE eventos(
    id_evento INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre_evento VARCHAR(60) NOT NULL,
    id_sucursal INT UNSIGNED NOT NULL,
    fecha DATE NOT NULL,
    num_asistentes INT UNSIGNED NOT NULL,
    costo_entrada DECIMAL(7,2) UNSIGNED NOT NULL,
    PRIMARY KEY (id_evento),
    CONSTRAINT fk_sucursal_eventos -- relacion con la tabla sucrusal
        FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal)
        ON DELETE CASCADE -- Para que se eliminen o actualicen registros si se alteran en la tabla sucursal
        ON UPDATE CASCADE
);



-- Creamos la tabla personal
CREATE TABLE personal(
    id_personal INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(60) NOT NULL,
    id_sucursal INT UNSIGNED NOT NULL,
    puesto VARCHAR(60) NOT NULL,
    rfc VARCHAR(13) NOT NULL UNIQUE,
    fecha_contratacion DATE NOT NULL,
    sueldo DECIMAL(10,2) UNSIGNED NOT NULL,
    PRIMARY KEY (id_personal),
    CONSTRAINT fk_sucursal_personal
        FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);



-- Creamos la tabla puente que conecta a alumno y curso en una relacion muchos a muchos
CREATE TABLE alumno_curso(
    id_alumno INT UNSIGNED NOT NULL,
    id_curso INT UNSIGNED NOT NULL,
    fecha_inscripcion DATE NOT NULL,
    PRIMARY KEY (id_alumno, id_curso),
    CONSTRAINT fk_alumno_alumno_curso
        FOREIGN KEY (id_alumno) REFERENCES alumno(id_alumno)
        ON DELETE CASCADE
        ON UPDATE CASCADE, -- Para que se eliminen o actulicen los registros al eliminar o acualizar registros en la tabla alumno
    CONSTRAINT fk_curso_alumno_curso
        FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);



-- Creamos la tabla puente que conecta a curso y profesor en una relacion muchos a muchos
CREATE TABLE curso_profesor(
    id_curso INT UNSIGNED NOT NULL,
    id_profesor INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_curso, id_profesor),
    CONSTRAINT fk_curso_curso_profesor
        FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_profesor_curso_profesor
        FOREIGN KEY (id_profesor) REFERENCES profesor(id_profesor)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);



-- Creamos tabla puente que conecta curso con sucursal
CREATE TABLE curso_sucursal(
    id_curso INT UNSIGNED NOT NULL,
    id_sucursal INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_curso, id_sucursal),
    CONSTRAINT fk_curso_curso_sucursal
        FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_sucursal_curso_sucursal
        FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);




/*Ahora insertamos los datos. Esto se realizo con la ayuda de la inteligencia artificial CHAT GPT 5 en su modo de pensamiento ampliado. Se fueron pidiendo
entidad por entidad cuidando la coherencia de los datos, por ejemplo, la unica entidad con 100 registros es la tabla alumnos ya que entidades como 
cursos, sucursales, personal y eventos tienen naturalmente menos registros que el numero de alumnos.*/

-- Para la tabla alumno (100 registros)
INSERT INTO alumno (nombre, edad, sexo, estatus) VALUES
('Ana Lopez', 22, 'F', 'Activo'),
('Carlos Hernandez', 25, 'M', 'Activo'),
('Maria Garcia', 20, 'F', 'Activo'),
('Jose Martinez', 28, 'M', 'Inactivo'),
('Daniela Torres', 19, 'F', 'Activo'),
('Luis Ramirez', 31, 'M', 'Activo'),
('Fernanda Cruz', 24, 'F', 'Activo'),
('Miguel Sanchez', 27, 'M', 'Baja'),
('Valeria Flores', 23, 'F', 'Activo'),
('Juan Perez', 26, 'M', 'Activo'),
('Ximena Ortiz', 21, 'F', 'Activo'),
('Pedro Morales', 30, 'M', 'Suspendido'),
('Andrea Navarro', 18, 'F', 'Activo'),
('Ricardo Alvarez', 29, 'M', 'Activo'),
('Camila Mendoza', 22, 'F', 'Activo'),
('Jorge Dominguez', 33, 'M', 'Inactivo'),
('Paola Rojas', 20, 'F', 'Activo'),
('Sergio Castillo', 28, 'M', 'Activo'),
('Diana Vega', 24, 'F', 'Activo'),
('Alejandro Paredes', 32, 'M', 'Activo'),
('Natalia Vazquez', 21, 'F', 'Activo'),
('Hector Luna', 27, 'M', 'Baja'),
('Adriana Aguilar', 23, 'F', 'Activo'),
('Ivan Campos', 25, 'M', 'Activo'),
('Karen Fuentes', 22, 'F', 'Activo'),
('Roberto Salinas', 34, 'M', 'Inactivo'),
('Alejandra Naranjo', 19, 'F', 'Activo'),
('Eduardo Cabrera', 26, 'M', 'Activo'),
('Beatriz Correa', 28, 'F', 'Activo'),
('Mauricio Salazar', 31, 'M', 'Activo'),
('Gabriela Arroyo', 24, 'F', 'Activo'),
('Oscar Cortes', 29, 'M', 'Activo'),
('Julieta Pineda', 20, 'F', 'Suspendido'),
('David Lozano', 27, 'M', 'Activo'),
('Monserrat Castaneda', 22, 'F', 'Activo'),
('Pablo Leon', 30, 'M', 'Activo'),
('Lucia Carrillo', 23, 'F', 'Activo'),
('Cristian Rosales', 21, 'M', 'Activo'),
('Veronica Bautista', 25, 'F', 'Inactivo'),
('Kevin Navarro', 24, 'M', 'Activo'),
('Abril Munoz', 19, 'F', 'Activo'),
('Jesus Silva', 33, 'M', 'Activo'),
('Renata Quiroz', 20, 'F', 'Activo'),
('Marco Delgado', 28, 'M', 'Baja'),
('Patricia Cardenas', 26, 'F', 'Activo'),
('Bruno Esquivel', 22, 'M', 'Activo'),
('Sofia Rivas', 23, 'F', 'Activo'),
('Tomas Villalobos', 27, 'M', 'Activo'),
('Melissa Cordero', 21, 'F', 'Activo'),
('Gael Zamora', 25, 'M', 'Suspendido'),
('Aitana Valencia', 18, 'F', 'Activo'),
('Emiliano Trejo', 20, 'M', 'Activo'),
('Regina Palacios', 22, 'F', 'Activo'),
('Mateo Farias', 24, 'M', 'Activo'),
('Karla Barrios', 26, 'F', 'Activo'),
('Santiago Mena', 28, 'M', 'Activo'),
('Fabiola Ochoa', 23, 'F', 'Activo'),
('Rodrigo Beltran', 27, 'M', 'Activo'),
('Miriam Arce', 29, 'F', 'Inactivo'),
('Alberto Trevino', 32, 'M', 'Activo'),
('Teresa Valencia', 21, 'F', 'Activo'),
('Martin Cuevas', 25, 'M', 'Activo'),
('Ingrid Lozano', 24, 'F', 'Activo'),
('Mauricio Herrera', 30, 'M', 'Activo'),
('Elena Varela', 22, 'F', 'Activo'),
('Nicolas Bustamante', 26, 'M', 'Activo'),
('Isabela Padilla', 20, 'F', 'Activo'),
('Adrian Carranza', 27, 'M', 'Activo'),
('Arantza Villasenor', 19, 'F', 'Activo'),
('Rafael Tellez', 31, 'M', 'Baja'),
('Paulina Soria', 23, 'F', 'Activo'),
('Bruno Montoya', 22, 'M', 'Activo'),
('Marisol Pena', 28, 'F', 'Activo'),
('Esteban Duarte', 29, 'M', 'Inactivo'),
('Itzel Solis', 21, 'F', 'Activo'),
('Diego Castano', 24, 'M', 'Activo'),
('Pamela Godinez', 25, 'F', 'Activo'),
('Samuel Fierro', 27, 'M', 'Activo'),
('Nancy Valdez', 26, 'F', 'Activo'),
('Arturo Quintero', 33, 'M', 'Activo'),
('Cecilia Prado', 22, 'F', 'Activo'),
('Victor Meza', 28, 'M', 'Activo'),
('Aurora Salas', 24, 'F', 'Suspendido'),
('Manuel Barajas', 30, 'M', 'Activo'),
('Lourdes Villegas', 23, 'F', 'Activo'),
('Joaquin Ponce', 25, 'M', 'Activo'),
('Pilar Rangel', 21, 'F', 'Activo'),
('Hernan Meza', 29, 'M', 'Activo'),
('Yesenia Tapia', 20, 'F', 'Activo'),
('Omar Avila', 27, 'M', 'Activo'),
('Carolina Puga', 22, 'F', 'Activo'),
('Edgar Rios', 26, 'M', 'Inactivo'),
('Daniela Saucedo', 23, 'F', 'Activo'),
('Gustavo Aguirre', 31, 'M', 'Activo'),
('Monica Najera', 24, 'F', 'Activo'),
('Ruben Galindo', 28, 'M', 'Activo'),
('Alejandra Lara', 22, 'F', 'Activo'),
('Enrique Ceballos', 27, 'M', 'Baja'),
('Mariana Basurto', 21, 'F', 'Activo'),
('Noel Cabrera', 25, 'M', 'Activo');


-- Para la tabla curso (15 registros)
INSERT INTO curso (nombre_curso, cupo, horario_dias, duracion_semanas, precio, nivel) VALUES
('Salsa Básico A',        20, 'Lun-Mie 19:00-20:00',    8,  800.00, 1),
('Bachata Intermedio A',  18, 'Mar-Jue 20:00-21:00',    8,  900.00, 2),
('Kizomba Básico A',      15, 'Sab 12:00-13:30',        6, 1000.00, 1),
('Zouk Avanzado A',       22, 'Lun-Mie-Vie 20:00-21:00',10, 1200.00, 3),
('Hip Hop Intermedio A',  25, 'Mar-Jue 18:00-19:00',    8,  800.00, 2),
('Ballet Básico A',       18, 'Sab 10:00-12:00',       12, 1500.00, 1),
('Contemporáneo Intermedio A', 20, 'Lun-Mie 18:00-19:00', 8, 900.00, 2),
('Heels Básico A',        15, 'Mar-Jue 19:00-20:00',    8, 1000.00, 1),
('Jazz Avanzado A',       22, 'Lun-Mie-Vie 19:00-20:00',10, 1200.00, 3),
('Reggaetón Intermedio A',25, 'Vie 19:00-20:00',        6,  800.00, 2),
('Salsa Avanzado A',      20, 'Mar-Jue 20:00-21:00',   10, 1200.00, 3),
('Bachata Básico A',      22, 'Dom 12:00-13:30',        6,  700.00, 1),
('Zouk Intermedio A',     18, 'Lun-Mie 20:00-21:00',    8,  900.00, 2),
('Jazz Básico A',         20, 'Mar-Jue 18:30-20:00',    8,  900.00, 1),
('Reggaetón Básico A',    25, 'Sab 18:00-19:00',        4,  650.00, 1);



-- Para la tabla alumno_curso (84 registros) tiene menos registros que alumno por que unos cuantos alumnos estan inactivos
INSERT INTO alumno_curso (id_alumno, id_curso, fecha_inscripcion) VALUES
(1, 1, '2025-10-26'),
(2, 2, '2025-10-26'),
(3, 3, '2025-10-26'),
(5, 4, '2025-10-26'),
(6, 5, '2025-10-26'),
(7, 6, '2025-10-26'),
(9, 7, '2025-10-26'),
(10, 8, '2025-10-26'),
(11, 9, '2025-10-26'),
(13, 10, '2025-10-26'),
(14, 11, '2025-10-26'),
(15, 12, '2025-10-26'),
(17, 13, '2025-10-26'),
(18, 14, '2025-10-26'),
(19, 15, '2025-10-26'),
(20, 1, '2025-10-26'),
(21, 2, '2025-10-26'),
(23, 3, '2025-10-26'),
(24, 4, '2025-10-26'),
(25, 5, '2025-10-26'),
(27, 6, '2025-10-26'),
(28, 7, '2025-10-26'),
(29, 8, '2025-10-26'),
(30, 9, '2025-10-26'),
(31, 10, '2025-10-26'),
(32, 11, '2025-10-26'),
(34, 12, '2025-10-26'),
(35, 13, '2025-10-26'),
(36, 14, '2025-10-26'),
(37, 15, '2025-10-26'),
(38, 1, '2025-10-26'),
(40, 1, '2025-10-26'),
(41, 2, '2025-10-26'),
(42, 3, '2025-10-26'),
(43, 4, '2025-10-26'),
(45, 5, '2025-10-26'),
(46, 6, '2025-10-26'),
(47, 7, '2025-10-26'),
(48, 8, '2025-10-26'),
(49, 9, '2025-10-26'),
(51, 10, '2025-10-26'),
(52, 11, '2025-10-26'),
(53, 12, '2025-10-26'),
(54, 13, '2025-10-26'),
(55, 14, '2025-10-26'),
(56, 15, '2025-10-26'),
(57, 1, '2025-10-26'),
(58, 2, '2025-10-26'),
(60, 3, '2025-10-26'),
(61, 4, '2025-10-26'),
(62, 5, '2025-10-26'),
(63, 6, '2025-10-26'),
(64, 7, '2025-10-26'),
(65, 8, '2025-10-26'),
(66, 9, '2025-10-26'),
(67, 10, '2025-10-26'),
(68, 11, '2025-10-26'),
(69, 12, '2025-10-26'),
(71, 13, '2025-10-26'),
(72, 14, '2025-10-26'),
(73, 15, '2025-10-26'),
(75, 1, '2025-10-26'),
(76, 2, '2025-10-26'),
(77, 3, '2025-10-26'),
(78, 4, '2025-10-26'),
(79, 5, '2025-10-26'),
(80, 6, '2025-10-26'),
(81, 7, '2025-10-26'),
(82, 8, '2025-10-26'),
(84, 9, '2025-10-26'),
(85, 10, '2025-10-26'),
(86, 11, '2025-10-26'),
(87, 12, '2025-10-26'),
(88, 13, '2025-10-26'),
(89, 14, '2025-10-26'),
(90, 15, '2025-10-26'),
(91, 1, '2025-10-26'),
(93, 2, '2025-10-26'),
(94, 3, '2025-10-26'),
(95, 4, '2025-10-26'),
(96, 5, '2025-10-26'),
(97, 6, '2025-10-26'),
(99, 7, '2025-10-26'),
(100, 8, '2025-10-26');



-- Para la tabla profesor (12 registros) no se necesitan tantos profesores, se tiene en cuenta que todos son de planta y trabajan tiempo completo
INSERT INTO profesor (nombre, edad, sexo, rfc, fecha_contratacion, sueldo) VALUES
('Diego Ramos',        34, 'M', 'RADD900315ABC', '2022-02-10', 21000.00),
('Laura Medina',       31, 'F', 'MELD930721DEF', '2021-08-23', 20500.00),
('Carlos Fuentes',     42, 'M', 'FUCC830504GHI', '2020-11-02', 25000.00),
('Sofía Herrera',      29, 'F', 'HESF960918JKL', '2023-03-15', 19800.00),
('Miguel Avila',       37, 'M', 'AIMM880227MNO', '2021-01-18', 23000.00),
('Paola Nuñez',        33, 'F', 'NUPP920605PQR', '2022-07-05', 21200.00),
('Javier Ortega',      39, 'M', 'ORJJ850912STU', '2020-09-30', 24000.00),
('Mariana Lozano',     28, 'F', 'LOZM970314VWX', '2024-04-22', 19500.00),
('Erik Zamora',        36, 'M', 'ZAEF890110YZA', '2021-10-11', 22500.00),
('Verónica Salgado',   35, 'F', 'SAVV900824BCD', '2022-05-27', 21800.00),
('Hugo Cabrera',       41, 'M', 'CAHH840516EFG', '2019-12-12', 26000.00),
('Daniela Prieto',     30, 'F', 'PRDD950903HIJ', '2023-09-04', 20800.00);



-- Para la tabla curso_profesor (30 registros), varios profes dan varios cursos
INSERT INTO curso_profesor (id_curso, id_profesor) VALUES
-- Cursos 1–6 (parejas básicas 1–2, 3–4, 5–6, 7–8, 9–10, 11–12)
(1, 1), (1, 2),
(2, 3), (2, 4),
(3, 5), (3, 6),
(4, 7), (4, 8),
(5, 9), (5, 10),
(6, 11), (6, 12),
-- Reutilización para que los profes tengan varios cursos
-- 7–12 (combinaciones cruzadas)
(7, 1), (7, 3),
(8, 2), (8, 4),
(9, 5), (9, 7),
(10, 6), (10, 8),
(11, 9), (11, 11),
(12, 10), (12, 12),
-- 13–15 (para cerrar con cargas equilibradas)
(13, 1), (13, 4),
(14, 2), (14, 5),
(15, 3), (15, 6);



-- Para la tabla sucursal (id_sucursal será 1..6 en este orden) (6 registros)
INSERT INTO sucursal (ubicacion, telefono) VALUES
('CDMX - Centro',      '5511000001'),
('CDMX - Roma Norte',  '5511000002'),
('CDMX - Condesa',     '5511000003'),
('CDMX - Coyoacán',    '5511000004'),
('CDMX - Satélite',    '5511000005'),
('CDMX - Polanco',     '5511000006');



-- Para la tabla curso_sucrusal (cada curso en 2 sedes, distribución pareja) (30 registros)
INSERT INTO curso_sucursal (id_curso, id_sucursal) VALUES
(1, 1),  (1, 2),
(2, 2),  (2, 3),
(3, 3),  (3, 4),
(4, 4),  (4, 5),
(5, 5),  (5, 6),
(6, 6),  (6, 1),
(7, 1),  (7, 3),
(8, 2),  (8, 4),
(9, 3),  (9, 5),
(10, 4), (10, 6),
(11, 5), (11, 1),
(12, 6), (12, 2),
(13, 1), (13, 4),
(14, 2), (14, 5),
(15, 3), (15, 6);



-- Para lo tabla eventos (24 registros)
INSERT INTO eventos (nombre_evento, id_sucursal, fecha, num_asistentes, costo_entrada) VALUES
-- Sucursal 1: CDMX - Centro
('Noche de Salsa - San Valentín', 1, '2025-02-14', 120, 200.00),
('Social Bachata Abril',          1, '2025-04-12', 140, 180.00),
('Kizomba Saturday',              1, '2025-08-16',  90, 220.00),
('Gala de Fin de Año',            1, '2025-12-06', 200, 350.00),

-- Sucursal 2: CDMX - Roma Norte
('Zouk Social Marzo',             2, '2025-03-08', 110, 190.00),
('Hip Hop Battle',                2, '2025-05-10', 150, 250.00),
('Contemporáneo Showcase',        2, '2025-09-13',  80, 230.00),
('Bachata Night',                 2, '2025-11-15', 160, 220.00),

-- Sucursal 3: CDMX - Condesa
('Jazz Jam',                      3, '2025-02-22', 100, 180.00),
('Salsa Summer Fest',             3, '2025-06-21', 170, 260.00),
('Reggaetón Party',               3, '2025-09-27', 180, 240.00),
('Gala de Invierno Ballet',       3, '2025-12-13', 130, 300.00),

-- Sucursal 4: CDMX - Coyoacán
('Heels Workshop',                4, '2025-03-22',  70, 200.00),
('Zouk Marathon',                 4, '2025-05-24', 120, 260.00),
('Bachata Picnic',                4, '2025-08-24', 130, 150.00),
('Aniversario Candela',           4, '2025-10-26', 200, 300.00),

-- Sucursal 5: CDMX - Satélite
('Opening Social',                5, '2025-01-18', 150, 180.00),
('Kizomba Sunday',                5, '2025-04-27',  90, 200.00),
('Salsa vs Bachata Battle',       5, '2025-07-19', 160, 260.00),
('Black Weekend Social',          5, '2025-11-29', 140, 220.00),

-- Sucursal 6: CDMX - Polanco
('Contemporáneo Encuentro',       6, '2025-02-01',  85, 210.00),
('Jazz & Heels Night',            6, '2025-06-08', 120, 230.00),
('Reggaetón Sunday',              6, '2025-09-07', 170, 220.00),
('Gala de Clausura',              6, '2025-12-20', 190, 350.00);





-- Para la tabla personal (24 registros)
INSERT INTO personal (nombre, id_sucursal, puesto, rfc, fecha_contratacion, sueldo) VALUES
-- Sucursal 1: CDMX - Centro
('Ana Maria Torres',        1, 'Coordinadora Administrativa', 'TOAA900215QWZ', '2023-02-15', 18000.00),
('Pablo Estrada',           1, 'Recepcionista',               'ETPA920610LMN', '2024-06-10', 12000.00),
('Elisa Robles',            1, 'Limpieza',                    'ROEE930901PRS', '2023-09-01',  9800.00),
('Marco Ugalde',            1, 'Mantenimiento',               'UGMM881120JKL', '2022-11-20', 14000.00),

-- Sucursal 2: CDMX - Roma Norte
('Lucero Diaz',             2, 'Coordinadora Administrativa', 'DILU920805VWX', '2022-08-05', 18500.00),
('Humberto Neri',           2, 'Recepcionista',               'NEHU940312BCD', '2024-03-12', 11800.00),
('Nayeli Patino',           2, 'Limpieza',                    'PANY930718FGH', '2023-07-18',  9700.00),
('Ricardo Villeda',         2, 'Mantenimiento',               'VIRI911203RST', '2021-12-03', 14500.00),

-- Sucursal 3: CDMX - Condesa
('Juliana Pineda',          3, 'Coordinadora Administrativa', 'PIJU930123KLM', '2023-01-23', 18200.00),
('Oscar Ibarra',            3, 'Recepcionista',               'IBOC940508NPQ', '2024-05-08', 11900.00),
('Rocio Chavez',            3, 'Limpieza',                    'CHRO921010STU', '2022-10-10',  9600.00),
('Gerardo Palma',           3, 'Mantenimiento',               'PAGE920914XYZ', '2022-09-14', 14300.00),

-- Sucursal 4: CDMX - Coyoacán
('Maria Fernanda Solis',    4, 'Coordinadora Administrativa', 'SOMF930401ABC', '2023-04-01', 17800.00),
('Tomas Carranza',          4, 'Recepcionista',               'CATO940117DEF', '2024-01-17', 11700.00),
('Itzel Renteria',          4, 'Limpieza',                    'REIT930309GHI', '2023-03-09',  9500.00),
('Eduardo Godoy',           4, 'Mantenimiento',               'GOED921030JKL', '2022-10-30', 14200.00),

-- Sucursal 5: CDMX - Satélite
('Diana Camacho',           5, 'Administradora de Sede',      'CADI920711MNO', '2022-07-11', 17600.00),
('Said Valadez',            5, 'Recepcionista',               'VASA940221PQR', '2024-02-21', 11600.00),
('Aleida Montes',           5, 'Limpieza',                    'MOAL930626TUV', '2023-06-26',  9400.00),
('Cesar Olvera',            5, 'Mantenimiento',               'OLCE920828WXY', '2022-08-28', 14100.00),

-- Sucursal 6: CDMX - Polanco
('Pamela Arriaga',          6, 'Coordinadora Administrativa', 'ARPA930516BCD', '2023-05-16', 19000.00),
('Ramon Velazquez',         6, 'Recepcionista',               'VERA940703EFG', '2024-07-03', 12100.00),
('Fatima Galvan',           6, 'Limpieza',                    'GAFA931122HIJ', '2023-11-22',  9900.00),
('Julian Sandoval',         6, 'Mantenimiento',               'SAJU911105KLM', '2021-11-05', 14600.00);
