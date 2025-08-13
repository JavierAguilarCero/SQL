/*
ESTE CÓDIGO SQL RECUPERA TODOS LOS VALORES DISTINTOS DEL COSTO DE REEMPLAZO DE LAS PELÍCULAS REGISTRADAS EN LA TABLA 'FILM'. UTILIZA LA CLÁUSULA DISTINCT PARA EVITAR
DUPLICADOS Y ORDENA LOS RESULTADOS DE MENOR A MAYOR SEGÚN EL COSTO DE REEMPLAZO.
*/
SELECT DISTINCT
	replacement_cost
FROM
	film
ORDER BY
	replacement_cost
/*
ESTE CÓDIGO SQL CLASIFICA LAS PELÍCULAS EN TRES CATEGORÍAS DE COSTO DE REEMPLAZO: 'LOW', 'MEDIUM' Y 'HIGH', SEGÚN EL VALOR DE LA COLUMNA 'REPLACEMENT_COST'. UTILIZA LA
INSTRUCCIÓN CASE PARA DEFINIR LOS RANGOS DE COSTO Y AGRUPA LOS RESULTADOS PARA CONTAR CUÁNTAS PELÍCULAS HAY EN CADA CATEGORÍA.
*/
SELECT
	CASE
		WHEN replacement_cost BETWEEN 9.99 AND 19.99 THEN 'LOW'
		WHEN replacement_cost BETWEEN 20.00 AND 24.99 THEN 'MEDIUM'
		ELSE 'HIGH'
	END AS cost_range,
	COUNT(*)
FROM
	film
GROUP BY
	cost_range
/*
ESTE CÓDIGO SQL RECUPERA EL TÍTULO, NOMBRE DE CATEGORÍA Y DURACIÓN DE LAS PELÍCULAS QUE PERTENECEN A LAS CATEGORÍAS 'SPORTS' O 'DRAMA'. UTILIZA UNIONES IZQUIERDAS ENTRE 
LAS TABLAS 'FILM', 'FILM_CATEGORY' Y 'CATEGORY' PARA RELACIONAR LAS PELÍCULAS CON SUS RESPECTIVAS CATEGORÍAS, Y ORDENA LOS RESULTADOS POR DURACIÓN EN ORDEN DESCENDENTE.
*/
SELECT
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
	name = 'Sports'
	OR name = 'Drama'
ORDER BY
	length DESC
/*
ESTE CÓDIGO SQL OBTIENE EL NOMBRE DE CADA CATEGORÍA DE PELÍCULA JUNTO CON LA CANTIDAD DE TÍTULOS ASOCIADOS A ELLA. UTILIZA UNIONES IZQUIERDAS ENTRE LAS TABLAS 'FILM',
'FILM_CATEGORY' Y 'CATEGORY' PARA RELACIONAR LAS PELÍCULAS CON SUS CATEGORÍAS, AGRUPA LOS RESULTADOS POR NOMBRE DE CATEGORÍA Y LOS ORDENA DE MAYOR A MENOR SEGÚN LA
CANTIDAD DE PELÍCULAS.
*/
SELECT
	name,
	COUNT(title)
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
GROUP BY
	name
ORDER BY
	COUNT(title) DESC
/*
ESTE CÓDIGO SQL OBTIENE EL ID, NOMBRE Y APELLIDO DE LOS ACTORES JUNTO CON LA CANTIDAD DE PELÍCULAS EN LAS QUE HAN PARTICIPADO. UTILIZA UNIONES IZQUIERDAS ENTRE LAS TABLAS
'ACTOR', 'FILM_ACTOR' Y 'FILM' PARA RELACIONAR A LOS ACTORES CON SUS PELÍCULAS, AGRUPA LOS RESULTADOS POR ACTOR Y ORDENA LA CANTIDAD DE PARTICIPACIONES DE MAYOR A MENOR.
*/
SELECT
	actor.actor_id,
	first_name,
	last_name,
	COUNT(*)
FROM
	actor
LEFT OUTER JOIN
	film_actor
ON
	actor.actor_id = film_actor.actor_id
LEFT OUTER JOIN
	film
ON
	film_actor.film_id = film.film_id
GROUP BY
	actor.actor_id,
	first_name,
	last_name
ORDER BY
	COUNT(*) DESC
/*
ESTE CÓDIGO SQL RECUPERA TODAS LAS DIRECCIONES QUE NO ESTÁN ASOCIADAS A NINGÚN CLIENTE. UTILIZA UNA UNIÓN IZQUIERDA ENTRE LAS TABLAS 'ADDRESS' Y 'CUSTOMER' PARA INCLUIR
TODAS LAS DIRECCIONES, Y FILTRA AQUELLAS CUYO 'CUSTOMER_ID' ES NULO, LO QUE INDICA QUE NO TIENEN CLIENTES RELACIONADOS.
*/
SELECT
	*
FROM
	address
LEFT OUTER JOIN
	customer
ON
	address.address_id = customer.address_id
WHERE
	customer_id IS NULL
/*
ESTE CÓDIGO SQL OBTIENE LA SUMA TOTAL DE PAGOS AGRUPADOS POR CIUDAD. UTILIZA UNIONES IZQUIERDAS ENTRE LAS TABLAS 'PAYMENT', 'CUSTOMER', 'ADDRESS' Y 'CITY' PARA RELACIONAR
CADA PAGO CON LA CIUDAD DEL CLIENTE QUE LO REALIZÓ. AGRUPA LOS RESULTADOS POR NOMBRE DE CIUDAD Y ORDENA LAS SUMAS DE PAGOS DE MAYOR A MENOR.
*/
SELECT 
	city,
	SUM(amount)
FROM
	payment
LEFT OUTER JOIN
	customer
ON
	payment.customer_id=customer.customer_id
LEFT OUTER JOIN 
	address
ON
	customer.address_id=address.address_id
LEFT OUTER JOIN 
	city
ON
	address.city_id=city.city_id
GROUP BY
	city
ORDER BY 
	SUM(amount) DESC
/*
ESTE CÓDIGO SQL OBTIENE LA SUMA TOTAL DE PAGOS AGRUPADOS POR COMBINACIÓN DE PAÍS Y CIUDAD. UTILIZA UNIONES IZQUIERDAS ENTRE LAS TABLAS 'PAYMENT', 'CUSTOMER', 'ADDRESS',
'CITY' Y 'COUNTRY' PARA RELACIONAR CADA PAGO CON LA UBICACIÓN DEL CLIENTE. CONCATENA EL NOMBRE DEL PAÍS Y LA CIUDAD EN UNA SOLA COLUMNA, AGRUPA LOS RESULTADOS POR ESTA
COMBINACIÓN Y ORDENA LAS SUMAS DE PAGOS EN ORDEN ASCENDENTE.
*/
SELECT
	country || ', ' || city,
	SUM(amount)
FROM
	payment
LEFT OUTER JOIN
	customer
ON
	payment.customer_id=customer.customer_id
LEFT OUTER JOIN 
	address
ON
	customer.address_id=address.address_id
LEFT OUTER JOIN 
	city
ON
	address.city_id=city.city_id
LEFT OUTER JOIN
	country
ON
	city.country_id = country.country_id
GROUP BY
	country || ', ' || city
ORDER BY 
	SUM(amount) ASC
/*
ESTE CÓDIGO SQL CALCULA EL PROMEDIO REDONDEADO DEL MONTO TOTAL PAGADO POR CLIENTES ATENDIDOS POR CADA MIEMBRO DEL PERSONAL ('STAFF_ID'). UTILIZA UNA SUBCONSULTA PARA
AGRUPAR LOS PAGOS POR CLIENTE Y PERSONAL, SUMANDO LOS MONTOS INDIVIDUALES, Y LUEGO CALCULA EL PROMEDIO DE ESOS TOTALES POR CADA MIEMBRO DEL PERSONAL EN LA CONSULTA
PRINCIPAL.
*/
SELECT
	staff_id,
	ROUND(AVG(total),2) AS avg_amount
FROM
	(SELECT
		 SUM(amount) AS total,
		 customer_id,
		 staff_id
	 FROM
	 	 payment
	 GROUP BY
		 customer_id,
		 staff_id)
GROUP BY
	staff_id
/*
ESTE CÓDIGO SQL CALCULA EL PROMEDIO DE INGRESOS DIARIOS GENERADOS EXCLUSIVAMENTE LOS DOMINGOS. UTILIZA UNA SUBCONSULTA QUE AGRUPA LOS PAGOS POR FECHA Y DÍA DE LA SEMANA
(EXTRAÍDO CON LA FUNCIÓN EXTRACT), FILTRANDO SOLO AQUELLOS CUYO DÍA DE LA SEMANA ES DOMINGO (VALOR 0). LUEGO, LA CONSULTA PRINCIPAL CALCULA EL PROMEDIO DE LOS MONTOS
TOTALES AGRUPADOS POR DÍA.
*/
SELECT
	AVG(total)
FROM
	(SELECT
		 SUM(amount) AS total,
		 DATE(payment_date),
		 EXTRACT(DOW FROM payment_date) AS weekday
	 FROM
	 	 payment
	 WHERE
	 	 EXTRACT(DOW FROM payment_date) = 0
	 GROUP BY
	 	 DATE(payment_date),
		 weekday)
/*
ESTE CÓDIGO SQL RECUPERA EL TÍTULO Y LA DURACIÓN DE LAS PELÍCULAS CUYA DURACIÓN ES MAYOR AL PROMEDIO DE DURACIÓN DE TODAS LAS PELÍCULAS QUE COMPARTEN EL MISMO COSTO DE
REEMPLAZO. UTILIZA UNA SUBCONSULTA CORRELACIONADA PARA COMPARAR LA DURACIÓN DE CADA PELÍCULA CON EL PROMEDIO DE DURACIÓN DE LAS PELÍCULAS QUE TIENEN EL MISMO
'REPLACEMENT_COST', Y ORDENA LOS RESULTADOS EN ORDEN ASCENDENTE POR DURACIÓN.
*/
SELECT
	title,
	length
FROM
	film f1
WHERE
	length > (SELECT
			      AVG(length)
			  FROM
			  	  film f2
			  WHERE
			  	  f1.replacement_cost = f2.replacement_cost)
ORDER BY
	length ASC
/*
ESTE CÓDIGO SQL CALCULA EL PROMEDIO DE GASTO POR CLIENTE EN CADA DISTRITO. UTILIZA UNA SUBCONSULTA QUE AGRUPA LOS PAGOS POR CLIENTE Y DISTRITO, SUMANDO LOS MONTOS PAGADOS
POR CADA CLIENTE. LUEGO, LA CONSULTA PRINCIPAL AGRUPA ESTOS RESULTADOS POR DISTRITO Y CALCULA EL PROMEDIO DE GASTO POR CLIENTE, REDONDEADO A DOS DECIMALES. LOS RESULTADOS
SE ORDENAN DE MAYOR A MENOR SEGÚN EL PROMEDIO DE GASTO.
*/
SELECT
	district,
	ROUND(AVG(total),2) AS avg_customer_spent
FROM
	(SELECT
		 customer.customer_id,
		 district,
		 SUM(amount) AS total
	 FROM
	 	 payment
	 INNER JOIN
	 	 customer
	 ON
	 	 payment.customer_id = customer.customer_id
	 INNER JOIN
	 	 address
	 ON
	 	 customer.address_id = address.address_id
	 GROUP BY
	 	 district,
		 customer.customer_id)
GROUP BY
	district
ORDER BY
	avg_customer_spent DESC
/*
ESTE CÓDIGO SQL OBTIENE INFORMACIÓN RELACIONADA CON PAGOS, INCLUYENDO EL TÍTULO DE LA PELÍCULA, MONTO DEL PAGO, NOMBRE DE LA CATEGORÍA Y EL ID DEL PAGO. ADEMÁS, INCLUYE
UNA SUBCONSULTA QUE CALCULA LA SUMA TOTAL DE LOS PAGOS PARA LA MISMA CATEGORÍA DE CADA REGISTRO. PARA LOGRARLO, REALIZA MÚLTIPLES UNIONES IZQUIERDAS ENTRE LAS TABLAS DE
PAGOS, RENTAS, INVENTARIO, PELÍCULAS, CATEGORÍAS DE PELÍCULAS Y CATEGORÍAS, COMPARANDO LOS NOMBRES DE LAS CATEGORÍAS EN LA CONSULTA PRINCIPAL Y LA SUBCONSULTA.
*/
SELECT
	title,
	amount,
	name,
	payment_id,
	(SELECT
		 SUM(amount)
	 FROM
		 payment
	 LEFT OUTER JOIN
		 rental
	 ON
		 payment.rental_id = rental.rental_id
	 LEFT OUTER JOIN
		 inventory
	 ON
		 rental.inventory_id = inventory.inventory_id
	 LEFT OUTER JOIN
		 film
	 ON
		 inventory.film_id = film.film_id
	 LEFT OUTER JOIN
		 film_category
	 ON
		 film.film_id = film_category.film_id
	 LEFT OUTER JOIN
		 category c2
	 ON
		 film_category.category_id = c2.category_id
	 WHERE
	 	 c1.name = c2.name)
FROM
	payment
LEFT OUTER JOIN
	rental
ON
	payment.rental_id = rental.rental_id
LEFT OUTER JOIN
	inventory
ON
	rental.inventory_id = inventory.inventory_id
LEFT OUTER JOIN
	film
ON
	inventory.film_id = film.film_id
LEFT OUTER JOIN
	film_category
ON
	film.film_id = film_category.film_id
LEFT OUTER JOIN
	category  AS c1
ON
	film_category.category_id = c1.category_id
ORDER BY
	name
/*
ESTE CÓDIGO SQL OBTIENE EL TÍTULO DE LA PELÍCULA, EL NOMBRE DE LA CATEGORÍA Y LA SUMA TOTAL DE LOS PAGOS ASOCIADOS. AGRUPA LOS RESULTADOS POR TÍTULO Y CATEGORÍA, Y FILTRA
PARA MOSTRAR ÚNICAMENTE AQUELLOS REGISTROS CUYA SUMA DE PAGOS SEA IGUAL AL MÁXIMO TOTAL ENTRE TODAS LAS COMBINACIONES DE TÍTULO Y CATEGORÍA. PARA ELLO, UTILIZA UNA
SUBCONSULTA QUE CALCULA EL MÁXIMO TOTAL DE PAGOS AGRUPADOS DE LA MISMA MANERA. SE REALIZAN VARIAS UNIONES IZQUIERDAS ENTRE LAS TABLAS DE PAGOS, RENTAS, INVENTARIO,
PELÍCULAS, CATEGORÍAS DE PELÍCULAS Y CATEGORÍAS.
*/
SELECT
	title,
	name,
	SUM(amount) as total
FROM
	payment
LEFT OUTER JOIN
	rental
ON
	payment.rental_id=rental.rental_id
LEFT OUTER JOIN
	inventory
ON
	rental.inventory_id=inventory.inventory_id
LEFT OUTER JOIN 
	film
ON
	inventory.film_id=film.film_id
LEFT OUTER JOIN
	film_category
ON
	film.film_id=film_category.film_id
LEFT OUTER JOIN
	category
ON
	film_category.category_id=category.category_id
GROUP BY
	name,
	title
HAVING
	SUM(amount) = (SELECT
					   MAX(total)
			  	   FROM
                   	   (SELECT
			          		title,
                        	name,
			          		SUM(amount) as total
			          	FROM
						  	payment 
			          	LEFT OUTER JOIN
					  		rental
			          	ON
							payment.rental_id=rental.rental_id
			          	LEFT OUTER JOIN
					  		inventory
			          	ON
					  		rental.inventory_id=inventory.inventory_id
				  		LEFT OUTER JOIN
							film 
				  		ON
						  	inventory.film_id=film.film_id
				  		LEFT JOIN
						  	film_category
				  		ON
						  	film.film_id=film_category.film_id
				  		LEFT JOIN 
						  	category
				  		ON
						  	film_category.category_id=category.category_id
				  		GROUP BY
							  name,
							  title) AS sub
			  		WHERE 
						category.name=sub.name)