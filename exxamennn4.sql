/*Examen 4. Rojas Lagunas Kevin Antonio*/

-- Lista de provedores cuyo nombre comercial oscile entre 5 y 20
SELECT nombre_comercial, LENGTH(nombre_comercial) AS Longitud, UPPER(giro) AS giro
FROM expedientes
WHERE LENGTH(nombre_comercial) BETWEEN 5 AND 20;


-- Casos cerrados el mismo dia que ingresaron el mes de abril
SELECT expediente, nombre_comercial, tipo_reclamacion, motivo_reclamacion, estado_procesal, fecha_ingreso, fecha_cierre, DATEDIFF(fecha_cierre, fecha_ingreso) AS `Días transcurridos`
FROM expedientes
WHERE fecha_ingreso >= '2024-04-01' AND fecha_ingreso <  '2024-05-01' AND fecha_cierre = fecha_ingreso
ORDER BY fecha_ingreso;


-- Reclamaciones a Samsung por productos usados
SELECT nombre_comercial, expediente, fecha_ingreso, fecha_cierre, tipo_reclamacion, motivo_reclamacion, estado_procesal, modalidad_pago, tipo_producto
FROM expedientes
WHERE UPPER(nombre_comercial) = 'SAMSUNG' AND LOWER(tipo_producto) = 'producto usado'
ORDER BY fecha_ingreso;

-- Casos de apple con porcentaje de efectividad (recuperado/reclamado)
SELECT expediente, nombre_comercial, motivo_reclamacion, tipo_reclamacion,
  CONCAT('$ ', FORMAT(costo_servicio, 1)) AS `Costo del servicio`,
  CONCAT('$ ', FORMAT(monto_reclamado, 1)) AS `Monto reclamado`,
  CONCAT('$ ', FORMAT(monto_recuperado, 1)) AS `Monto recuperado`,
  CONCAT(ROUND((monto_recuperado / monto_reclamado) * 100, 2), '%') AS Efectividad
FROM expedientes
WHERE UPPER(nombre_comercial) = 'APPLE' AND monto_reclamado > 0;
