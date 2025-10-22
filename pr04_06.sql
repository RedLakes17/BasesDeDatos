/*  Equipo 6:
    -Dueñas Jauregui Jenaro
    -Navarro Martínez Erick Israel
    -Rojas Lagunas Kevin Antonio
    -Serrano Álvarez Ricardo  */

USE seguros_update;

/*1. Ajuste de Prima por Antigüedad: Aumente el monto_prima en 5 % (monto_prima
* 1.05) para todas las pólizas con estado_poliza = ’Vencida’ y cuya prima ori-
ginal sea menor a $5,000.00.*/
-- Checamos la tabla previo a la modificacion
SELECT * FROM polizas LIMIT 10;
-- Hacemos los cambios
UPDATE polizas 
SET monto_prima = monto_prima * 1.05
WHERE estado_poliza = 'Vencida' AND monto_prima < 5000;
-- Vemos los cambios
SELECT * FROM polizas;



/*2. Renovación Masiva (Ramo de Vida): Cambie el estado_poliza a ’Vigente’
para todas las pólizas del Ramo de Vida (id_ramo = 2) que actualmente estén
como ’Vencida’.*/
-- Checamos la tabla previo a la modificacion
SELECT * FROM polizas LIMIT 10;
-- Hacemos los cambios
UPDATE polizas
SET estado_poliza = 'Vigente'
WHERE id_ramo = 2 AND estado_poliza = 'Vencida';
-- Vemos los cambios
SELECT * FROM polizas;



/*3. Corrección de Nombre de Agente: Actualice el nombre del agente con id_agente
= 4 a ’Sofía Ruiz’.*/
-- Checamos la tabla previo a la modificacion
SELECT * FROM agentes LIMIT 10;
-- Hacemos los cambios
UPDATE agentes
SET nombre_agente = 'Sofía Ruiz'
WHERE id_agente = 4;
-- Vemos los cambios
SELECT * FROM agentes;



/*4. Actualización de Género (Condicional): Utilice la función IF o CASE dentro del
UPDATE para cambiar el valor del campo genero en la tabla clientes: si el género
es ’M’, cámbielo a ’H’ (Hombre).*/
-- Checamos la tabla previo a la modificacion
SELECT * FROM clientes LIMIT 10;
-- Hacemos los cambios
UPDATE clientes
SET genero = CASE
            WHEN genero = 'M' THEN 'H'
            ELSE genero
            END;
-- Vemos los cambios
SELECT * FROM clientes;



/*5. Reclasificación de Siniestros (Monto Cero): Cambie el estado_siniestro a
’Sin Afectación’ para todos los siniestros donde el monto_pago sea igual a 0.00
y el estado actual sea ’Rechazado’.*/
-- Checamos la tabla previo a la modificacion
SELECT * FROM siniestros LIMIT 10;
-- Hacemos los cambios
UPDATE siniestros
SET estado_siniestro = 'Sin Afectación'
WHERE monto_pago = 0 AND estado_siniestro = 'Rechazado';
-- Vemos los cambios
SELECT * FROM siniestros;



/*6. Eliminación de Pólizas de Bajo Valor: Elimine todas las pólizas de la tabla
polizas cuyo monto_prima sea menor a $6,000.00 y cuyo estado_poliza sea
’Vencida’.*/
-- Checamos la tabla previo a la modificacion
SELECT * FROM polizas LIMIT 10;
-- Hacemos los cambios
DELETE FROM polizas
WHERE monto_prima < 6000 AND estado_poliza = 'Vencida';
-- Vemos los cambios
SELECT * FROM polizas;




/*7. Eliminación de Siniestros Cerrados y Liquidados (Archivado): Elimine
todos los registros de siniestros donde el monto_pago sea mayor a $1.00 y el
estado_siniestro sea ’Cerrado’*/
-- Checamos la tabla previo a la modificacion
SELECT * FROM siniestros LIMIT 10;
-- Hacemos los cambios
DELETE FROM siniestros
WHERE monto_pago > 1 AND estado_siniestro = 'Cerrado';
-- Vemos los cambios
SELECT * FROM siniestros;




/*8. Borrado de Siniestros Antiguos: Elimine todos los registros de la tabla siniestros
con fechas anteriores al ’2025-01-01’.*/
-- Checamos la tabla previo a la modificacion
SELECT * FROM siniestros LIMIT 10;
-- Hacemos los cambios
DELETE FROM siniestros
WHERE fecha_siniestro < '2025-01-01';
-- Vemos los cambios
SELECT * FROM siniestros;




/*9. Eliminación de Agente (Prueba de Integridad): Intente eliminar al agente
con id_agente = 4 de la tabla agentes. Incluya su comando y comente por qué
se pudo o no se pudo eliminar. NOTA IMPORTANTE: PONGAN SU
DELETE COMENTADO PARA QUE NO HAYA PROBLEMA CON LA
IDEMPOTENCIA, SI GUSTAN SOLO PONGAN EL SELECT PARA
VALIDAR QUE SIGUE EXISTIENDO EL AGENTE 4 DE LA TABLA
agentes.*/
-- Checamos la tabla previo a la modificacion
SELECT * FROM agentes LIMIT 10;
-- Hacemos los cambios
SELECT *
FROM agentes
WHERE id_agente = 4; /*el agente con id_agente = 4 aparece relacionado en la tabla polizas, 
MySQL protege la integridad referencial y no permite eliminarlo mientras haya pólizas vinculadas a él.*/
-- Vemos los cambios
SELECT * FROM agentes;



/*10. Limpieza de Catálogo: Elimine todas las coberturas cuyo nombre contenga la
palabra ’sustituto’ de la tabla c_coberturas.*/
-- Checamos la tabla previo a la modificacion
SELECT * FROM c_coberturas LIMIT 10;
-- Hacemos los cambios
DELETE FROM c_coberturas
WHERE nombre_cobertura LIKE '%sustituto%';
-- Vemos los cambios
SELECT * FROM c_coberturas;

