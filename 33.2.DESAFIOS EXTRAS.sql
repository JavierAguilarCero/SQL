/*
ESTE CÓDIGO SQL OBTIENE LA CANTIDAD DE VECES QUE UN CLIENTE ESPECÍFICO, 'GEORGE LINTON', HA RENTADO PELÍCULAS, AGRUPANDO LOS RESULTADOS POR TÍTULO DE LA PELÍCULA. REALIZA
UN ENCADENAMIENTO DE UNIONES INTERNAS ENTRE LAS TABLAS DE CLIENTES, RENTAS, INVENTARIO Y PELÍCULAS PARA MOSTRAR EL NOMBRE, APELLIDO, TÍTULO DE LA PELÍCULA Y LA CANTIDAD DE
RENTAS, ORDENADAS DE MAYOR A MENOR.
*/
SELECT 
	first_name,
	last_name, 
	title, 
	COUNT(*)
FROM
	customer 
INNER JOIN
	rental
ON 
	customer.customer_id = rental.customer_id
INNER JOIN
	inventory
ON 
	inventory.inventory_id=rental.inventory_id
INNER JOIN
	film
ON
	film.film_id = inventory.film_id
WHERE
	first_name='GEORGE' 
	AND last_name='LINTON'
GROUP BY 
	title,
	first_name,
	last_name
ORDER BY 
	COUNT(*) DESC