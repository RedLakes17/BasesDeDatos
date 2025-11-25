/*  Equipo 6:
    -Dueñas Jauregui Jenaro
    -Navarro Martínez Erick Israel
    -Rojas Lagunas Kevin Antonio
    -Serrano Álvarez Ricardo  */


/*1. Vista de Desempeño por Ciudad (INNER JOIN): Cree una Vista llamada
V_PRIMAS_POR_CIUDAD que muestre el nombre de la ciudad (nombre_ciudad) y el
promedio de la prima (AVG(monto_prima)) de las pólizas vendidas. Considere solo
a los agentes que tienen pólizas activas.*/
CREATE VIEW V_PRIMAS_POR_CIUDAD AS
SELECT c.nombre_ciudad, AVG((p.monto_prima)) AS promedio_primas
FROM agentes AS a 
INNER JOIN c_ciudades AS c ON a.id_ciudad = c.id_ciudad
INNER JOIN polizas AS p ON a.id_agente = p.id_agente
WHERE p.estado_poliza = 'Vigente'
GROUP BY c.nombre_ciudad;

SELECT * FROM V_PRIMAS_POR_CIUDAD;


/*2. Vista de Clientes sin Póliza (OUTER JOIN): Cree una Vista llamada
V_PROSPECTOS_SIN_POLIZA que liste el id_cliente y el nombre de todos los clientes
que no tienen ninguna póliza registrada en la tabla polizas (Clientes potenciales
para venta).*/
CREATE VIEW V_PROSPECTOS_SIN_POLIZA AS
SELECT c.id_cliente, c.nombre
FROM clientes AS c 
LEFT JOIN polizas AS p ON c.id_cliente = p.id_cliente
WHERE P.id_cliente IS NULL;

SELECT * FROM V_PROSPECTOS_SIN_POLIZA;


/*3. Función: Cálculo de Comisión por Riesgo (CREATE FUNCTION): Cree una fun-
ción llamada FN_CALCULAR_COMISION que reciba el monto_prima (DECIMAL) de una
póliza y un id_ramo (INT). La función debe retornar la comisión del agente aplicando
las siguientes reglas:
Ramo GMM (id_ramo = 3): 15 % de la prima.
Otros ramos: 10 % de la prima.*/
DROP FUNCTION IF EXISTS FN_CALCULAR_COMISION;

DELIMITER $$
CREATE FUNCTION FN_CALCULAR_COMISION(monto_prima DECIMAL(10,2), id_ramo INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE comision DECIMAL(10,2);
    IF id_ramo = 3 THEN
        SET comision = monto_prima * 0.15;
    ELSE
        SET comision = monto_prima * 0.10;
    END IF;
    RETURN comision;
END $$
DELIMITER ;

SELECT FN_CALCULAR_COMISION(10000, 3);
SELECT FN_CALCULAR_COMISION(8000, 1);


/*4. Función: Clasificación de Antigüedad (CREATE FUNCTION): Cree una función
llamada FN_CLASIFICAR_ANTIGUEDAD que reciba el id_cliente (INT). La función
debe retornar la fecha_nacimiento del cliente.*/
DROP FUNCTION IF EXISTS FN_CLASIFICAR_ANTIGUEDAD;

DELIMITER $$
CREATE FUNCTION FN_CLASIFICAR_ANTIGUEDAD(id_cliente INT)
RETURNS DATE
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE fechaN DATE;
    SELECT fecha_nacimiento 
    INTO fechaN
    FROM clientes
    WHERE clientes.id_cliente = id_cliente;
    RETURN fechaN;
END $$
DELIMITER ;

SELECT FN_CLASIFICAR_ANTIGUEDAD(1);


/*5. Procedimiento Almacenado: Aumento de Primas por Contrato (CREATE
PROCEDURE): Cree un procedimiento llamado SP_AUMENTO_PRIMA_CONTRATO que re-
ciba un id_contrato (INT) y un porcentaje_aumento (DECIMAL). El procedimiento
debe aumentar el monto_prima de todas las pólizas asociadas a ese contrato
por el porcentaje dado (e.g., si se recibe 0.05, aumenta 5 %).*/
DROP PROCEDURE IF EXISTS SP_AUMENTO_PRIMA_CONTRATO;

DELIMITER $$
CREATE PROCEDURE SP_AUMENTO_PRIMA_CONTRATO(
    IN p_id_contrato INT,
    IN p_porcentaje_aumento DECIMAL(5,4)
)
BEGIN
    UPDATE polizas
    SET monto_prima = monto_prima * (1 + p_porcentaje_aumento)
    WHERE id_contrato = p_id_contrato;
END $$
DELIMITER ;

