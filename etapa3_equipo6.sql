/* Proyecto Integrador Etapa 3. Bases de datos
Equipo 6:
    -Dueñas Jauregui Jenaro
    -Navarro Martínez Erick Israel
    -Rojas Lagunas Kevin Antonio
    -Serrano Álvarez Ricardo  */

USE candela_06;


/*PREGUNTAS RELEVANTES*/

/*1.- ¿Qué cursos están cerca de llenarse y podrian requerir de la apartura de otro grupo?*/
SELECT c.id_curso, c.nombre_curso, c.cupo, COUNT(ac.id_curso) AS inscritos, ROUND(COUNT(ac.id_curso) / c.cupo * 100, 2) AS porcentaje_ocupacion
FROM curso AS c 
LEFT JOIN alumno_curso AS ac ON c.id_curso = ac.id_curso 
GROUP BY c.id_curso;
/*Vemos como todos los cursos tienen mas de la mitad de su cupo disponible. Esto es comun en este tipo de negocio, debido a la naturaleza de la actividad y
para remediarlo se suele ofrecer un descuento a las personas inscritas si traen a algun conocido al curso. Tambien suele suceder que los grupos no tengan
suficientes personas para una buena dinamica*/


/*2.- ¿Cuál es la asistencia total e ingresos generados por eventos en cada sucursal durante el último mes?*/
SELECT s.ubicacion AS sucursal, SUM(e.num_asistentes) AS asistencia_total, SUM(e.costo_entrada * e.num_asistentes) AS ingresos_generados
FROM sucursal AS s
INNER JOIN eventos AS e ON s.id_sucursal = e.id_sucursal
WHERE e.fecha >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY s.ubicacion;
/*Es importante saber que tan reduitables son los eventos en cada sucursal, no los eventos por si solos. Esto nos permite saber a que sucursal se le ]
debe invertir mas esfuerzo para la realizacion de sus eventos o en dado caso que sucursales no vale la pena seguir rentando para realizar eventos.*/


/*3.- ¿Cuantos cursos imparte cada profesor y cual es su carga docente?*/
SELECT p.id_profesor, p.nombre AS nombre_profesor, COUNT(DISTINCT cp.id_curso) AS num_cursos, COUNT(DISTINCT ac.id_alumno) AS num_alumnos
FROM profesor AS p 
LEFT JOIN curso_profesor AS cp ON p.id_profesor = cp.id_profesor
LEFT JOIN alumno_curso AS ac ON cp.id_curso = ac.id_curso
GROUP BY p.id_profesor;
/*Esta consulta se hace para analizar la carga de trabajo de cada profesor. En un escenario ideal, todos los profesores deben tener mas omenos la misma carga de
trabajo y esta consulta nos permite comprobarlo. En su defecto, nos habilita para hacer una mejor division de los alumnos y los cursos impartidos*/


/*4.- ¿Cuanto dinero genera cada sucursal por sus alumnos?*/
SELECT
    s.id_sucursal,
    s.ubicacion AS sucursal,
    COUNT(ac.id_alumno) AS total_alumnos,
    SUM(c.precio) AS dinero_generado
FROM sucursal s
JOIN curso_sucursal cs ON cs.id_sucursal = s.id_sucursal
JOIN curso c ON c.id_curso = cs.id_curso
LEFT JOIN alumno_curso ac ON ac.id_curso = c.id_curso
GROUP BY
    s.id_sucursal,
    s.ubicacion;
/*Es de suma importancia identificar el ingreso neto que cada sucursal genera. Esta esta cantidad es fundamental para evaluar la redituabilidad del negocio*/


/*5.- ¿Cuanto cuestan nuestros profesores por sucursal?*/
SELECT
    s.id_sucursal,
    s.ubicacion AS sucursal,
    SUM(p.sueldo) AS salario_total_profesores
FROM sucursal s
JOIN curso_sucursal cs ON cs.id_sucursal = s.id_sucursal
JOIN curso_profesor cp ON cp.id_curso = cs.id_curso
JOIN profesor p ON p.id_profesor = cp.id_profesor
GROUP BY
    s.id_sucursal,
    s.ubicacion;
/*Esta consulta, junto con la anterior nos permite evaluar los ingresos netos que genera cada sucursal, lo cual es parte fundamental para la toma de desisciones dentro del
negocio.*/


/*6.- ¿Cuanto cuesta el personal por sucursal? */
 SELECT
    s.id_sucursal,
    s.ubicacion AS sucursal,
    SUM(p.sueldo) AS gasto_personal_sucursal
FROM sucursal s
LEFT JOIN personal p ON p.id_sucursal = s.id_sucursal
GROUP BY 
    s.id_sucursal,
    s.ubicacion;
/*En esta consulta se incluye todo el personal necesrio para que las sucursales funcionen. Sumando esto y el sueldo de los profesores, nos podemos dar una idea
de la cantidad neta generada por cada sucursal.*/


/*7.- ¿Qué cursos tienen más alumnos inscritos que el promedio general de todos los cursos?*/
SELECT 
    c.id_curso,
    c.nombre_curso,
    COUNT(ac.id_alumno) AS inscritos
FROM curso c
LEFT JOIN alumno_curso ac ON c.id_curso = ac.id_curso
GROUP BY c.id_curso, c.nombre_curso
HAVING COUNT(ac.id_alumno) >
       (
         SELECT AVG(inscritos_por_curso)
         FROM (
             SELECT COUNT(*) AS inscritos_por_curso
             FROM alumno_curso
             GROUP BY id_curso
         ) t
       )
ORDER BY inscritos DESC;
/*Esto permite observar cuales son los cursos mas solicitados, los cuales no requieren de ningun cambio o de mas promocion*/


/*8.- ¿Cuánto ingreso total genera cada curso con base en las inscripciones actuales y cuál aporta más dinero?*/
SELECT
    c.id_curso,
    c.nombre_curso,
    SUM(c.precio) AS ingresos_generados
FROM curso c
JOIN alumno_curso AS ac ON ac.id_curso = c.id_curso
GROUP BY c.id_curso, c.nombre_curso
ORDER BY ingresos_generados DESC;
/*Esta consulta resume cuánto factura cada curso con los alumnos actualmente inscritos y permite ordenar de mayor a menor.
En la salida se ve que Ballet Básico A es el curso que más dinero aporta, seguido por Zouk Avanzado A y otros cursos
intermedios/avanzados. Esto sirve para identificar los cursos más redituables y los que tal vez necesiten ajustes de precio,
horario, promoción, cambio de profesor o modelo de trabajo.*/


/*9.- ¿Cuantos alumnos hay por curso en cada sucursal y cuánto cupo disponible queda en cada caso?*/
SELECT
    s.id_sucursal,
    s.ubicacion AS sucursal,
    c.id_curso,
    c.nombre_curso,
    c.cupo,
    COUNT(ac.id_alumno) AS alumnos_inscritos,
    (c.cupo - COUNT(ac.id_alumno)) AS cupo_disponible
FROM sucursal s
JOIN curso_sucursal cs ON cs.id_sucursal = s.id_sucursal
JOIN curso c ON c.id_curso = cs.id_curso
LEFT JOIN alumno_curso ac ON ac.id_curso = c.id_curso
GROUP BY
    s.id_sucursal,
    s.ubicacion,
    c.id_curso,
    c.nombre_curso,
    c.cupo
ORDER BY
    s.id_sucursal,
    c.nombre_curso;
/*Con esta consulta se ve, para cada combinación sucursal–curso, cuántos alumnos hay inscritos y cuántos lugares siguen
libres. En los datos actuales todos los grupos tienen entre 5 y 7 alumnos y bastante cupo disponible, por lo que el
insight es que conviene enfocar esfuerzos en aumentar inscripciones antes de abrir más horarios.*/


/*10.- ¿Cuántos alumnos únicos atiende cada sucursal considerando todos sus cursos?*/
SELECT
    s.id_sucursal,
    s.ubicacion AS sucursal,
    COUNT(DISTINCT ac.id_alumno) AS alumnos_unicos
FROM sucursal s
JOIN curso_sucursal cs ON cs.id_sucursal = s.id_sucursal
JOIN alumno_curso ac ON ac.id_curso = cs.id_curso
GROUP BY
    s.id_sucursal,
    s.ubicacion;
/*Aquí vemos cuántas personas distintas atiende cada sucursal en total. La salida muestra números muy parecidos (27–29
alumnos únicos por sede), lo que indica que el tamaño de la base de alumnos es similar entre sucursales y las diferencias
en resultados se deben más al tipo de cursos y a los eventos que a la cantidad de personas atendidas.*/



/* AUTOMATIZACIÓN: TRIGGER, FUNCIÓN, VISTA Y PROCEDIMIENTO */


/*Trigger - Evitar que un curso se registre con precio negativo o cero*/
DROP TRIGGER IF EXISTS trg_validar_precio_curso;
DELIMITER $$

CREATE TRIGGER trg_validar_precio_curso
BEFORE INSERT ON curso
FOR EACH ROW
BEGIN
    IF NEW.precio <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERROR: El precio del curso debe ser mayor a cero.';
    END IF;
END$$
DELIMITER ;
/*Nos permite evitar valores incongruentes en los precios*/

/*Pruebas del trigger (ejecución manual, se documenta en el .txt):
   1) Intentar insertar un curso con precio 0 (debe FALLAR):
      INSERT INTO curso(nombre_curso, cupo, horario_dias, duracion_semanas, precio, nivel)
      VALUES ('Curso prueba trigger', 10, 'Lun y Mie 18-19h', 4, 0, 1);

   2) Insertar el mismo curso con precio válido (debe INSERTARSE bien):
      INSERT INTO curso(nombre_curso, cupo, horario_dias, duracion_semanas, precio, nivel)
      VALUES ('Curso prueba trigger OK', 10, 'Lun y Mie 18-19h', 4, 500, 1);*/


/*Funcion - ¿Cuál es el total de cursos que un alumno ha tomado históricamente?*/
DROP FUNCTION IF EXISTS fn_total_cursos_alumno;
DELIMITER $$

CREATE FUNCTION fn_total_cursos_alumno(p_id_alumno INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_total INT;

    SELECT COUNT(*)
    INTO v_total
    FROM alumno_curso
    WHERE id_alumno = p_id_alumno;

    RETURN v_total;
END$$

DELIMITER ;

/*Prueba de la función:
   Se ejecutar el SELECT siguiente para algún id de alumno (por ejemplo, 6) y se verificar
   que el valor coincide con el conteo manual en la tabla alumno_curso.*/
SELECT fn_total_cursos_alumno(6) AS cursos_tomados;
/*Es importante analizar la antiguedad y frecuencia de cada alumno para tomar desiciones que a los alumnos antiguos les
auden a quedarse y a los alumnos nuevos les permitan continuar*/


/*Vista.-¿En qué sucursales se ofrece cada curso y cuántos alumnos están inscritos en esos cursos?*/
CREATE OR REPLACE VIEW vw_curso_sucursal_inscritos AS
SELECT
    s.id_sucursal,
    s.ubicacion AS sucursal,
    c.id_curso,
    c.nombre_curso,
    COUNT(ac.id_alumno) AS alumnos_inscritos
FROM curso c
JOIN curso_sucursal cs ON c.id_curso = cs.id_curso
JOIN sucursal s ON cs.id_sucursal = s.id_sucursal
LEFT JOIN alumno_curso ac ON c.id_curso = ac.id_curso
GROUP BY
    s.id_sucursal,
    s.ubicacion,
    c.id_curso,
    c.nombre_curso;

/*Prueba de la vista:*/
SELECT * FROM vw_curso_sucursal_inscritos;
/*Este reporte nos permite analizar la distribucion de los cursos de cada sucursal, lo cual permite planificar la oferta de cursos. Igualmente permite identificar 
la popularidad de cada curso o estilo de baile en cada lugar, lo cual usualmente varia mucho.*/


/*Procedimiento almacenado - REPORTE_FINANCIERO_CANDELA:
  Resume, por sucursal, los ingresos por cursos y eventos, los gastos de profesores y personal,
  y el balance neto que resulta de esa combinación.*/
DROP PROCEDURE IF EXISTS REPORTE_FINANCIERO_CANDELA;
DELIMITER $$

CREATE PROCEDURE REPORTE_FINANCIERO_CANDELA()
BEGIN
    SELECT
        s.id_sucursal,
        s.ubicacion AS sucursal,

        /* INGRESOS POR CURSOS */
        (
            SELECT SUM(c.precio)
            FROM curso_sucursal AS cs
            JOIN curso AS c ON cs.id_curso = c.id_curso
            JOIN alumno_curso AS ac ON ac.id_curso = c.id_curso
            WHERE cs.id_sucursal = s.id_sucursal
        ) AS ingresos_cursos,

        /* INGRESOS POR EVENTOS */
        (
            SELECT SUM(e.costo_entrada * e.num_asistentes)
            FROM eventos AS e
            WHERE e.id_sucursal = s.id_sucursal
        ) AS ingresos_eventos,

        /* SALARIOS DE PROFESORES */
        (
            SELECT SUM(p.sueldo)
            FROM curso_sucursal AS cs2
            JOIN curso_profesor AS cp ON cp.id_curso = cs2.id_curso
            JOIN profesor AS p ON p.id_profesor = cp.id_profesor
            WHERE cs2.id_sucursal = s.id_sucursal
        ) AS gastos_profesores,

        /* SALARIOS DEL PERSONAL ADMINISTRATIVO */
        (
            SELECT SUM(per.sueldo)
            FROM personal AS per
            WHERE per.id_sucursal = s.id_sucursal
        ) AS gastos_personal,

        /* BALANCE NETO */
        (
            (
                SELECT SUM(c.precio)
                FROM curso_sucursal AS cs
                JOIN curso AS c ON cs.id_curso = c.id_curso
                JOIN alumno_curso ac ON ac.id_curso = c.id_curso
                WHERE cs.id_sucursal = s.id_sucursal
            )
            +
            (
                SELECT SUM(e.costo_entrada * e.num_asistentes)
                FROM eventos AS e
                WHERE e.id_sucursal = s.id_sucursal
            )
            -
            (
                SELECT SUM(p.sueldo)
                FROM curso_sucursal AS cs2
                JOIN curso_profesor AS cp ON cp.id_curso = cs2.id_curso
                JOIN profesor AS p ON p.id_profesor = cp.id_profesor
                WHERE cs2.id_sucursal = s.id_sucursal
            )
            -
            (
                SELECT SUM(per.sueldo)
                FROM personal AS per
                WHERE per.id_sucursal = s.id_sucursal
            )
        ) AS balance_neto

    FROM sucursal s;
END$$

DELIMITER ;

/*Prueba del procedimiento:*/
CALL REPORTE_FINANCIERO_CANDELA();
/*En el reporte financiero se observa que Polanco y Condesa son las sucursales con mejor balance neto, seguidas de Centro
y Coyoacán, mientras que Roma Norte y Satélite muestran saldos negativos. Este resumen permite comparar rápidamente la
rentabilidad de cada sede y decidir en cuáles conviene invertir, ajustar costos o replantear la oferta de cursos y eventos.*/