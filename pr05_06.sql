/*  Equipo 6:
    -Dueñas Jauregui Jenaro
    -Navarro Martínez Erick Israel
    -Rojas Lagunas Kevin Antonio
    -Serrano Álvarez Ricardo  */

-- Nota: para los alias de las tablas se incluye un AS a diferencia de la clase, ya que nos resulta mas intuitivo

/*1. ¿Cuál es la duración de la grabacion más corta y la de mayor duración de Helmut Walcha?*/
SELECT MIN(durac) AS mas_corta, MAX(durac) AS mas_larga
FROM grabacion 
WHERE interprete = 'Helmut Walcha';

/*2. ¿Cuál es el promedio de duración de las obras grabadas? Y ¿Cuántos son los diferentes
intérpretes que hay en el catálogo? En una sola consulta.*/
SELECT COUNT(DISTINCT interprete) AS numero_interpretes, AVG(durac) AS duracion_promedio
FROM grabacion;

/*3. ¿Cuáles son las obras de los compositores nacionalistas que no se crearon durante la Segunda
Guerra Mundial?*/
SELECT o.nombre AS nombre_obra
FROM obra AS o
INNER JOIN autor AS a ON o.autor = a.nombre
WHERE (o.año_crea < 1939 OR o.año_crea > 1945) AND (a.genero = 'Nacionalista');

/*4. ¿Qué obras se escribieron después del nacimiento de Rachmaninoff?*/
SELECT nombre
FROM obra
WHERE año_crea > (SELECT YEAR(f_nac) 
                    FROM autor 
                    WHERE nombre = 'Rachmaninoff');

/*5. ¿Cuáles son las obras y autores que se escribieron después de la ultima obra escrita por un
compositor ruso?*/
SELECT o.nombre AS obra, a.nombre AS autor
FROM obra AS o
INNER JOIN autor AS a ON o.autor = a.nombre
WHERE o.año_crea > (SELECt MAX(o2.año_crea)
                    FROM obra AS o2
                    INNER JOIN autor AS a2 ON o2.autor = a2.nombre
                    WHERE a2.nacion = 'Rusia');

/*6. Se desea saber el precio promedio de los discos agrupados por década de grabacion, es decir,
grabaciones de los 70s, 80s y 90s.*/
SELECT FLOOR(año_grab/10)*10 AS decada, ROUND(AVG(precio), 2) AS precio_promedio
FROM disco
GROUP BY decada
ORDER BY decada;

/*7. Listar el nombre de la obra, su interprete y el precio de las obras de Bach y Chopin siempre y
cuando el formato del disco sea Acetato.*/
SELECT g.obra, g.interprete, d.precio
FROM grabacion AS g 
INNER JOIN disco AS d ON g.cat = d.cat
INNER JOIN obra AS o ON g.obra = o.nombre
WHERE (o.autor = 'Bach' OR o.autor = 'Chopin') AND d.tipo = 'Acetato';

/*8. Se quiere saber las obras y los interpretes de los autores de los que se desconoce la fecha de
defunción.*/
SELECT o.nombre AS obra, g.interprete AS interprete, a.nombre AS autor_def_desconocida
FROM autor AS a
INNER JOIN obra AS o ON o.autor = a.nombre
INNER JOIN grabacion AS g ON g.obra = o.nombre
WHERE a.f_def IS NULL;

/*9. Obtener toda la información sobre los discos, pero solo de aquellos cuyo precio sea menor o
igual al precio mínimo para los discos con CAT=519*/
SELECT *
FROM disco
WHERE precio <= (SELECT MIN(precio) FROM disco WHERE cat=519);

/*10. Obtener el nombre de las obras de Chopin o Bach que tienen duración entre 700 y 1000, así
como del interprete y su duración.*/
SELECT o.nombre AS obra, o.autor AS autor, g.interprete, g.durac AS duracion
FROM obra AS o
INNER JOIN grabacion AS g ON o.nombre = g.obra
WHERE o.autor IN ('Chopin', 'Bach') AND g.durac BETWEEN 700 AND 1000;

/*11. La información de los discos que pertenecen a los catálogos asociados a grabaciones cuyos
autores nacieron en el mes de junio.*/
SELECT d.cat, d.año_grab, d.precio, d.tipo
FROM disco AS d
INNER JOIN grabacion AS g ON d.cat = g.cat
INNER JOIN obra AS o ON g.obra = o.nombre
INNER JOIN autor AS a ON o.autor = a.nombre
WHERE a.f_nac LIKE '%-06-%';

/*12. Se necesita una lista con las 5 primeros letras de los intérpretes y el promedio de duración de
las grabaciones que tienen cada uno.*/
SELECT LEFT(interprete, 5) AS cinco_prim_interprete, ROUND(AVG(durac),0) AS duracion_promedio
FROM grabacion
GROUP BY cinco_prim_interprete;