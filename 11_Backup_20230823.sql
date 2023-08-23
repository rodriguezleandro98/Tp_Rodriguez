-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: call_center_db
-- ------------------------------------------------------
-- Server version	8.0.33

-- SE REALIZO BACKUP DE LOS DATOS DE TODAS LAS TABLAS DE LA BBDD

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Hardware',1),(2,'Software',1),(3,'Interno',1),(4,'Externo',1),(5,'RRHH',1),(6,'IT',1),(7,'operativo',1),(8,'sin alcance MDA',1),(9,'Oficinas',1),(10,'Consulta',1),(11,'Error interno',1);
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `comentarios`
--

LOCK TABLES `comentarios` WRITE;
/*!40000 ALTER TABLE `comentarios` DISABLE KEYS */;
INSERT INTO `comentarios` VALUES (1,1,1,'Primer comentario','2023-08-10 20:23:54',NULL),(2,1,2,'Solamente comento','2023-08-10 20:23:54',NULL),(3,1,3,'Se logra solucionar','2023-08-10 20:23:54',1),(4,2,4,'Derivado','2023-08-10 20:23:54',NULL),(5,4,6,'Se realiza reclamo por caso abierto','2023-08-10 20:23:54',NULL),(6,4,8,'Reclamo, necesito celeridad','2023-08-10 20:23:54',NULL),(7,2,7,'Comentario solucion','2023-08-10 20:23:54',1),(8,1,3,'Buenas como le va es un comentario','2023-08-10 20:57:29',NULL);
/*!40000 ALTER TABLE `comentarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `contactos`
--

LOCK TABLES `contactos` WRITE;
/*!40000 ALTER TABLE `contactos` DISABLE KEYS */;
INSERT INTO `contactos` VALUES (1,'Leandro Rodriguez','41390062',1,1,1),(2,'Ariel Rodriguez','39009709',1,3,2),(3,'Nancy Regner','20875960',3,2,3),(4,'Pepe Luis','12345678',5,4,3),(5,'Ruben Alcaraz','98765432',2,2,3),(6,'Javier Arbulu','45645645',4,5,3),(7,'Jose Rodriguez','12378956',6,6,1),(8,'Arnoldo Regner','45896314',7,1,1);
/*!40000 ALTER TABLE `contactos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `empresas`
--

LOCK TABLES `empresas` WRITE;
/*!40000 ALTER TABLE `empresas` DISABLE KEYS */;
INSERT INTO `empresas` VALUES (1,'Arcos Dorados','2023-08-10 20:23:54',1),(2,'Siemmens','2023-08-10 20:23:54',1),(3,'Cola Cola Company','2023-08-10 20:23:54',1),(4,'Pepsi','2023-08-10 20:23:54',1),(5,'Burgen King','2023-08-10 20:23:54',1),(6,'Zhoe','2023-08-10 20:23:54',1),(7,'Mimo','2023-08-10 20:23:54',1),(8,'Dior','2023-08-10 20:23:54',1);
/*!40000 ALTER TABLE `empresas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `empresas_x_paises`
--

LOCK TABLES `empresas_x_paises` WRITE;
/*!40000 ALTER TABLE `empresas_x_paises` DISABLE KEYS */;
INSERT INTO `empresas_x_paises` VALUES (1,1,1),(1,2,1),(2,1,1),(2,3,1),(3,3,1),(4,1,1),(4,4,1),(5,2,1),(6,5,1),(7,2,1),(8,6,1),(8,7,1);
/*!40000 ALTER TABLE `empresas_x_paises` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `estados`
--

LOCK TABLES `estados` WRITE;
/*!40000 ALTER TABLE `estados` DISABLE KEYS */;
INSERT INTO `estados` VALUES (1,'Abierto'),(2,'En analisis'),(3,'Solucionado'),(4,'Cerrado'),(5,'Rechazado');
/*!40000 ALTER TABLE `estados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `grupos_de_derivacion`
--

LOCK TABLES `grupos_de_derivacion` WRITE;
/*!40000 ALTER TABLE `grupos_de_derivacion` DISABLE KEYS */;
INSERT INTO `grupos_de_derivacion` VALUES (1,'MDA',1),(2,'MDA N2',1),(3,'SLAD N2',1),(4,'SLAD N3',1),(5,'IT',1);
/*!40000 ALTER TABLE `grupos_de_derivacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `log_empresa`
--

LOCK TABLES `log_empresa` WRITE;
/*!40000 ALTER TABLE `log_empresa` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `log_ticket`
--

LOCK TABLES `log_ticket` WRITE;
/*!40000 ALTER TABLE `log_ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `operadores`
--

LOCK TABLES `operadores` WRITE;
/*!40000 ALTER TABLE `operadores` DISABLE KEYS */;
INSERT INTO `operadores` VALUES (1,'lrodriguez','password01',1,'2023-08-10 20:23:54',1),(2,'nyamarte','Modelo.01',2,'2023-08-10 20:23:54',1),(3,'jferrufino','Moldes3060',2,'2023-08-10 20:23:54',1),(4,'jsordello','juanmecha',3,'2023-08-10 20:23:54',1),(5,'camblorpepe','contraseña123',3,'2023-08-10 20:23:54',1);
/*!40000 ALTER TABLE `operadores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `paises`
--

LOCK TABLES `paises` WRITE;
/*!40000 ALTER TABLE `paises` DISABLE KEYS */;
INSERT INTO `paises` VALUES (1,'Argentina',1),(2,'Chile',1),(3,'Uruguay',1),(4,'Brasil',1),(5,'Ecuador',1),(6,'Peru',1),(7,'Bolivia',1),(8,'China',1),(9,'Irlanda',1),(10,'Canada',1),(11,'Estados Unidos',1),(12,'India',1),(13,'Inglaterra',1),(14,'Rusia',1),(15,'Mongolia',1);
/*!40000 ALTER TABLE `paises` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `puestos`
--

LOCK TABLES `puestos` WRITE;
/*!40000 ALTER TABLE `puestos` DISABLE KEYS */;
INSERT INTO `puestos` VALUES (1,'Presidente',1),(2,'CEO',1),(3,'Gerente',1),(4,'Empleado',1);
/*!40000 ALTER TABLE `puestos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrador'),(2,'TeamLeader'),(3,'Operador');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `severidades`
--

LOCK TABLES `severidades` WRITE;
/*!40000 ALTER TABLE `severidades` DISABLE KEYS */;
INSERT INTO `severidades` VALUES (1,'Baja',1),(2,'Media',1),(3,'Alta',1),(4,'Critica',1),(5,'Urgente',1);
/*!40000 ALTER TABLE `severidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `telefonos`
--

LOCK TABLES `telefonos` WRITE;
/*!40000 ALTER TABLE `telefonos` DISABLE KEYS */;
INSERT INTO `telefonos` VALUES (1,'47954341',1,NULL,1),(2,'45612385',2,NULL,1),(3,'55448899',4,NULL,1),(4,'1164707899',1,NULL,1),(5,'45612315',6,NULL,1),(6,'89413594',5,NULL,1),(7,'78945164',2,NULL,1),(8,'896532141',NULL,1,1),(9,'47354641',NULL,2,1),(10,'47354942',NULL,3,1),(11,'47354643',NULL,7,1),(12,'47354344',NULL,8,1),(13,'47354945',NULL,3,1),(14,'47354946',NULL,5,1);
/*!40000 ALTER TABLE `telefonos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (1,1,1,1,1,1,1,1,'Prueba1','Descripcion prueba','2023-08-10 20:23:54',NULL),(2,1,2,3,2,3,4,2,'Prueba2','Descripcion prueba2','2023-08-10 20:23:54',NULL),(3,1,3,2,1,1,3,3,'Prueba lalalalal 3','Se comunica por falla de equipo, se logra resolver','2023-08-10 20:23:54',NULL),(4,2,4,4,2,5,2,4,'CCC - Cambio en RRHH','Gerente pide cambiar cargo en sistema RRHH','2023-08-10 20:23:54',NULL),(5,3,5,2,4,5,1,5,'Prueba5','Descripcion pruebaaaaaaa5','2023-08-10 20:23:54',NULL),(6,4,6,5,1,1,1,1,'ya me canse','lo mismo que el titulo','2023-08-10 20:23:54',NULL),(7,2,7,6,3,3,3,2,'otra vez?','si querido','2023-08-10 20:23:54',NULL),(8,4,7,6,1,1,1,3,'bueno basta','ok te respeto','2023-08-10 20:23:54',NULL);
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-23 15:19:01
