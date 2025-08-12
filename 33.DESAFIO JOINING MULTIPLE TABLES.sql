/*
ESTE CÓDIGO SQL OBTIENE LA INFORMACIÓN DE CLIENTES QUE RESIDEN EN BRASIL. REALIZA UNA SERIE DE UNIONES IZQUIERDAS ENTRE LAS TABLAS DE CLIENTES, DIRECCIONES, CIUDADES Y
PAÍSES PARA MOSTRAR EL NOMBRE, APELLIDO, CORREO ELECTRÓNICO Y PAÍS DE CADA CLIENTE CUYO PAÍS SEA EXACTAMENTE 'BRAZIL'.
*/
SELECT
	first_name,
	last_name,
	email,
	country
FROM
	customer
LEFT OUTER JOIN
	address
ON
	customer.address_id = address.address_id
LEFT OUTER JOIN
	city
ON
	address.city_id = city.city_id
LEFT OUTER JOIN
	country
ON
	city.country_id = country.country_id
WHERE
	country = 'Brazil'