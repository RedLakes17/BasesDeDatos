/* ---- DML: Select ---- */
-- Nombre: 

-- prompt (BD:\d \\\D) mysql> 

use elatico

-- orden ascendente por default

select id_cliente,nombre,apellido1,apellido2 from clientes order by id_cliente;
select id_cliente,nombre,apellido1,apellido2 from clientes order by id_cliente asc;
select id_cliente,nombre,apellido1,apellido2 from clientes order by 3;

-- orden descendente
select id_cliente,nombre,apellido1,apellido2 from clientes order by id_cliente desc;
select id_cliente,nombre,apellido1,apellido2 from clientes order by 3 desc;

-- Uso de DISTINCT para listar valores únicos
-- Listar todos los apellidos 1 únicos
select distinct apellido1 from clientes order by 1;
-- distinct no muestra valores repetidos, sólo valores distintos

/* ----DML: Select clausula where ---- */

-- 1. Seleccionar todos los clientes que sean mujeres

-- 2. Seleccionar todos los clientes donde apellido paterno sea igual a 'Sanchez'


-- 3. instruccion sql 


-- 4. Seleccionar todos los nombres de clientes que comiencen con 'M'


-- 5. Seleccionar todos los apellidos 1 de clientes que terminen con 'ez'


-- 6. Seleccionar todos los nombres de clientes que contengan una 'u'


-- 7. Seleccionar todos los nombres de clientes que que tengan una 'a' en la segunda letra


-- 8. Seleccionar todos los apellidos 1 de clientes que no sean 'López'


-- 9. Seleccionar todos los apellidos 1 de clientes que terminen con 'ez' y que sean hombres


-- 10. Seleccionar todos los nombres de clientes que contengan una 'a' en su nombre y que su apellido 2 sea 'Hernández'


-- 11. Seleccionar todos los nombres de clientes que empiecen con 'E' o que su apellido 2 sea 'Hernández'


-- 12. Seleccionar todos los clientes que nacieron en 1998


-- 13. Seleccionar todos los clientes que nacieron en los años 1994 y 1998


-- 14. Seleccionar todos los clientes que nacieron en abril de 1998


-- 15. Seleccionar el id, isbn y precio de los libros que cuesten menos de $300


-- 16. Seleccionar el id, isbn y precio de los libros que cuesten más de $500


-- 17. Seleccionar el id, isbn y precio de los libros que cuesten $350 o más pero menos de $500


-- 18. Seleccionar del inventario el id, isbn y stock mayor o igual que 500 y menor o igual que 700


-- Equivalente:


-- 19. Seleccionar del inventario el id, isbn y stock igual a 1, 900 y 1000


-- Equivalente:

