USE call_center_db;

-- 1
START TRANSACTION;

INSERT INTO categorias(categoria) VALUES ('operativo');
INSERT INTO categorias(categoria) VALUES ('sin alcance MDA');
INSERT INTO categorias(categoria) VALUES ('Oficinas');
INSERT INTO categorias(categoria) VALUES ('Consulta');
INSERT INTO categorias(categoria) VALUES ('Error interno');

-- ROLLBACK;
COMMIT;

-- 2
START TRANSACTION;

INSERT INTO paises(pais) VALUES ('China');
INSERT INTO paises(pais) VALUES ('Irlanda');
INSERT INTO paises(pais) VALUES ('Canada');
INSERT INTO paises(pais) VALUES ('Estados Unidos');

SAVEPOINT primeros_cuatro;
-- release savepoint primeros_cuatro;

INSERT INTO paises(pais) VALUES ('India');
INSERT INTO paises(pais) VALUES ('Inglaterra');
INSERT INTO paises(pais) VALUES ('Rusia');
INSERT INTO paises(pais) VALUES ('Mongolia');

SAVEPOINT segundos_cuatros;

COMMIT;
