USE call_center_db;

-- 1
-- CAMBIO ESTADO DE TICKET A SOLUCIONADO Y AGREGA FECHA FIN CON LA FECHA DEL SISTEMA, 
-- SE CAMBIA EL OPERADOR PORQUE AL FINAL DEL TICKET
-- QUEDA ASIGNADO EL OPERADOR QUE LO SOLUCIONO, SEA O NO EL COMENTARIO DE EL
DROP PROCEDURE IF EXISTS SP_SolucionarTicket
DELIMITER $$
CREATE PROCEDURE SP_SolucionarTicket( IN ID int, IN ID_operador int
)
BEGIN
	DECLARE Ticket INT;
	SET @id_ticket = ID;
	SET @id_operador = ID_operador;
	IF @id_ticket >= 1 AND @id_operador >= 1 THEN
		SELECT COUNT(t.id) INTO Ticket FROM tickets as t WHERE @id_ticket = t.ID;
			IF Ticket = 1 THEN
				UPDATE tickets as t SET t.id_estado = 3, t.fecha_fin = now(), t.id_operador = @id_operador
			WHERE t.ID = @id_ticket;
			END IF;
	END IF;
END$$

-- 2
-- COMENTARIO QUE SOLUCIONA EL TICKET, NO IMPORTA QUIEN LO HAYA RESPONDIDO (QUE IGUAL SE PUEDE SABER QUIEN ES)
DROP PROCEDURE IF EXISTS SP_SolucionarComentario
DELIMITER $$
CREATE PROCEDURE SP_SolucionarComentario( IN ID int
)
BEGIN
	SET @id_comentario = ID;
    IF @id_comentario >= 1 THEN
		UPDATE comentarios as c SET c.solucion = 1
		WHERE c.ID = @id_comentario;
	END IF;
END$$

-- 3
-- SP QUE LLAMA A LOS OTROS 2 SP PARA QUE SE EJECUTEN "AL MISMO TIEMPO" POR LO CUAL UN COMENTARIO QUEDA COMO LA SOLUCION
-- DE UN TICKET, EL TICKET QUEDA EN ESTADO SOLUCIONADO CON EL OPERADOR QUE DIO LA ORDEN DE SOLUCIONARLO.
DROP PROCEDURE IF EXISTS SP_Solucionar
DELIMITER $$
CREATE PROCEDURE SP_Solucionar( IN idticket INT, IN idcomentario INT, IN idoperador INT
)
BEGIN
	SET @idticket = idticket;
	SET @idcomentario = idcomentario;
	SET @idoperador = idoperador;
	call SP_SolucionarComentario(idcomentario);
	call SP_SolucionarTicket(idticket,idoperador);
END$$

DELIMITER ;