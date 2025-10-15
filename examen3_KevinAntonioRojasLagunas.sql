/*Examne de Rojas Lagunas Kevin Antonio*/


/*1*/
DROP DATABASE IF EXISTS examen3KARL;
CREATE DATABASE IF NOT EXISTS examen3KARL;
USE examen3KARL;


/*2*/
CREATE TABLE IF NOT EXISTS preguntas (
    id INT AUTO_INCREMENT,
    descripcion VARCHAR(200) NOT NULL UNIQUE,
    puntaje TINYINT NOT NULL,
    PRIMARY KEY (id)
);


CREATE TABLE IF NOT EXISTS examenes (
    id TINYINT UNSIGNED AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL UNIQUE,
    fecha_aplicacion DATE NOT NULL,
    PRIMARY KEY (id)
);


/*3*/
SHOW TABLES;
DESCRIBE preguntas;
DESCRIBE examenes;


/*4*/
-- 4.1
ALTER TABLE preguntas 
MODIFY id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT;
-- 4.2
ALTER TABLE preguntas
ADD COLUMN id_examen TINYINT UNSIGNED NOT NULL;
-- 4.3
ALTER TABLE preguntas
ADD CONSTRAINT fk_pregunta_examen
FOREIGN KEY (id_examen) REFERENCES examenes(id);
-- 4.4
ALTER TABLE preguntas
MODIFY COLUMN puntaje TINYINT UNSIGNED NOT NULL DEFAULT 1;
-- 4.5
DESCRIBE preguntas;


/*5*/
INSERT IGNORE INTO examenes (descripcion, fecha_aplicacion) VALUES
('Parcial 1', '2025-02-05'),
('Parcial 2', '2025-03-07'),
('Parcial 3', '2025-04-28'),
('Parcial 4', '2025-05-25'),
('Reposición 1', '2025-07-10'),
('Reposición 2', '2025-04-11'),
('Reposición 3', '2025-06-28');

INSERT IGNORE INTO preguntas (descripcion, puntaje, id_examen) VALUES
('¿Qué es una base de datos?', 1, 1),
('¿Qué es una dependencia funcional?', 1, 1),
('¿Qué es un modelo de datos?', 1, 1),
('¿Qué es DML?', 2, 2),
('¿Qué es una transacción?', 1, 3);


/*6*/
SELECT * FROM examenes;
SELECT * FROM preguntas;