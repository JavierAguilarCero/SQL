/*
ESTA VISTA SQL CREA UNA REPRESENTACIÓN LLAMADA 'v_customer_info' QUE COMBINA INFORMACIÓN DE CLIENTES, DIRECCIONES, CIUDADES Y PAÍSES. MUESTRA EL ID DEL CLIENTE, SU NOMBRE
COMPLETO, DIRECCIÓN, CÓDIGO POSTAL, TELÉFONO, CIUDAD Y PAÍS. UTILIZA UNIONES INTERNAS ENTRE LAS TABLAS RELACIONADAS Y ORDENA LOS RESULTADOS POR EL ID DEL CLIENTE.
*/
CREATE VIEW v_customer_info
AS SELECT
	   customer_id,
	   first_name || ' ' || last_name AS name,
       address,
       postal_code,
       phone,
       city,
       country
   FROM 
   	   customer
   JOIN
   	   address
   ON
   	   customer.address_id = address.address_id
   JOIN 
   	   city
   ON
   	   address.city_id = city.city_id
   JOIN
   	   country
   ON
   	   city.country_id = country.country_id
   ORDER BY
   	   customer_id
/*
ESTE COMANDO ALTERA LA VISTA EXISTENTE LLAMADA 'v_customer_info' CAMBIANDO SU NOMBRE A 'v_customer_information'. NO MODIFICA LA ESTRUCTURA NI EL CONTENIDO DE LA VISTA,
SOLO ACTUALIZA SU IDENTIFICADOR PARA UNA MEJOR CLARIDAD O ORGANIZACIÓN.
*/
ALTER VIEW v_customer_info
RENAME TO v_customer_information
/*
ESTE COMANDO MODIFICA LA VISTA 'v_customer_information' CAMBIANDO EL NOMBRE DE LA COLUMNA 'customer_id' A 'c_id'. ESTA RENOMBRACIÓN PUEDE FACILITAR LA LECTURA O ADAPTARSE
A ESTÁNDARES DE NOMENCLATURA MÁS SIMPLES O CONSISTENTES.
*/
ALTER VIEW v_customer_information
RENAME COLUMN customer_id TO c_id
/*
ESTE COMANDO CREA O REEMPLAZA LA VISTA 'v_customer_information' PARA MOSTRAR INFORMACIÓN DETALLADA DE CLIENTES, INCLUYENDO SU ID RENOMBRADO COMO 'c_id', NOMBRE COMPLETO,
DIRECCIÓN, CÓDIGO POSTAL, TELÉFONO, CIUDAD, PAÍS Y SUS INICIALES. LAS INICIALES SE GENERAN CONCATENANDO LA PRIMERA LETRA DEL NOMBRE Y DEL APELLIDO. LA INFORMACIÓN SE
OBTIENE MEDIANTE UNIONES INTERNAS ENTRE LAS TABLAS RELACIONADAS Y SE ORDENA POR EL ID DEL CLIENTE.
*/
CREATE OR REPLACE VIEW v_customer_information
AS SELECT
	   customer_id AS c_id,
	   first_name || ' ' || last_name AS name,
       address,
       postal_code,
       phone,
       city,
       country,
	   CONCAT(LEFT(first_name,1),LEFT(last_name,1)) AS initials
   FROM 
   	   customer
   JOIN
   	   address
   ON
   	   customer.address_id = address.address_id
   JOIN 
   	   city
   ON
   	   address.city_id = city.city_id
   JOIN
   	   country
   ON
   	   city.country_id = country.country_id
   ORDER BY
   	   c_id