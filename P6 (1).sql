/*  Equipo 6:
    -Dueñas Jauregui Jenaro
    -Navarro Martínez Erick Israel
    -Rojas Lagunas Kevin Antonio
    -Serrano Álvarez Ricardo  */

USE seguros_final;

/*1. Vista de Desempeño por Ciudad (INNER JOIN): Cree una Vista llamada
V_PRIMAS_POR_CIUDAD que muestre el nombre de la ciudad (nombre_ciudad) y el
promedio de la prima (AVG(monto_prima)) de las pólizas vendidas. Considere solo
a los agentes que tienen pólizas activas.*/

-- 1. CREACIÓN DE LA VISTA
DROP VIEW IF EXISTS V_PRIMAS_POR_CIUDAD;

CREATE VIEW V_PRIMAS_POR_CIUDAD AS
SELECT c.nombre_ciudad,
       AVG(p.monto_prima) AS promedio_primas
-- Unimos agentes→ciudades→pólizas para asociar cada prima a su ciudad
FROM agentes AS a
INNER JOIN c_ciudades AS c ON a.id_ciudad = c.id_ciudad
INNER JOIN polizas  AS p ON a.id_agente = p.id_agente
-- Solo consideramos pólizas activas/vigentes para el promedio
WHERE p.estado_poliza = 'Vigente'
GROUP BY c.nombre_ciudad;

-- 1. USO DE LA VISTA (Muestre el resultado)
SELECT * FROM V_PRIMAS_POR_CIUDAD;

/*2. Vista de Clientes sin Póliza (OUTER JOIN): Cree una Vista llamada
V_PROSPECTOS_SIN_POLIZA que liste el id_cliente y el nombre de todos los clientes
que no tienen ninguna póliza registrada en la tabla polizas (Clientes potenciales
para venta).*/

-- 2. CREACIÓN DE LA VISTA
DROP VIEW IF EXISTS V_PROSPECTOS_SIN_POLIZA;

CREATE VIEW V_PROSPECTOS_SIN_POLIZA AS
SELECT c.id_cliente, c.nombre
FROM clientes AS c
LEFT JOIN polizas AS p ON c.id_cliente = p.id_cliente
-- Con LEFT JOIN y filtro IS NULL detectamos clientes sin registros en polizas
WHERE p.id_cliente IS NULL;

-- 2. USO DE LA VISTA (Muestre el resultado)
SELECT * FROM V_PROSPECTOS_SIN_POLIZA;

/*3. Función: Cálculo de Comisión por Riesgo (CREATE FUNCTION): Cree una
función llamada FN_CALCULAR_COMISION que reciba el monto_prima (DECIMAL) de una
póliza y un id_ramo (INT). La función debe retornar la comisión del agente aplicando
las siguientes reglas:
Ramo GMM (id_ramo = 3): 15 % de la prima.
Otros ramos: 10 % de la prima.*/

-- 3. CÓDIGO DE LA FUNCIÓN
DROP FUNCTION IF EXISTS FN_CALCULAR_COMISION;

DELIMITER $$
CREATE FUNCTION FN_CALCULAR_COMISION(monto_prima DECIMAL(10,2), id_ramo INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE comision DECIMAL(10,2);

    -- Aplicamos las reglas según el ramo
    IF id_ramo = 3 THEN
        SET comision = monto_prima * 0.15;
    ELSE
        SET comision = monto_prima * 0.10;
    END IF;

    RETURN comision;
END $$
DELIMITER ;

-- 3. USO DE LA FUNCIÓN (Muestre un ejemplo de uso)
SELECT FN_CALCULAR_COMISION(10000, 3);
SELECT FN_CALCULAR_COMISION(8000, 1);


/*4. Función: Clasificación de Antigüedad (CREATE FUNCTION): Cree una función
llamada FN_CLASIFICAR_ANTIGUEDAD que reciba el id_cliente (INT). La función
debe retornar la fecha_nacimiento del cliente.*/

-- 4. CÓDIGO DE LA FUNCIÓN
DROP FUNCTION IF EXISTS FN_CLASIFICAR_ANTIGUEDAD;

DELIMITER $$
CREATE FUNCTION FN_CLASIFICAR_ANTIGUEDAD(p_id_cliente INT)
RETURNS DATE
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE fechaN DATE;

    -- Buscamos la fecha del cliente y la guardamos en variable local
    SELECT fecha_nacimiento
    INTO fechaN
    FROM clientes
    WHERE id_cliente = p_id_cliente;

    RETURN fechaN;
END $$
DELIMITER ;

-- 4. USO DE LA FUNCIÓN (Muestre un ejemplo de uso)
SELECT FN_CLASIFICAR_ANTIGUEDAD(1);

/*5. Procedimiento Almacenado: Aumento de Primas por Contrato (CREATE
PROCEDURE): Cree un procedimiento llamado SP_AUMENTO_PRIMA_CONTRATO que re-
ciba un id_contrato (INT) y un porcentaje_aumento (DECIMAL). El procedimiento
debe aumentar el monto_prima de todas las pólizas asociadas a ese contrato
por el porcentaje dado (e.g., si se recibe 0.05, aumenta 5 %).*/

-- 5. CÓDIGO DEL PROCEDIMIENTO
DROP PROCEDURE IF EXISTS SP_AUMENTO_PRIMA_CONTRATO;

DELIMITER $$
CREATE PROCEDURE SP_AUMENTO_PRIMA_CONTRATO(
    IN p_id_contrato INT,
    IN p_porcentaje_aumento DECIMAL(5,4)
)
BEGIN
    -- Aplicamos el aumento multiplicando por (1 + porcentaje)
    UPDATE polizas
    SET monto_prima = monto_prima * (1 + p_porcentaje_aumento)
    WHERE id_contrato = p_id_contrato;
END $$
DELIMITER ;

-- 5. USO DEL PROCEDIMIENTO (Muestre un ejemplo de llamada)
-- (Idempotencia: se muestra el uso pero se revierte al final)
START TRANSACTION;
CALL SP_AUMENTO_PRIMA_CONTRATO(1,0.05);
-- Mostramos pólizas del contrato para comprobar el aumento dentro de la transacción
SELECT id_poliza,id_contrato,monto_prima FROM polizas WHERE id_contrato = 1;
ROLLBACK;

/*6. Procedimiento Almacenado: Marcado de Siniestros Rechazados
(CREATE PROCEDURE): Cree un procedimiento llamado SP_MARCAR_SINIESTROS_RECHAZADOS
que actualice el estado_siniestro a 'Auditoria' para todos los siniestros que tengan
monto_pago = 0.00 y el estado_siniestro actual sea 'Rechazado'.*/

-- 6. CÓDIGO DEL PROCEDIMIENTO
DROP PROCEDURE IF EXISTS SP_MARCAR_SINIESTROS_RECHAZADOS;

DELIMITER $$
CREATE PROCEDURE SP_MARCAR_SINIESTROS_RECHAZADOS()
BEGIN
    -- Filtramos siniestros rechazados con pago 0 para mandarlos a auditoría
    UPDATE siniestros
    SET estado_siniestro = 'Auditoria'
    WHERE monto_pago = 0.00
      AND estado_siniestro = 'Rechazado';
END $$
DELIMITER ;

-- 6. USO DEL PROCEDIMIENTO (Muestre un ejemplo de llamada)
-- (Idempotencia: se revierte al final)
START TRANSACTION;
CALL SP_MARCAR_SINIESTROS_RECHAZADOS();
-- Mostramos los siniestros que quedaron en Auditoria en esta prueba
SELECT id_siniestro,estado_siniestro,monto_pago FROM siniestros WHERE monto_pago = 0.00;
ROLLBACK;

/*7. Trigger: Registro de UPDATE de Prima (AFTER UPDATE):
Cree una tabla auxiliar log_auditoria_polizas y un trigger
llamado TR_PRIMA_UPDATE_LOG que se active después de actualizar
un registro en polizas. Si el monto_prima cambia, inserta en
log_auditoria_polizas la prima anterior y el usuario que realizó el cambio.*/

-- 7. CÓDIGO DEL TRIGGER
DROP TABLE IF EXISTS log_auditoria_polizas;
CREATE TABLE log_auditoria_polizas (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_poliza INT,
    fecha_cambio DATETIME,
    prima_anterior DECIMAL(10, 2),
    usuario VARCHAR(100),
    accion VARCHAR(10)
);

DROP TRIGGER IF EXISTS TR_PRIMA_UPDATE_LOG;

DELIMITER $$
CREATE TRIGGER TR_PRIMA_UPDATE_LOG
AFTER UPDATE ON polizas
FOR EACH ROW
BEGIN
    -- Usamos OLD.monto_prima para guardar el valor anterior y auditar cambios
    IF OLD.monto_prima <> NEW.monto_prima THEN
        INSERT INTO log_auditoria_polizas(id_poliza, fecha_cambio, prima_anterior, usuario, accion)
        VALUES (OLD.id_poliza, NOW(), OLD.monto_prima, USER(), 'UPDATE');
    END IF;
END $$
DELIMITER ;

-- Prueba del Trigger (idempotente con ROLLBACK):
START TRANSACTION;
SELECT * FROM log_auditoria_polizas;
-- Limpiamos log dentro de la transacción para que la prueba sea repetible
DELETE FROM log_auditoria_polizas;
UPDATE polizas SET monto_prima = monto_prima + 100 WHERE id_poliza = 1;
SELECT * FROM log_auditoria_polizas;
ROLLBACK;

/*8. Trigger: Validación de estado_poliza (BEFORE INSERT):
Cree un trigger que se ejecute antes de insertar una nueva póliza en polizas.
Si se intenta insertar con estado_poliza = 'Cancelada' (o cualquier otro valor),
el trigger debe forzar el estado_poliza a 'Vigente'.*/

-- 8. CÓDIGO DEL TRIGGER
DROP TRIGGER IF EXISTS TR_POLIZA_BEFORE_INSERT;

DELIMITER $$
CREATE TRIGGER TR_POLIZA_BEFORE_INSERT
BEFORE INSERT ON polizas
FOR EACH ROW
BEGIN
    -- Si el usuario manda otro estado, lo forzamos a 'Vigente'
    IF NEW.estado_poliza <> 'Vigente' OR NEW.estado_poliza IS NULL THEN
        SET NEW.estado_poliza = 'Vigente';
    END IF;
END$$
DELIMITER ;

-- Prueba del Trigger (idempotente):
START TRANSACTION;
DELETE FROM polizas WHERE id_poliza = 99;
INSERT INTO polizas (id_poliza,id_cliente,id_agente,id_ramo,id_contrato,fecha_emision,fecha_vencimiento,monto_prima,estado_poliza)
VALUES (99,1,1,1,1,CURDATE(),DATE_ADD(CURDATE(),INTERVAL 1 YEAR),5000.00,'Cancelada');
-- Aquí verificamos que el trigger cambió el estado a Vigente
SELECT * FROM polizas WHERE id_poliza = 99;
ROLLBACK;

/*9. Ejercicio Extra: Clasificación de Agentes por Desempeño (VIEW + FUNCTION + SP)
a) Vista auxiliar (V_TOTAL_PRIMA_AGENTE): muestre id_agente y la suma total de monto_prima vendida por ese agente.
b) Función (FN_NIVEL_AGENTE): reciba monto_total_vendido (DECIMAL) y retorne:
   'SENIOR' si >= 40000.00
   'JUNIOR' si <  40000.00
c) Procedimiento (SP_REPORTE_NIVELES): consuma la vista y la función para generar:
   id_agente, Total_Vendido, Nivel_Agente.*/

-- 9. CÓDIGO DE LOS TRES COMPONENTES (SP, VIEW, FN)
DROP VIEW IF EXISTS V_TOTAL_PRIMA_AGENTE;
CREATE VIEW V_TOTAL_PRIMA_AGENTE AS
SELECT id_agente, SUM(monto_prima) AS Total_Vendido
FROM polizas
GROUP BY id_agente;

DROP FUNCTION IF EXISTS FN_NIVEL_AGENTE;

DELIMITER $$
CREATE FUNCTION FN_NIVEL_AGENTE(monto_total_vendido DECIMAL(10,2))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE nivel VARCHAR(10);

    -- Clasificamos por el umbral pedido (40,000)
    IF monto_total_vendido >= 40000.00 THEN
        SET nivel = 'SENIOR';
    ELSE
        SET nivel = 'JUNIOR';
    END IF;

    RETURN nivel;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS SP_REPORTE_NIVELES;

DELIMITER $$
CREATE PROCEDURE SP_REPORTE_NIVELES()
BEGIN
    -- El SP consume la vista y aplica la función para asignar el nivel
    SELECT v.id_agente,
           v.Total_Vendido,
           FN_NIVEL_AGENTE(v.Total_Vendido) AS Nivel_Agente
    FROM V_TOTAL_PRIMA_AGENTE v
    ORDER BY v.id_agente;
END$$
DELIMITER ;

-- 9. USO DEL PROCEDIMIENTO (Muestre la llamada al SP)
CALL SP_REPORTE_NIVELES();