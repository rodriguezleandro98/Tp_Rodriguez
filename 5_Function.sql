USE call_center_db;

DELIMITER $$


-- 1
-- TOTAL DE TICKETS CREADOS X OPERADOR 
CREATE FUNCTION tickets_x_operador (id INT) 
RETURNS INT
deterministic
BEGIN
	-- DECLARO VARIABLES
    DECLARE resultado INT;
    -- SETEAMOS VARIABLES
    SET resultado = (
						SELECT COUNT(T.ID)
						FROM tickets as T
						INNER JOIN operadores AS O ON O.ID = T.id_operador 
						WHERE id = t.id_operador
                        );
	RETURN resultado;
END$$

DELIMITER $$

-- 2
-- PORCENTAJE DE EFICIENCIA DE CASOS SOLUCIONADOS, CERRADOS O RECHAZADOS POR OPERADOR.
CREATE FUNCTION eficiencia_operador (id_ope INT) 
RETURNS DECIMAL(11,2)
NO SQL
BEGIN
	-- DECLARO VARIABLES
    DECLARE resultado DECIMAL(11,2);
    DECLARE ticket_solucionado INT;
    DECLARE ticket_cerrado INT;
    DECLARE ticket_rechazado INT;
    DECLARE tickets_operador INT;
    -- SETEAMOS VARIABLES
    SET tickets_operador = ( SELECT tickets_x_operador(id_ope) );
    
    SET ticket_solucionado = (
						SELECT COUNT(T.ID)
						FROM tickets as T
						INNER JOIN operadores AS O ON O.ID = T.id_operador 
						WHERE id_ope = t.id_operador AND T.id_estado = 3
                        );
	SET ticket_cerrado = (
						SELECT COUNT(T.ID)
						FROM tickets as T
						INNER JOIN operadores AS O ON O.ID = T.id_operador 
						WHERE id_ope = t.id_operador AND T.id_estado = 4
                        );
	SET ticket_rechazado = (
						SELECT COUNT(T.ID)
						FROM tickets as T
						INNER JOIN operadores AS O ON O.ID = T.id_operador 
						WHERE id_ope = t.id_operador AND T.id_estado = 5
                        );      
	SET resultado = (ticket_solucionado + ticket_cerrado + ticket_rechazado) / tickets_operador ;
	RETURN resultado;
END$$

DELIMITER ;