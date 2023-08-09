USE call_center_db;

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