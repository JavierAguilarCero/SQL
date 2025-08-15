/*
ESTE PROCEDIMIENTO ALMACENADO EN PLPGSQL INTERCAMBIA LOS SALARIOS Y LOS TÍTULOS DE POSICIÓN ENTRE DOS EMPLEADOS IDENTIFICADOS POR SUS ID. PRIMERO RECUPERA LOS VALORES
ACTUALES DE SALARIO Y POSICIÓN DE CADA EMPLEADO, LUEGO ACTUALIZA LA TABLA 'EMPLOYEES' ASIGNANDO A CADA UNO LOS DATOS DEL OTRO. FINALMENTE, SE REALIZA UN COMMIT PARA
CONFIRMAR LOS CAMBIOS.
*/
CREATE OR REPLACE PROCEDURE emp_swap (emp1 INT, emp2 INT)
	LANGUAGE plpgsql
	AS
		$$
		DECLARE
			salary1 DECIMAL(8,2);
			salary2 DECIMAL(8,2);
			position1 TEXT;
			position2 TEXT;
		BEGIN
			SELECT
				salary
			INTO
				salary1
			FROM
				employees
			WHERE
				emp_id = emp1;
			
			SELECT
				salary
			INTO
				salary2
			FROM
				employees
			WHERE
				emp_id = emp2;
			
			SELECT
				position_title
			INTO
				position1
			FROM
				employees
			WHERE
				emp_id = emp1;
			
			SELECT
				position_title
			INTO
				position2
			FROM
				employees
			WHERE
				emp_id = emp2;

			UPDATE employees
			SET salary = salary2
			WHERE
				emp_id = emp1;

			UPDATE employees
			SET salary = salary1
			WHERE
				emp_id = emp2;

			UPDATE employees
			SET position_title = position2
			WHERE
				emp_id = emp1;

			UPDATE employees
			SET position_title = position1
			WHERE
				emp_id = emp2;
		COMMIT;
		END;
		$$
/*
ESTA LLAMADA EJECUTA EL PROCEDIMIENTO ALMACENADO 'EMP_SWAP' PASANDO COMO PARÁMETROS LOS ID DE DOS EMPLEADOS (1 Y 2).
*/
CALL 
	emp_swap (1,2)
/*
ESTA CONSULTA SQL RECUPERA TODOS LOS REGISTROS DE LA TABLA 'EMPLOYEES' Y LOS ORDENA ASCENDENTEMENTE SEGÚN EL CAMPO 'EMP_ID', QUE REPRESENTA EL IDENTIFICADOR ÚNICO DE CADA
EMPLEADO.
*/
SELECT
	*
FROM
	employees
ORDER BY
	emp_id