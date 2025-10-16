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