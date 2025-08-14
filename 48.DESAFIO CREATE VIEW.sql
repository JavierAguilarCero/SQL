/*
ESTE CÓDIGO SQL CREA UNA VISTA LLAMADA 'FILMS_CATEGORY' QUE MUESTRA EL TÍTULO, NOMBRE DE LA CATEGORÍA Y DURACIÓN DE LAS PELÍCULAS CUYAS CATEGORÍAS SEAN 'ACTION' O 'COMEDY'.
PARA OBTENER ESTA INFORMACIÓN, REALIZA UNIONES IZQUIERDAS ENTRE LAS TABLAS 'FILM', 'FILM_CATEGORY' Y 'CATEGORY'. LOS RESULTADOS SE ORDENAN DE FORMA DESCENDENTE SEGÚN LA
DURACIÓN DE LA PELÍCULA.
*/
CREATE VIEW films_category
AS SELECT
	   title,
	   name,
	   length
   FROM
   	   film
   LEFT OUTER JOIN
   	   film_category
   ON
   	   film.film_id = film_category.film_id
   LEFT OUTER JOIN
   	   category
   ON
   	   film_category.category_id = category.category_id
   WHERE
   	   name IN ('Action','Comedy')
   ORDER BY
   	   length DESC