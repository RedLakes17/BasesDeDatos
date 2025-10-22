/*1. Se desea conocer las obras que escribió Beethoven y su fecha de creación*/
SELECT * 
FROM obra
WHERE autor = 'Beethoven';

/*2. Lista las grabaciones que no sean de intérpretes cuyo nombre comience con “H” ni con “J”.*/
SELECT *
FROM grabacion
WHERE interprete NOT LIKE 'H%' AND  interprete NOT LIKE 'J%';

/*3. Un grupo de melómanos está interesado en saber cuáles son las grabaciones que tienen una duración entre 100 y 500 segundos inclusive. 
Proporcionar la información completa ordenando por duración de forma ascendente.*/
SELECT *
FROM grabacion
WHERE durac BETWEEN 100 AND 500
ORDER BY durac ASC;

/*4. El mismo grupo de aficionados desea incluir alguna de las obras anteriores en una plática que organizarán y necesitan saber cuántos minutos durará cada obra. 
Dar la información ordenando las obras de mayor a menor tiempo. Incluir una etiqueta junto a la duración que diga ‘minutos’.*/
SELECT 
  cat,
  obra,
  interprete,
  CONCAT(ROUND(durac / 60, 2), ' minutos') AS duracion_en_minutos
FROM grabacion
WHERE durac BETWEEN 100 AND 500
ORDER BY durac DESC;


/*5. Se desea rebajar 50% los discos que se grabaron antes de 1990 y después de 1980 que cuesten
entre 10 y 15 dólares. Hacer una lista del catálogo de discos indicando el año de grabación,
precio actual y de rebaja de los discos que estarían de oferta. Ordenar por el precio descontado
descendentemente. Poner una etiqueta que diga 'PRECIO DE OFERTA=‘*/

SELECT cat, tipo, año_grab, precio, CONCAT('PRECIO DE OFERTA = ', ROUND(precio * 0.5, 2)) AS oferta 
FROM disco 
WHERE año_grab > 1980 AND año_grab < 1990 AND precio BETWEEN 10 AND 15
ORDER BY ROUND(precio * 0.5, 2) DESC;


/*6. Mostrar toda la información sobre los empleados que se unieron en el mes de abril del siglo 21.*/
SELECT * 
FROM empleados
WHERE fecha_contrato LIKE '20__-04-%';


/*7. Mostrar toda la información sobre los empleados con más de 33 años de experiencia*/
SELECT *
FROM empleados
WHERE FLOOR(DATEDIFF(CURDATE(), fecha_contrato)/365) > 33;


/*8. Listar los nombres de los empleados (primera letra en mayúscula, las demás en minuscula),
aumentar su salario en un 15%, y mostrarlo con signo de dolares.*/
SELECT CONCAT(UpPER(LEFT(nombre_emp,1)), LOWER(SUBSTRING(nombre_emp,2))) AS nombre_con_formato, CONCAT('$',ROUND(salario + salario*0.15, 0)) AS salario_aumentado
FROM empleados;


/*9. Mostrar los empleados con su puesto, indicando el nombre del empleado y su puesto.*/
SELECT CONCAT(UpPER(LEFT(nombre_emp,1)), LOWER(SUBSTRING(nombre_emp,2)), 
  ' tiene el puesto de ', 
  LOWER(puesto)) AS empleado
FROM empleados;


/*10. Mostrar employee ID, employee name, salary, hire date de todos los empleados, y que la
fecha de contratación este en el formato "MM DD, AAAA”*/

SELECT emp_id, nombre_emp, salario, DATE_FORMAT(fecha_contrato, '%M %d, %Y') AS fecha_contratacion
FROM empleados;

/*11. Consulta que devuelve el emp_name y su categoría salarial:
Menos de 1500 → LOW
Entre 1500 y 3000 → MEDIUM
Más de 3000 → HIGH*/
SELECT nombre_emp, comision,
      CASE
        WHEN salario < 1500 THEN 'LOW'
        WHEN salario BETWEEN 1500 AND 3000 THEN 'MEDIUM'
        ELSE 'HIGH'
      END AS estado_comision
FROM empleados;

/*12. Consulta que muestra el emp_name y un mensaje indicando si recibe comisión o no:*/
SELECT nombre_emp, comision 
  CASE
    WHEN comision > 0 THEN 'Recibe'
    WHEN comision = 0 THEN 'No recibe'
    ELSE 'Desconocido'
  END AS recibe_comision
FROM empleados;

/*13. Consulta que clasifica a los empleados según su fecha de contratación:
Antes de 1991 → VETERANO
Entre 1991 y 1995 → EXPERIMENTADO
Después de 1995 → NUEVO*/
SELECT nombre_emp, fecha_contrato,
  CASE
    WHEN fecha_contrato < '1991-01-01' THEN 'VETERANO'
    WHEN fecha_contrato BETWEEN '1991-01-01' AND '1995-12-31' THEN 'EXPERIMENTADO'
    WHEN fecha_contrato > '1995-12-31' THEN 'NUEVO'
    ELSE 'DESCONOCIDO'
  END AS antiguedad
FROM empleados;

