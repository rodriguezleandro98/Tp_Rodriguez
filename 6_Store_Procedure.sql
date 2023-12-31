USE call_center_db;

-- NUEVO COMENTARIO 
DROP PROCEDURE IF EXISTS SP_Newcomment;
DELIMITER $$
CREATE PROCEDURE SP_Newcomment( IN operador INT, IN ticket INT, IN texto VARCHAR(200))
BEGIN
	DECLARE ope, tick INT;
    START TRANSACTION;
    IF operador >= 1 AND ticket >= 1 THEN
		SELECT COUNT(o.ID) INTO ope FROM operadores as o where operador = o.ID;
	ELSE 
		ROLLBACK;
	END IF;
	IF ope = 1 THEN
		SELECT COUNT(t.ID) INTO tick FROM tickets as t where ticket = t.ID AND t.id_estado <= 2;
	ELSE 
		ROLLBACK;
	END IF;
	IF tick = 1 THEN
		INSERT INTO comentarios (id_operador, id_ticket, texto) VALUES (operador, ticket, texto);
	ELSE 
		ROLLBACK;
	END IF;
    COMMIT;
END$$

/*
-- NUEVO COMENTARIO 
DROP PROCEDURE IF EXISTS SP_Newcomment;
DELIMITER $$
CREATE PROCEDURE SP_Newcomment( IN operador INT, IN ticket INT, IN texto VARCHAR(200))
BEGIN
	DECLARE ope, tick INT;
    IF operador >= 1 AND ticket >= 1 THEN
		SELECT COUNT(o.ID) INTO ope FROM operadores as o where operador = o.ID;
        IF ope = 1 THEN
			SELECT COUNT(t.ID) INTO tick FROM tickets as t where ticket = t.ID;
            IF tick = 1 THEN
				INSERT INTO comentarios (id_operador, id_ticket, texto) VALUES (operador, ticket, texto);
            END IF;
        END IF;
    END IF;
END$$
*/

-- COMENTARIO QUE SOLUCIONA EL TICKET, NO IMPORTA QUIEN LO HAYA RESPONDIDO (QUE IGUAL SE PUEDE SABER QUIEN ES)
DROP PROCEDURE IF EXISTS SP_SolucionarComentario
DELIMITER $$
CREATE PROCEDURE SP_SolucionarComentario( IN ID int
)
BEGIN
START TRANSACTION;
	SET @id_comentario = ID;
    IF @id_comentario >= 1 THEN
		UPDATE comentarios as c SET c.solucion = 1
		WHERE c.ID = @id_comentario;
	ELSE 
		ROLLBACK;
	END IF;
COMMIT;
END$$

-- CAMBIO ESTADO DE TICKET A SOLUCIONADO Y AGREGA FECHA FIN CON LA FECHA DEL SISTEMA, 
-- SE CAMBIA EL OPERADOR PORQUE AL FINAL DEL TICKET
-- QUEDA ASIGNADO EL OPERADOR QUE LO SOLUCIONO, SEA O NO EL COMENTARIO DE EL
DROP PROCEDURE IF EXISTS SP_SolucionarTicket
DELIMITER $$
CREATE PROCEDURE SP_SolucionarTicket( IN ID int, IN ID_operador int
)
BEGIN
	DECLARE Ticket INT;
    START TRANSACTION;
	SET @id_ticket = ID;
	SET @id_operador = ID_operador;
	IF @id_ticket >= 1 AND @id_operador >= 1 THEN
		SELECT COUNT(t.id) INTO Ticket FROM tickets as t WHERE @id_ticket = t.ID AND t.id_estado <= 2;
	ELSE
		ROLLBACK;
	END IF;
	IF Ticket = 1 THEN
		UPDATE tickets as t SET t.id_estado = 3, t.fecha_fin = now(), t.id_operador = @id_operador
		WHERE t.ID = @id_ticket;
	ELSE
		ROLLBACK;
	END IF;
    COMMIT;
END$$

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

-- ALTA DE UN TICKET
DROP PROCEDURE IF EXISTS SP_AltaTicket
DELIMITER $$
CREATE PROCEDURE SP_AltaTicket( IN in_id_operador INT, IN in_id_contacto INT, IN in_id_empresa INT, IN in_id_severidad INT, IN in_id_categoria INT, IN in_id_grupo_de_derivacion INT, IN in_titulo varchar(50), IN in_descripcion varchar(300))
BEGIN
		DECLARE operador, contacto, empresa, severidad, llamado, grupo_de_derivacion INT;
		SET @id_operador = in_id_operador;
        SET @id_contacto = in_id_contacto;
        SET @id_empresa = in_id_empresa;
        SET @id_severidad = in_id_severidad;
        SET @id_categoria = in_id_categoria;
        SET @id_grupo_de_derivacion = in_id_grupo_de_derivacion;
        SET @titulo = in_titulo;
        SET @descripcion = in_descripcion;
        IF @id_operador >= 1 AND @id_contacto >= 1 AND @id_empresa >= 1 AND @id_severidad >=1 AND @id_categoria >=1 AND @id_grupo_de_derivacion >=1 and @titulo <> '' and @descripcion <> '' THEN
			SELECT COUNT(o.ID) INTO operador from operadores AS o where @id_operador = o.ID;
			IF operador = 1 THEN
				SELECT COUNT(c.ID) INTO contacto from contactos as c where @id_contacto = c.ID;
                IF contacto = 1 THEN
					SELECT COUNT(e.ID) INTO empresa from empresas AS e where @id_empresa = e.ID;
					IF empresa = 1 THEN
						SELECT COUNT(s.ID) INTO severidad from severidades AS s where @id_severidad = s.ID;
                        IF severidad = 1 THEN
							SELECT COUNT(gd.ID) INTO grupo_de_derivacion from grupos_de_derivacion AS gd where @id_grupo_de_derivacion = gd.ID;
							IF grupo_de_derivacion = 1 THEN
								INSERT INTO tickets (id_operador, id_contacto, id_empresa, id_severidad, id_categoria, id_llamado, id_grupo_de_derivacion, titulo, descripcion)
								VALUES (@id_operador, @id_contacto, @id_empresa, @id_severidad, @id_categoria, @id_llamado, @id_grupo_de_derivacion, @titulo, @descripcion);
							END IF;
						END IF;
                    END IF;
				END IF;
			END IF;
        END IF;
END$$

-- REABRIR TICKET
DROP PROCEDURE IF EXISTS SP_Reopen_ticket
DELIMITER $$
CREATE PROCEDURE SP_Reopen_ticket(IN in_id INT)
BEGIN
	DECLARE id_comment INT;
    DECLARE Ticket INT;
    DECLARE err_msg TEXT DEFAULT ' No existe ticket o no esta cerrado';
    DECLARE mensaje text default ' Operacion completada';
    START TRANSACTION;
	IF in_id >= 1 THEN
		SELECT COUNT(t.id) INTO Ticket FROM tickets as t WHERE in_id = t.ID AND t.id_estado = 4;
	END IF;
    IF Ticket = 1 THEN
		UPDATE tickets as t SET t.id_estado = 2, t.fecha_fin = null WHERE t.ID = in_id;
        SELECT c.id into id_comment from comentarios as c where c.id_ticket = in_id AND solucion = 1;
        UPDATE comentarios as c SET c.solucion = null where c.id_ticket = id_comment;
		COMMIT;
        SELECT mensaje AS 'Completed';
	ELSE
		ROLLBACK;
        SELECT CONCAT('Error: ', err_msg) AS 'Error';
	END IF;
END$$

DROP PROCEDURE IF EXISTS SP_Closed_ticket
DELIMITER $$
CREATE PROCEDURE SP_Closed_ticket(IN in_id INT, IN in_comentario varchar(200))
BEGIN
    DECLARE Ticket INT;
    DECLARE err_msg TEXT DEFAULT ' No existe ticket o ya esta cerrado';
    DECLARE mensaje text default ' Operacion completada';
    START TRANSACTION;
	IF in_id >= 1 THEN
		SELECT COUNT(t.id) INTO Ticket FROM tickets as t WHERE in_id = t.ID AND t.id_estado <= 3;
	END IF;
    IF Ticket = 1 THEN
		UPDATE tickets as t SET t.id_estado = 4, t.fecha_fin = now() WHERE t.ID = in_id;
		COMMIT;
        SELECT mensaje AS 'Completed';
	ELSE
		ROLLBACK;
        SELECT CONCAT('Error: ', err_msg) AS 'Error';
	END IF;
END$$

-- CREACION EMPRESA
DROP PROCEDURE IF EXISTS SP_New_Empresa
DELIMITER $$
CREATE PROCEDURE SP_New_Empresa(IN in_nombre varchar(50), IN in_pais varchar(50))
BEGIN
	DECLARE idpais INT;
    DECLARE idempresa INT;
	DECLARE err_msg TEXT DEFAULT 'Ingrese correctamente los datos.';
    DECLARE mensaje text default 'Operacion completada';
	START TRANSACTION;
    INSERT INTO empresas (empresa) VALUES (in_nombre);
    SET idempresa = LAST_INSERT_ID();
    IF idempresa = 0 THEN
		ROLLBACK;
        SELECT CONCAT('Error: ', err_msg) AS 'Error';
    ELSE
		SELECT COUNT(p.ID) INTO idpais FROM paises as p where UPPER(in_pais) = p.pais;
		INSERT INTO empresas_x_paises (id_empresa, id_pais) VALUES (idempresa,idpais);
		COMMIT;
        SELECT mensaje AS 'Completed';
	END IF;
END$$

-- ALTA PAIS
DROP PROCEDURE IF EXISTS SP_New_Pais
DELIMITER $$
CREATE PROCEDURE SP_New_Pais(IN in_pais varchar(50))
BEGIN
	DECLARE idpais INT;
    DECLARE pais_repetido INT;
    DECLARE paiss VARCHAR(50);
	DECLARE err_msg TEXT DEFAULT 'Ingrese otro pais, ya esta dado de alta';
    DECLARE mensaje text default 'Operacion completada';
    SET paiss = in_pais;
	START TRANSACTION;
    SELECT COUNT(p.ID) INTO pais_repetido FROM paises as p where UPPER(paiss) = p.pais;
    IF pais_repetido = 1 THEN
		ROLLBACK;
        SELECT CONCAT('Error: ', err_msg) AS 'Error';
    ELSE
		INSERT INTO paises (pais) VALUES (UPPER(paiss));
		COMMIT;
        SELECT mensaje AS 'Completed';
	END IF;
END$$

DELIMITER ;