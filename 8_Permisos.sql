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

SHOW GRANTS FOR 'administrador1'@'localhost';
SHOW GRANTS FOR 'teamleader1'@'localhost';
SHOW GRANTS FOR 'operador1'@'localhost';

/*
CREATE USER 'entrega'@'localhost' identified by 'gamertp'; -- creacion de 1er usuario con pass
CREATE USER 'entrega2'@'localhost' identified by 'gamertp2'; -- creacion de 2do usuario con pass

GRANT SELECT ON call_center_db.empresas TO 'entrega'@'localhost'; -- solo lectura en empresas para usuario entrega
FLUSH privileges;

GRANT SELECT, INSERT, UPDATE ON call_center_db.operadores TO 'entrega2'@'localhost'; -- lectura, insersion y modificacion en operadores para usuario entrega2
FLUSH privileges;

REVOKE SELECT, INSERT, UPDATE ON call_center_db.operadores FROM 'entrega2'@'localhost'; -- sacamos permisos otorgados en linea anterior.

SHOW GRANTS FOR 'entrega'@'localhost';
SHOW GRANTS FOR 'entrega2'@'localhost';
/*
-- CREATE USER 'compuoreja'@'localhost' identified by 'Fixeos90'; -- creacion de usuario con pass
-- GRANT ALL ON *.* TO 'compuoreja'@'localhost'; -- dar todos los permisos
-- SHOW GRANTS FOR 'compuoreja'@'localhost'; -- mostrar permisos
-- GRANT ALL ON call_center_db.tickets TO 'compuoreja'@'localhost'; -- permisos en tabla

-- GRANT SELECT, UPDATE ON call_center_db.telefonos TO 'compuoreja'@'localhost'; -- permisos en sentencias
-- FLUSH privileges;

-- GRANT UPDATE, SELECT (texto) on call_center_db.comentarios TO 'compuoreja'@'localhost'; -- permisos de sentencias en columnas de una tabla
-- FLUSH privileges;
-- SHOW GRANTS FOR 'compuoreja'@'localhost'; -- mostrar permisos en usuario

-- REVOKE SELECT, UPDATE ON call_center_db.telefonos FROM 'compuoreja'@'localhost'; -- revocar permisos en sentencias.
-- REVOKE ALL ON *.* call_center_db.tickets FROM 'compuoreja'@'locahost'; -- revocar todos los permisos (tanto en tablas como ne sentencias)tira error en el from