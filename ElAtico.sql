SELECT l.titulo AS libro, 'Sin autor registrado' AS autor
FROM autores_libros AS al
RIGHT JOIN libros AS l ON al.id_libro = l.id_libro
WHERE al.id_autor IS NULL
ORDER BY l.titulo;


SELECT t.tema AS tema, COUNT(l.id_libro) AS libros
FROM temas AS t
INNER JOIN subtemas AS s ON t.id_tema = s.id_tema
INNER JOIN libros AS l ON s.id = l.id_subtema
GROUP BY t.tema
ORDER BY t.tema;


SELECT YEAR(i.fecha_publicacion) AS `Año de publicación`, 
    SUM(i.stock) AS `Cantidad de libros`, 
    SUM(i.stock * i.precio) AS `Ventas Totales`
FROM inventario AS i
GROUP BY YEAR(i.fecha_publicacion)
HAVING SUM(i.stock) > 1000 AND SUM(i.stock * i.precio) > 1000000
ORDER BY YEAR(i.fecha_publicacion);


SELECT l.id_libro, l.titulo AS libro, COUNT(DISTINCT al.id_autor) AS "Num. de autores", GROUP_CONCAT(a.nombre ORDER BY a.nombre SEPARATOR ' / ') AS autores
FROM autores_libros AS al
JOIN autores AS a USING (id_autor)
JOIN libros AS l USING (id_libro)
GROUP BY l.id_libro, l.titulo
HAVING COUNT(DISTINCT al.id_autor) = (
    SELECT MAX(num_autores)
    FROM(
        SELECT id_libro,COUNT(DISTINCT id_autor) AS num_autores
        FROM autores_libros
        GROUP BY id_libro
    ) AS C
);


SELECT t.editorial, t.libros 
FROM (
    SELECT e.editorial AS editorial, JSON_ARRAYAGG(l.titulo) AS libros, COUNT(DISTINCT i.id_libro) AS total_libros 
    FROM editoriales AS e 
    INNER JOIN inventario AS i ON e.id = i.id_editorial 
    INNER JOIN libros AS l ON l.id_libro = i.id_libro 
    GROUP BY e.id, e.editorial) AS t 
WHERE t.total_libros > 1 AND t.total_libros <= 7 
ORDER BY t.editorial;