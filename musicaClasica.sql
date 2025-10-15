-- MySQL dump 10.13  Distrib 8.0.40, for macos14 (arm64)
--
-- Host: localhost    Database: musicaClasica
-- ------------------------------------------------------
-- Server version	8.0.40

CREATE DATABASE IF NOT EXISTS musicaClasica;

USE musicaClasica; 
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `autor`
--

DROP TABLE IF EXISTS `autor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autor` (
  `nombre` varchar(50) NOT NULL,
  `f_nac` date NOT NULL,
  `nacion` varchar(30) NOT NULL,
  `f_def` date DEFAULT NULL,
  `genero` varchar(30) NOT NULL,
  PRIMARY KEY (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autor`
--

LOCK TABLES `autor` WRITE;
/*!40000 ALTER TABLE `autor` DISABLE KEYS */;
INSERT INTO `autor` VALUES ('Bach','1685-03-21','Alemania','1750-07-28','Barroco'),('Beethoven','1770-12-17','Alemania','1827-03-26','Romantico'),('Blas Galindo','1910-11-30','Mexico',NULL,'Nacionalista'),('Brahms','1833-05-07','Alemania','1897-04-03','Romantico'),('Chopin','1810-06-01','Polonia','1849-09-27','Romantico'),('Daniel Ayala','1908-06-03','Mexico',NULL,'Nacionalista'),('Debussy','1862-08-22','Francia','1918-03-25','Impresionista'),('Heitor Villa-Lobos','1887-05-14','Brasil','1959-10-04','Nacionalista'),('Mozart','1756-01-27','Austria','1791-12-05','Clasico'),('Pablo Moncayo','1912-04-01','Mexico','1958-07-31','Nacionalista'),('Rachmaninoff','1873-02-28','Rusia','1943-12-31','Neoromantico'),('Vivaldi','1678-03-04','Italia','1741-07-28','Barroco');
/*!40000 ALTER TABLE `autor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disco`
--

DROP TABLE IF EXISTS `disco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disco` (
  `cat` int unsigned NOT NULL,
  `año_grab` int NOT NULL,
  `precio` decimal(5,2) NOT NULL,
  `tipo` varchar(10) NOT NULL,
  PRIMARY KEY (`cat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disco`
--

LOCK TABLES `disco` WRITE;
/*!40000 ALTER TABLE `disco` DISABLE KEYS */;
INSERT INTO `disco` VALUES (519,1988,10.50,'CD'),(5615,1985,13.75,'CD'),(5801,1975,18.15,'Acetato'),(12301,1970,15.00,'Acetato'),(44944,1990,15.00,'CD'),(45818,1990,18.00,'CD'),(47901,1987,35.00,'CD'),(49991,1992,10.99,'CD'),(60345,2001,22.50,'CD'),(78891,2005,19.99,'CD'),(80264,1988,12.50,'CD'),(85120,1995,11.99,'CD'),(198304,1977,8.00,'Acetato'),(415839,1987,16.25,'CD');
/*!40000 ALTER TABLE `disco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grabacion`
--

DROP TABLE IF EXISTS `grabacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grabacion` (
  `cat` int unsigned NOT NULL,
  `obra` varchar(50) NOT NULL,
  `interprete` varchar(50) NOT NULL,
  `durac` int NOT NULL,
  PRIMARY KEY (`cat`,`obra`),
  KEY `obra` (`obra`),
  CONSTRAINT `grabacion_ibfk_1` FOREIGN KEY (`cat`) REFERENCES `disco` (`cat`),
  CONSTRAINT `grabacion_ibfk_2` FOREIGN KEY (`obra`) REFERENCES `obra` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grabacion`
--

LOCK TABLES `grabacion` WRITE;
/*!40000 ALTER TABLE `grabacion` DISABLE KEYS */;
INSERT INTO `grabacion` VALUES (519,'Huapango','Herrera de la Fuente',828),(519,'Sones de mariachi','Herrera de la Fuente',824),(519,'Tribu','Herrera de la Fuente',655),(5615,'Polonesa op 26 no 1','Rubinstein',740),(5615,'Polonesa op 53','Rubinstein',705),(12301,'Ah vous dirai-je, Maman','Mitsuko Uchida',210),(12301,'Le nozze di Figaro','Solti',9000),(12301,'Sonata No. 11: Alla Turca','Mitsuko Uchida',240),(45818,'Mazurka op 56 no 3','Horowitz',505),(47901,'Bachiana no 1','Batiz',2051),(49991,'Polonesa op 53','Krystian Zimerman',705),(49991,'Preludio op 3 no 2','Horowitz',440),(60345,'Arabesque No. 1','Jean-Yves Thibaudet',300),(60345,'Clair de Lune','Jean-Yves Thibaudet',320),(60345,'Rêverie','Jean-Yves Thibaudet',280),(78891,'Danza Hungara No. 5','Claudio Abbado',120),(78891,'Gloria','King\'s College Choir',1800),(78891,'Las Cuatro Estaciones','Anne-Sophie Mutter',2500),(80264,'Preludio op 3 no 2','Michel Block',440),(85120,'Für Elise','Lang Lang',180),(85120,'Moonlight Sonata','Lang Lang',360),(85120,'Symphony No. 5','Wiener Philharmoniker',4200),(198304,'Tocata y fuga bwv538','Helmut Walcha',1302),(198304,'Tocata y fuga bwv540','Helmut Walcha',1502),(198304,'Tocata y fuga bwv565','Helmut Walcha',916);
/*!40000 ALTER TABLE `grabacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obra`
--

DROP TABLE IF EXISTS `obra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `obra` (
  `nombre` varchar(50) NOT NULL,
  `autor` varchar(50) NOT NULL,
  `año_crea` int NOT NULL,
  PRIMARY KEY (`nombre`),
  KEY `autor` (`autor`),
  CONSTRAINT `obra_ibfk_1` FOREIGN KEY (`autor`) REFERENCES `autor` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obra`
--

LOCK TABLES `obra` WRITE;
/*!40000 ALTER TABLE `obra` DISABLE KEYS */;
INSERT INTO `obra` VALUES ('Ah vous dirai-je, Maman','Mozart',1785),('Arabesque No. 1','Debussy',1888),('Bachiana no 1','Heitor Villa-Lobos',1930),('Clair de Lune','Debussy',1890),('Danza Hungara No. 5','Brahms',1869),('Für Elise','Beethoven',1810),('Gloria','Vivaldi',1715),('Huapango','Pablo Moncayo',1942),('Las Cuatro Estaciones','Vivaldi',1723),('Le nozze di Figaro','Mozart',1786),('Mazurka op 56 no 3','Chopin',1833),('Moonlight Sonata','Beethoven',1801),('Polonesa op 26 no 1','Chopin',1830),('Polonesa op 53','Chopin',1833),('Preludio op 3 no 2','Rachmaninoff',1913),('Rêverie','Debussy',1890),('Sonata No. 11: Alla Turca','Mozart',1783),('Sones de mariachi','Blas Galindo',1955),('Symphony No. 5','Beethoven',1808),('Tocata y fuga bwv538','Bach',1720),('Tocata y fuga bwv540','Bach',1720),('Tocata y fuga bwv565','Bach',1722),('Tribu','Daniel Ayala',1955);
/*!40000 ALTER TABLE `obra` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-02 17:22:56
