/*
ESTE CÓDIGO SQL CREA UNA CTE (EXPRESIÓN DE TABLA COMÚN) LLAMADA 'CUSTOMER_TOTALS' PARA CALCULAR EL NÚMERO TOTAL DE RENTAS Y EL MONTO TOTAL PAGADO POR CADA CLIENTE.
REALIZA UNIONES ENTRE LAS TABLAS DE CLIENTES, RENTAS Y PAGOS, AGRUPANDO LOS RESULTADOS POR ID DE CLIENTE, NOMBRE Y APELLIDO.
*/
WITH customer_totals AS(
	SELECT
		customer.customer_id,
		first_name,
		last_name,
		COUNT(rental.rental_id) AS rental_count,
		SUM(amount) AS total_amount
	FROM
		customer
	JOIN
		rental
	ON
		customer.customer_id = rental.customer_id
	JOIN
		payment
	ON
		rental.rental_id = payment.rental_id
	GROUP BY
		customer.customer_id,
		first_name,
		last_name
),
/*
ESTE CÓDIGO SQL DEFINE UNA CTE LLAMADA 'AVERAGE_RENTAL_COUNT' QUE CALCULA EL PROMEDIO DE RENTAS REALIZADAS POR CLIENTE. UTILIZA LOS DATOS AGRUPADOS EN LA CTE
'CUSTOMER_TOTALS' PARA OBTENER ESTE VALOR PROMEDIO.
*/
average_rental_count AS(
	SELECT
		AVG(rental_count) AS avg_rental_count
	FROM
		customer_totals
),
/*
ESTE CÓDIGO SQL DEFINE UNA CTE LLAMADA 'HIGH_RENTAL_CUSTOMER' QUE IDENTIFICA A LOS CLIENTES CUYO NÚMERO DE RENTAS ES MAYOR AL PROMEDIO GENERAL. UTILIZA LA CTE
'CUSTOMER_TOTALS' PARA OBTENER LOS DATOS DE CADA CLIENTE Y LOS COMPARA CON EL PROMEDIO CALCULADO EN 'AVERAGE_RENTAL_COUNT'.
*/
high_rental_customer AS(
	SELECT
		customer_id,
		first_name,
		last_name,
		rental_count,
		total_amount
	FROM
		customer_totals
	JOIN
		average_rental_count
	ON
		customer_totals.rental_count > average_rental_count.avg_rental_count
)
/*
ESTE CÓDIGO SQL REALIZA UNA CONSULTA FINAL QUE MUESTRA INFORMACIÓN DETALLADA DE LOS CLIENTES CON ALTO NÚMERO DE RENTAS (POR ENCIMA DEL PROMEDIO). ADEMÁS DE SUS DATOS
PERSONALES Y TOTALES DE RENTAS Y PAGOS, SE INCLUYE INFORMACIÓN DE LAS PELÍCULAS QUE HAN RENTADO. PARA ELLO, SE REALIZAN UNIONES ENTRE LAS CTEs Y LAS TABLAS DE RENTAS,
INVENTARIO Y PELÍCULAS.
*/
SELECT
	high_rental_customer.customer_id,
	first_name,
	last_name,
	rental_count,
	total_amount,
	film.film_id,
	title
	FROM
		high_rental_customer
	JOIN
		rental
	ON
		high_rental_customer.customer_id = rental.rental_id
	JOIN
		inventory
	ON
		rental.inventory_id = inventory.inventory_id
	JOIN
		film
	ON
		inventory.film_id = film.film_id