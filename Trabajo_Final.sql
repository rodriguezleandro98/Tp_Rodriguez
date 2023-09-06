CREATE DATABASE IF NOT EXISTS call_center_db2;

/*LA TABLA ACTUAL PAISES TIENE QUE REEMPLAZARSE POR EMPRESAS_x_PAISES Y SE DEBE CREAR 
UNA TABLA FIJA DE PAISES PARA 
LOS CONTACTOS
EMPRESAS_X_PAISES ES MUCHOS A MUCHOS
VOY A TENER UNA FK DE PAISES Y UNA FK DE EMPRESAS.
-------- hecho --------
*/

/*
RECORDAR CREAR LAS FK EN CASCADA SEGUN CORRESPONDA TANTO EN UPDATE O EN DELETE, SINO RESTRICT
*/

USE call_center_db2;

-- Creacion de tablas 

CREATE TABLE IF NOT EXISTS empresas (
	ID INT NOT NULL AUTO_INCREMENT,
    empresa VARCHAR(50) NOT NULL,
    fecha_reg DATETIME NOT NULL default NOW(),
    estado TINYINT NOT NULL default 1,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID)
);

CREATE TABLE IF NOT EXISTS paises (
	ID INT NOT NULL AUTO_INCREMENT,
    pais VARCHAR(50) NOT NULL,
    estado TINYINT NOT NULL default 1,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID)
);

CREATE TABLE IF NOT EXISTS puestos (
	ID INT NOT NULL AUTO_INCREMENT,
    puesto VARCHAR(20) NOT NULL,
    estado TINYINT NOT NULL default 1,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID)
);

CREATE TABLE IF NOT EXISTS grupos_de_derivacion (
	ID INT NOT NULL AUTO_INCREMENT,
    mesa VARCHAR(30) NOT NULL,
    estado TINYINT NOT NULL default 1,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID)
);

CREATE TABLE IF NOT EXISTS estados (
	ID INT NOT NULL AUTO_INCREMENT,
    estado VARCHAR(20) NOT NULL,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID)
);

CREATE TABLE IF NOT EXISTS categorias (
	ID INT NOT NULL AUTO_INCREMENT,
    categoria VARCHAR(50) NOT NULL,
    estado TINYINT NOT NULL default 1,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID)
);


CREATE TABLE IF NOT EXISTS severidades (
	ID INT NOT NULL AUTO_INCREMENT,
    severidad VARCHAR(15) NOT NULL,
    estado TINYINT NOT NULL default 1,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID)
);

CREATE TABLE IF NOT EXISTS roles (
	ID INT NOT NULL AUTO_INCREMENT,
    rol VARCHAR(20) NOT NULL,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID)
);

-- RELACION MUCHOS A MUCHOS = "empresas_x_paises"
CREATE TABLE IF NOT EXISTS empresas_x_paises (
    id_empresa INT NOT NULL,
    id_pais INT NOT NULL,
    estado TINYINT NOT NULL default 1,
    PRIMARY KEY(id_empresa, id_pais),
    FOREIGN KEY (id_pais) references paises(ID) ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY (id_empresa) references empresas(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS contactos (
	ID INT NOT NULL AUTO_INCREMENT,
    nombre_completo VARCHAR(130) NOT NULL,
    DNI VARCHAR(15) NOT NULL,
    id_pais_contacto INT NOT NULL,
    id_empresa_contacto INT NOT NULL,
    id_puesto_contacto INT NOT NULL,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID),
    FOREIGN KEY (id_pais_contacto) references paises(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_empresa_contacto) references empresas(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_puesto_contacto) references puestos(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS telefonos (
	ID INT NOT NULL AUTO_INCREMENT,
    telefono VARCHAR(20) NOT NULL,
    id_telefono_contacto INT NULL,
    id_telefono_empresa INT NULL,
    estado TINYINT NOT NULL default 1,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID),
    FOREIGN KEY (id_telefono_contacto) references contactos(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_telefono_empresa) references empresas(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS operadores (
	ID INT NOT NULL AUTO_INCREMENT,
    usuario VARCHAR(50) NOT NULL,
    clave VARCHAR(50) NOT NULL,
    id_rol_operador INT NOT NULL,
    fecha_reg DATETIME NOT NULL default NOW(),
    estado TINYINT NOT NULL default 1,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID),
    UNIQUE KEY(usuario),
    FOREIGN KEY (id_rol_operador) references roles(ID) ON DELETE CASCADE ON UPDATE CASCADE
);
/*
CREATE TABLE IF NOT EXISTS llamados (
	ID INT NOT NULL AUTO_INCREMENT,
    id_operador INT NOT NULL,
    id_contacto INT NOT NULL,
    fecha DATETIME NOT NULL default NOW(),
    PRIMARY KEY(ID),
    UNIQUE KEY(ID),
    FOREIGN KEY (id_operador) references operadores(ID),
    FOREIGN KEY (id_contacto) references contactos(ID)
);
*/
CREATE TABLE IF NOT EXISTS tickets (
	ID INT NOT NULL AUTO_INCREMENT,
    id_operador INT NOT NULL,
    id_contacto INT NOT NULL,
    id_empresa INT NOT NULL,
    id_severidad INT NOT NULL,
    id_categoria INT NOT NULL,
    id_estado INT NOT NULL default 1,
 -- id_llamado INT NOT NULL,
    id_grupo_de_derivacion INT NOT NULL,
    titulo VARCHAR(50) NOT NULL,
    descripcion VARCHAR(300) NOT NULL,
    fecha_inicio DATETIME NOT NULL default NOW(),
    fecha_fin DATETIME NULL,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID),
    FOREIGN KEY (id_operador) references operadores(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_contacto) references contactos(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_empresa) references empresas(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_empresa) references empresas(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_severidad) references severidades(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_categoria) references categorias(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_estado) references estados(ID) ON DELETE CASCADE ON UPDATE CASCADE,
--  FOREIGN KEY (id_llamado) references llamados(ID),
    FOREIGN KEY (id_grupo_de_derivacion) references grupos_de_derivacion(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS comentarios (
	ID INT NOT NULL AUTO_INCREMENT,
    id_operador INT NOT NULL,
    id_ticket INT NOT NULL,
 -- id_llamado INT NOT NULL,
    texto VARCHAR(200) NOT NULL,
    fecha DATETIME NOT NULL DEFAULT NOW(),
    solucion TINYINT NULL,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID),
    FOREIGN KEY (id_operador) references operadores(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_ticket) references tickets(ID) ON DELETE CASCADE ON UPDATE CASCADE
 -- FOREIGN KEY (id_llamado) references llamados(ID)
);

-- TABLAS LOGS

CREATE TABLE IF NOT EXISTS log_ticket(
	log_id INT NOT NULL AUTO_INCREMENT,
    event_name VARCHAR(40) NOT NULL,
    ID INT NOT NULL,
    operador_viejo INT,
    operador_nuevo INT,
    severidad_viejo INT,
    severidad_nuevo INT,
    estado_viejo INT,
    estado_nuevo INT,
    grupo_de_derivacion_viejo INT,
    grupo_de_derivacion_nuevo INT,
    usuario VARCHAR(45) NOT NULL,
    fecha DATETIME DEFAULT NOW(),
    PRIMARY KEY (log_id)
);

CREATE TABLE IF NOT EXISTS log_empresa(
	log_id INT NOT NULL AUTO_INCREMENT,
    event_name VARCHAR(40) NOT NULL,
    ID INT NOT NULL,
    empresa VARCHAR(50),
    estado BIT,
    usuario VARCHAR(45) NOT NULL,
    fecha DATETIME DEFAULT NOW(),
    PRIMARY KEY (log_id)
);

-- Inserts 

INSERT INTO empresas (empresa) VALUES ('Arcos Dorados');
INSERT INTO empresas (empresa) VALUES ('Siemmens');
INSERT INTO empresas (empresa) VALUES ('Cola Cola Company');
INSERT INTO empresas (empresa) VALUES ('Pepsi');
INSERT INTO empresas (empresa) VALUES ('Burgen King');
INSERT INTO empresas (empresa) VALUES ('Zhoe');
INSERT INTO empresas (empresa) VALUES ('Mimo');
INSERT INTO empresas (empresa) VALUES ('Dior');

INSERT INTO paises (pais) VALUES ( 'ARGENTINA' );
INSERT INTO paises (pais) VALUES ( 'CHILE' );
INSERT INTO paises (pais) VALUES ( 'URUGUAY' );
INSERT INTO paises (pais) VALUES ( 'BRASIL' );
INSERT INTO paises (pais) VALUES ( 'ECUADOR' );
INSERT INTO paises (pais) VALUES ( 'PERU' );
INSERT INTO paises (pais) VALUES ( 'BOLIVIA' );

INSERT INTO puestos (puesto) VALUES ( 'Presidente' );
INSERT INTO puestos (puesto) VALUES ( 'CEO' );
INSERT INTO puestos (puesto) VALUES ( 'Gerente' );
INSERT INTO puestos (puesto) VALUES ( 'Empleado' );

INSERT INTO grupos_de_derivacion (mesa) VALUES ( 'MDA' );
INSERT INTO grupos_de_derivacion (mesa) VALUES ( 'MDA N2' );
INSERT INTO grupos_de_derivacion (mesa) VALUES ( 'SLAD N2' );
INSERT INTO grupos_de_derivacion (mesa) VALUES ( 'SLAD N3' );
INSERT INTO grupos_de_derivacion (mesa) VALUES ( 'IT' );

INSERT INTO estados (estado) VALUES ( 'Abierto' );
INSERT INTO estados (estado) VALUES ( 'En analisis' );
INSERT INTO estados (estado) VALUES ( 'Solucionado' );
INSERT INTO estados (estado) VALUES ( 'Cerrado' );
INSERT INTO estados (estado) VALUES ( 'Rechazado' );

INSERT INTO categorias (categoria) VALUES ( 'Hardware' );
INSERT INTO categorias (categoria) VALUES ( 'Software' );
INSERT INTO categorias (categoria) VALUES ( 'Interno' );
INSERT INTO categorias (categoria) VALUES ( 'Externo' );
INSERT INTO categorias (categoria) VALUES ( 'RRHH' );
INSERT INTO categorias (categoria) VALUES ( 'IT' );

INSERT INTO severidades (severidad) VALUES ( 'Baja' );
INSERT INTO severidades (severidad) VALUES ( 'Media' );
INSERT INTO severidades (severidad) VALUES ( 'Alta' );
INSERT INTO severidades (severidad) VALUES ( 'Critica' );
INSERT INTO severidades (severidad) VALUES ( 'Urgente' );

INSERT INTO roles (rol) VALUES ( 'Administrador' );
INSERT INTO roles (rol) VALUES ( 'TeamLeader' );
INSERT INTO roles (rol) VALUES ( 'Operador' );

INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (1,1);
INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (1,2);
INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (2,1);
INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (2,3);
INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (3,3);
INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (4,4);
INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (4,1);
INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (5,2);
INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (6,5);
INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (7,2);
INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (8,6);
INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (8,7);


INSERT INTO contactos (nombre_completo, DNI, id_pais_contacto, id_empresa_contacto, id_puesto_contacto) VALUES 
('Leandro Rodriguez', 41390062, 1, 1, 1 );
INSERT INTO contactos (nombre_completo, DNI, id_pais_contacto, id_empresa_contacto, id_puesto_contacto) VALUES 
('Ariel Rodriguez', 39009709, 1, 3, 2 );
INSERT INTO contactos (nombre_completo, DNI, id_pais_contacto, id_empresa_contacto, id_puesto_contacto) VALUES 
('Nancy Regner', 20875960, 3, 2, 3 );
INSERT INTO contactos (nombre_completo, DNI, id_pais_contacto, id_empresa_contacto, id_puesto_contacto) VALUES 
('Pepe Luis', 12345678, 5, 4, 3 );
INSERT INTO contactos (nombre_completo, DNI, id_pais_contacto, id_empresa_contacto, id_puesto_contacto) VALUES 
('Ruben Alcaraz', 98765432, 2, 2, 3 );
INSERT INTO contactos (nombre_completo, DNI, id_pais_contacto, id_empresa_contacto, id_puesto_contacto) VALUES 
('Javier Arbulu', 45645645, 4, 5, 3 );
INSERT INTO contactos (nombre_completo, DNI, id_pais_contacto, id_empresa_contacto, id_puesto_contacto) VALUES 
('Jose Rodriguez', 12378956, 6, 6, 1 );
INSERT INTO contactos (nombre_completo, DNI, id_pais_contacto, id_empresa_contacto, id_puesto_contacto) VALUES 
('Arnoldo Regner', 45896314, 7, 1, 1 );

INSERT INTO telefonos (telefono, id_telefono_contacto) VALUES ( 47954341, 1 );
INSERT INTO telefonos (telefono, id_telefono_contacto) VALUES ( 45612385, 2);
INSERT INTO telefonos (telefono, id_telefono_contacto) VALUES ( 55448899, 4 );
INSERT INTO telefonos (telefono, id_telefono_contacto) VALUES ( 1164707899, 1);
INSERT INTO telefonos (telefono, id_telefono_contacto) VALUES ( 45612315, 6);
INSERT INTO telefonos (telefono, id_telefono_contacto) VALUES ( 89413594, 5);
INSERT INTO telefonos (telefono, id_telefono_contacto) VALUES ( 78945164, 2);
INSERT INTO telefonos (telefono, id_telefono_empresa) VALUES ( 896532141, 1 );
INSERT INTO telefonos (telefono, id_telefono_empresa) VALUES ( 47354641, 2 );
INSERT INTO telefonos (telefono, id_telefono_empresa) VALUES ( 47354942, 3);
INSERT INTO telefonos (telefono, id_telefono_empresa) VALUES ( 47354643, 7 );
INSERT INTO telefonos (telefono, id_telefono_empresa) VALUES ( 47354344, 8 );
INSERT INTO telefonos (telefono, id_telefono_empresa) VALUES ( 47354945, 3 );
INSERT INTO telefonos (telefono, id_telefono_empresa) VALUES ( 47354946, 5 );

INSERT INTO operadores (usuario, clave, id_rol_operador) VALUES ( 'lrodriguez', 'password01', 1 );
INSERT INTO operadores (usuario, clave, id_rol_operador) VALUES ( 'nyamarte', 'Modelo.01', 2 );
INSERT INTO operadores (usuario, clave, id_rol_operador) VALUES ( 'jferrufino', 'Moldes3060', 2 );
INSERT INTO operadores (usuario, clave, id_rol_operador) VALUES ( 'jsordello', 'juanmecha', 3 );
INSERT INTO operadores (usuario, clave, id_rol_operador) VALUES ( 'camblorpepe', 'contraseña123', 3 );
/*
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 1, 1);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 1, 2);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 1, 3);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 2, 4);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 2, 1);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 3, 4);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 3, 2);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 5, 1);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 5, 3);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 4, 6);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 3, 5);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 2, 7);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 4, 7);
*/
-- 1
INSERT INTO tickets (id_operador
, id_contacto
, id_empresa
, id_severidad
, id_categoria
, id_estado
, id_grupo_de_derivacion
, titulo
, descripcion) 
VALUES ( 1, 1, 1, 1, 1, 1, 1, 'Prueba1', 'Descripcion prueba');

-- 2
INSERT INTO tickets (id_operador
, id_contacto
, id_empresa
, id_severidad
, id_categoria
, id_estado
, id_grupo_de_derivacion
, titulo
, descripcion) 
VALUES ( 1, 2, 3, 2, 3, 4, 2, 'Prueba2', 'Descripcion prueba2');

-- 3
INSERT INTO tickets (id_operador
, id_contacto
, id_empresa
, id_severidad
, id_categoria
, id_estado
, id_grupo_de_derivacion
, titulo
, descripcion) 
VALUES ( 1, 3, 2, 1, 1, 3, 3, 'Prueba lalalalal 3', 'Se comunica por falla de equipo, se logra resolver');

-- 4
INSERT INTO tickets (id_operador
, id_contacto
, id_empresa
, id_severidad
, id_categoria
, id_estado
, id_grupo_de_derivacion
, titulo
, descripcion) 
VALUES ( 2, 4, 4, 2, 5, 2, 4, 'CCC - Cambio en RRHH', 'Gerente pide cambiar cargo en sistema RRHH');

-- 5
INSERT INTO tickets (id_operador
, id_contacto
, id_empresa
, id_severidad
, id_categoria
, id_estado
, id_grupo_de_derivacion
, titulo
, descripcion) 
VALUES ( 3, 5, 2, 4, 5, 1, 5, 'Prueba5', 'Descripcion pruebaaaaaaa5');

-- 6
INSERT INTO tickets (id_operador
, id_contacto
, id_empresa
, id_severidad
, id_categoria
, id_estado
, id_grupo_de_derivacion
, titulo
, descripcion) 
VALUES ( 4, 6, 5, 1, 1, 1, 1, 'ya me canse', 'lo mismo que el titulo');

-- 7
INSERT INTO tickets (id_operador
, id_contacto
, id_empresa
, id_severidad
, id_categoria
, id_estado
, id_grupo_de_derivacion
, titulo
, descripcion) 
VALUES ( 2, 7, 6, 3, 3, 3, 2, 'otra vez?', 'si querido');

-- 8
INSERT INTO tickets (id_operador
, id_contacto
, id_empresa
, id_severidad
, id_categoria
, id_estado
, id_grupo_de_derivacion
, titulo
, descripcion) 
VALUES ( 4, 7, 6, 1, 1, 1, 3, 'bueno basta', 'ok te respeto');

-- 1
INSERT INTO comentarios (id_operador
, id_ticket
, texto
) 
VALUES ( 1, 1, 'Primer comentario');

-- 2
INSERT INTO comentarios (id_operador
, id_ticket
, texto
) 
VALUES ( 1, 2, 'Solamente comento' );

-- 3
INSERT INTO comentarios (id_operador
, id_ticket
, texto
, solucion
) 
VALUES ( 1, 3, 'Se logra solucionar', 1 );

-- 4
INSERT INTO comentarios (id_operador
, id_ticket
, texto
) 
VALUES ( 2, 4, 'Derivado');

-- 5
INSERT INTO comentarios (id_operador
, id_ticket
, texto
) 
VALUES ( 4, 6, 'Se realiza reclamo por caso abierto');

-- 6
INSERT INTO comentarios (id_operador
, id_ticket
, texto
) 
VALUES ( 4, 8, 'Reclamo, necesito celeridad');

-- 7
INSERT INTO comentarios (id_operador
, id_ticket
, texto
, solucion
) 
VALUES ( 2, 7, 'Comentario solucion', 1);

-- Views
-- 1
CREATE OR REPLACE VIEW ListarTickets_vw AS(
SELECT ES.estado, SE.severidad, CA.categoria, GD.mesa, EM.empresa, C.nombre_completo AS Contacto, O.usuario as Operador, T.titulo, T.descripcion
FROM tickets T
INNER JOIN estados AS ES ON ES.ID = T.id_estado
INNER JOIN severidades AS SE ON SE.ID = T.id_severidad
INNER JOIN categorias AS CA ON CA.ID = T.id_categoria
INNER JOIN grupos_de_derivacion AS GD ON GD.ID = T.id_grupo_de_derivacion
INNER JOIN empresas AS EM ON EM.ID = T.id_empresa
INNER JOIN contactos AS C ON C.ID = T.id_contacto
INNER JOIN operadores as O ON O.ID = T.id_operador
);

-- 2
CREATE OR REPLACE VIEW list_contact_vw AS(
SELECT c.nombre_completo, p.pais as Pais_de_contacto, e.empresa, pu.puesto, t.telefono
FROM contactos c
INNER JOIN paises p ON p.ID = c.id_pais_contacto 
INNER JOIN empresas e ON e.ID = c.id_empresa_contacto
INNER JOIN puestos pu ON pu.ID = c.id_puesto_contacto
INNER JOIN telefonos t ON t.id_telefono_contacto = c.ID
);

-- 3
CREATE OR REPLACE VIEW list_empresas_vw AS(
SELECT e.empresa, p.pais, t.telefono, e.fecha_reg AS Alta_Empresa, ep.estado AS Activo
FROM empresas_x_paises AS ep
INNER JOIN paises p ON p.ID = ep.id_pais
INNER JOIN empresas e ON e.ID = ep.id_empresa
INNER JOIN telefonos t ON t.id_telefono_empresa = ep.id_empresa
);

-- 4
CREATE OR REPLACE VIEW list_operator_vw AS(
SELECT o.usuario, r.rol, o.fecha_reg AS Fecha_Alta, o.estado AS Activo
FROM operadores AS o
INNER JOIN roles AS r ON r.ID = o.id_rol_operador
);

-- 5
CREATE OR REPLACE VIEW tickets_successful AS (
SELECT t.id, em.empresa, t.titulo, e.estado, o.usuario AS Operador
FROM Tickets as t
INNER JOIN operadores AS o ON o.id = t.id_operador
INNER JOIN estados AS e ON e.id = t.id_estado
INNER JOIN empresas AS em ON em.id = t.id_empresa
WHERE t.id_estado = 3
);

-- 6
CREATE OR REPLACE VIEW tickets_closed AS (
SELECT t.id as Ticket, em.empresa, t.titulo, e.estado, o.usuario AS Operador, t.fecha_fin as Fecha_cierre
FROM Tickets as t
INNER JOIN operadores AS o ON o.id = t.id_operador
INNER JOIN estados AS e ON e.id = t.id_estado
INNER JOIN empresas AS em ON em.id = t.id_empresa
WHERE t.id_estado = 4
);

-- 7
CREATE OR REPLACE VIEW tickets_open_analisys AS (
SELECT t.id as Ticket, em.empresa, t.titulo, e.estado, o.usuario AS Operador
FROM Tickets as t
INNER JOIN operadores AS o ON o.id = t.id_operador
INNER JOIN estados AS e ON e.id = t.id_estado
INNER JOIN empresas AS em ON em.id = t.id_empresa
WHERE t.id_estado = 1 AND 2
);

-- 8
CREATE OR REPLACE VIEW tickets_empresa AS (
SELECT e.ID, e.empresa, t.ID as Ticket, t.titulo, t.fecha_inicio, es.estado, gdd.mesa
FROM empresas as e
INNER JOIN tickets as t ON t.id_empresa = e.ID
INNER JOIN estados as es ON t.id_estado = es.ID
INNER JOIN grupos_de_derivacion as gdd ON t.id_grupo_de_derivacion = gdd.ID
ORDER BY e.empresa asc
);

-- 9
CREATE OR REPLACE VIEW tickets_count_empresa AS (
SELECT COUNT(t.ID) as Cantidad_de_tickets, e.empresa
FROM empresas as e
INNER JOIN tickets as t ON t.id_empresa = e.ID
GROUP BY e.empresa
ORDER BY e.empresa asc
);

-- 10
CREATE OR REPLACE VIEW tickets_employees AS (
SELECT o.ID, o.usuario as Operador, t.ID as Ticket, t.titulo, t.fecha_inicio, es.estado, gdd.mesa
FROM operadores as o
INNER JOIN tickets as t ON t.id_empresa = o.ID
INNER JOIN estados as es ON t.id_estado = es.ID
INNER JOIN grupos_de_derivacion as gdd ON t.id_grupo_de_derivacion = gdd.ID
ORDER BY o.usuario asc
);

-- 11
CREATE OR REPLACE VIEW tickets_count_employees AS (
SELECT COUNT(t.ID) as Cantidad_de_tickets, o.usuario
FROM operadores as o
INNER JOIN tickets as t ON t.id_empresa = o.ID
GROUP BY o.usuario
ORDER BY o.usuario asc
);

-- 12
CREATE OR REPLACE VIEW tickets_count_status AS (
SELECT COUNT(t.ID) as Cantidad_de_tickets, e.estado
FROM tickets as t
INNER JOIN estados as e on e.ID = t.id_estado
GROUP BY e.estado
ORDER BY e.estado asc
);

-- Function
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

-- FUNCION QUE DEVUELVE INT ALEATORIO
DELIMITER $$
CREATE FUNCTION f_random() RETURNS int
NO SQL
BEGIN
    DECLARE num_random INT;
    SET num_random = 0;
    SELECT FLOOR(RAND()*(999999-100+1))+100 INTO num_random;
    RETURN num_random;
END $$

DELIMITER ;

-- STORE PROCEDURE
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

-- TRIGGER
-- 1 
-- CAMBIOS EN TICKETS
DELIMITER $$
CREATE TRIGGER tr_update_ticket
AFTER UPDATE ON tickets
FOR EACH ROW
BEGIN
INSERT INTO log_ticket (event_name, ID, operador_viejo, operador_nuevo, severidad_viejo, severidad_nuevo, estado_viejo, estado_nuevo, grupo_de_derivacion_viejo, grupo_de_derivacion_nuevo, usuario, fecha) 
VALUES ('Cambios en ticket', new.ID, OLD.id_operador, NEW.id_operador, OLD.id_severidad, NEW.id_severidad, OLD.id_estado, NEW.id_estado, OLD.id_grupo_de_derivacion, NEW.id_grupo_de_derivacion, USER(), NOW());
END$$

-- 2
-- CREACION DE EMPRESA
DELIMITER $$
CREATE TRIGGER tr_create_empresa
AFTER INSERT ON empresas
FOR EACH ROW
BEGIN
INSERT INTO log_empresa(event_name, ID, empresa, estado, usuario, fecha)
VALUES ('Creacion empresa', new.ID, new.empresa, new.estado, USER(), NOW());
END$$

DELIMITER ;

-- TCL
use mysql;
select * from user; -- mostrar todos los usuarios
CREATE USER 'administrador1'@'localhost' identified by 'abm123'; -- creacion de administrador usuario con pass
CREATE USER 'teamleader1'@'localhost' identified by '0123tl'; -- creacion de teamleader usuario con pass
CREATE USER 'operador1'@'localhost' identified by 'lrodriguez'; -- creacion de operador usuario con pass

GRANT ALL ON *.* TO 'administrador1'@'localhost'; -- dar todos los permisos
FLUSH privileges;
GRANT SELECT, INSERT, UPDATE, DELETE ON call_center_db.categorias TO 'teamleader1'@'localhost';
FLUSH privileges;
GRANT SELECT,INSERT, UPDATE, DELETE ON call_center_db.comentarios TO 'teamleader1'@'localhost';
FLUSH privileges;
GRANT SELECT,INSERT, UPDATE, DELETE ON call_center_db.contactos TO 'teamleader1'@'localhost';
FLUSH privileges;
GRANT SELECT,INSERT, UPDATE, DELETE ON call_center_db.log_empresa TO 'teamleader1'@'localhost';
FLUSH privileges;
GRANT SELECT,INSERT, UPDATE, DELETE ON call_center_db.log_ticket TO 'teamleader1'@'localhost';
FLUSH privileges;
GRANT SELECT,INSERT, UPDATE, DELETE ON call_center_db.operadores TO 'teamleader1'@'localhost';
FLUSH privileges;
GRANT SELECT,INSERT, UPDATE, DELETE ON call_center_db.telefonos TO 'teamleader1'@'localhost';
FLUSH privileges;
GRANT SELECT,INSERT, UPDATE, DELETE ON call_center_db.tickets TO 'teamleader1'@'localhost';
FLUSH privileges;
GRANT SELECT,INSERT, UPDATE, DELETE ON call_center_db.comentarios TO 'operador1'@'localhost';
FLUSH privileges;
GRANT SELECT,INSERT, UPDATE, DELETE ON call_center_db.contactos TO 'operador1'@'localhost';
FLUSH privileges;
GRANT SELECT,INSERT, UPDATE, DELETE ON call_center_db.operadores TO 'operador1'@'localhost';
FLUSH privileges;
GRANT SELECT,INSERT, UPDATE, DELETE ON call_center_db.telefonos TO 'operador1'@'localhost';
FLUSH privileges;
GRANT SELECT,INSERT, UPDATE, DELETE ON call_center_db.tickets TO 'operador1'@'localhost';
FLUSH privileges;