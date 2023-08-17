use mysql;
select * from user; -- mostrar todos los usuarios

CREATE USER 'entrega'@'localhost' identified by 'gamertp'; -- creacion de 1er usuario con pass
CREATE USER 'entrega2'@'localhost' identified by 'gamertp2'; -- creacion de 2do usuario con pass

GRANT SELECT ON call_center_db.empresas TO 'entrega'@'localhost'; -- solo lectura en empresas para usuario entrega
FLUSH privileges;

GRANT SELECT, INSERT, UPDATE ON call_center_db.operadores TO 'entrega2'@'localhost'; -- lectura, insersion y modificacion en operadores para usuario entrega2
FLUSH privileges;

REVOKE SELECT, INSERT, UPDATE ON call_center_db.operadores FROM 'entrega2'@'localhost'; -- sacamos permisos otorgados en linea anterior.

SHOW GRANTS FOR 'entrega'@'localhost';
SHOW GRANTS FOR 'entrega2'@'localhost';

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