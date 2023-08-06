USE call_center_db;

-- 1
-- CAMBIO ESTADO DE TICKET A SOLUCIONADO Y AGREGA FECHA FIN CON LA FECHA DEL SISTEMA, 
-- SE CAMBIA EL OPERADOR PORQUE AL FINAL DEL TICKET
-- QUEDA ASIGNADO EL OPERADOR QUE LO SOLUCIONO, SEA O NO EL COMENTARIO DE EL
DELIMITER $$
CREATE PROCEDURE SP_SolucionarTicket( IN ID int, IN ID_operador int
)
BEGIN
SET @id_ticket = ID;
SET @id_operador = ID_operador;
UPDATE tickets as t SET t.id_estado = 3, t.fecha_fin = now(), t.id_operador = @id_operador
WHERE t.ID = @id_ticket;
END$$

-- 2
-- COMENTARIO QUE SOLUCIONA EL TICKET, NO IMPORTA QUIEN LO HAYA RESPONDIDO (QUE IGUAL SE PUEDE SABER QUIEN ES)
DELIMITER $$
CREATE PROCEDURE SP_SolucionarComentario( IN ID int
)
BEGIN
SET @id_comentario = ID;
UPDATE comentarios as c SET c.solucion = 1
WHERE c.ID = @id_comentario;
END$$

-- 3
-- SP QUE LLAMA A LOS OTROS 2 SP PARA QUE SE EJECUTEN "AL MISMO TIEMPO" POR LO CUAL UN COMENTARIO QUEDA COMO LA SOLUCION
-- DE UN TICKET, EL TICKET QUEDA EN ESTADO SOLUCIONADO CON EL OPERADOR QUE DIO LA ORDEN DE SOLUCIONARLO.
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