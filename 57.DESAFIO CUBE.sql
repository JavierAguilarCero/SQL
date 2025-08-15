/*
ESTE CÓDIGO SQL REALIZA UN ANÁLISIS DETALLADO DE LOS PAGOS DE CLIENTES RELACIONADOS CON LAS PELÍCULAS RENTADAS. UTILIZA UNIONES IZQUIERDAS ENTRE LAS TABLAS 'payment',
'rental', 'inventory' Y 'film' PARA OBTENER EL TÍTULO DE LA PELÍCULA ASOCIADA A CADA PAGO. LA AGRUPACIÓN SE REALIZA MEDIANTE 'CUBE', LO QUE PERMITE GENERAR TODAS LAS
COMBINACIONES POSIBLES ENTRE CLIENTE, FECHA DE PAGO Y TÍTULO DE PELÍCULA, INCLUYENDO TOTALES PARCIALES Y GENERALES. LOS RESULTADOS SE ORDENAN POR ID DE CLIENTE, FECHA DE
PAGO Y TÍTULO.
*/
SELECT
	payment.customer_id,
	DATE(payment_date),
	title,
	SUM(amount) AS total
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
GROUP BY
	CUBE(
		payment.customer_id,
		DATE(payment_date),
		title
	)
ORDER BY
	payment.customer_id,
	DATE(payment_date),
	title