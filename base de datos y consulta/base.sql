/*
SQLyog Community v13.1.8 (64 bit)
MySQL - 5.6.51-log : Database - prueba_tecnica
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `alumnos` */
CREATE DATABASE prueba_tecnica;
use prueba_tecnica;

DROP TABLE IF EXISTS `alumnos`;

CREATE TABLE `alumnos` (
  `dni` int(10) NOT NULL DEFAULT '0',
  `apellido` varchar(100) DEFAULT NULL,
  `nombres` varchar(100) DEFAULT NULL,
  `calle` varchar(100) DEFAULT NULL,
  `nro` int(10) DEFAULT NULL,
  PRIMARY KEY (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `alumnos` */

insert  into `alumnos`(`dni`,`apellido`,`nombres`,`calle`,`nro`) values 
(11111111,'Luna','Roberto','San Luis',365),
(22222222,'Pérez','Luis','Chacabuco',3615),
(33333333,'López','María','Lopez Torrez',2045),
(44444444,'Antúnez','David','Alberto Roth',2315),
(55555555,'Villalba','Estela','San Martin',615),
(66666666,'Villar','Roxana','Santa Fé',315),
(77777777,'Zarza','Luis','Las Américas',365),
(88888888,'Estevéz','Mónica','Santa Catalina',4615);

/*Table structure for table `cursos` */

DROP TABLE IF EXISTS `cursos`;

CREATE TABLE `cursos` (
  `cod_curso` varchar(10) NOT NULL DEFAULT '',
  `descripcion` varchar(100) DEFAULT NULL,
  `cod_dep` int(5) NOT NULL,
  `dni_prof` int(10) NOT NULL,
  `abreviatura` varchar(250) NOT NULL,
  PRIMARY KEY (`cod_curso`),
  KEY `FKCursos_Profesor` (`dni_prof`),
  KEY `FKCursos_Departamentos` (`cod_dep`),
  CONSTRAINT `FKCursos_Departamentos` FOREIGN KEY (`cod_dep`) REFERENCES `Departamentos` (`cod_dep`),
  CONSTRAINT `FKCursos_Profesor` FOREIGN KEY (`dni_prof`) REFERENCES `Profesores` (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cursos` */

insert  into `cursos`(`cod_curso`,`desccripcion`,`cod_dep`,`dni_prof`,`abreviatura`) values 
('1','Introducción a Java',2,10111111,'IntJava'),
('2','Introducción a Base De Datos',1,10333333,'IntBd'),
('3','Desarrollo Front End',2,10555555,'DesFE'),
('4','Desarrollo Back End',2,10222222,'DesBE'),
('5','Excel Básico',3,10444444,'ExBas');

/*Table structure for table `departamentos` */

DROP TABLE IF EXISTS `departamentos`;

CREATE TABLE `departamentos` (
  `cod_dep` int(5) NOT NULL DEFAULT '0',
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`cod_dep`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `departamentos` */

insert  into `departamentos`(`cod_dep`,`descripcion`) values 
(1,'Base Datos'),
(2,'Programacion'),
(3,'Informática'),
(4,'Seguridad e Higiene');

/*Table structure for table `inscripciones` */

DROP TABLE IF EXISTS `inscripciones`;

CREATE TABLE `inscripciones` (
  `dni_Alu` int(10) NOT NULL,
  `cod_curso` varchar(10) NOT NULL,
  KEY `FKInscripciones_Alumnos` (`dni_Alu`),
  KEY `FKIncripciones_Cursos` (`cod_curso`),
  CONSTRAINT `FKIncripciones_Cursos` FOREIGN KEY (`cod_curso`) REFERENCES `cursos` (`cod_curso`),
  CONSTRAINT `FKInscripciones_Alumnos` FOREIGN KEY (`dni_Alu`) REFERENCES `alumnos` (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `inscripciones` */

insert  into `inscripciones`(`dni_Alu`,`cod_curso`) values 
(11111111,'1'),
(33333333,'1'),
(22222222,'2'),
(44444444,'2'),
(55555555,'3'),
(66666666,'3'),
(11111111,'3'),
(33333333,'3'),
(11111111,'4'),
(33333333,'4'),
(22222222,'4'),
(44444444,'4'),
(55555555,'4');

/*Table structure for table `pagos` */

DROP TABLE IF EXISTS `pagos`;

CREATE TABLE `pagos` (
  `dni_alu` int(10) NOT NULL DEFAULT '0',
  `cod_curso` varchar(10) NOT NULL DEFAULT '',
  `mes` int(2) NOT NULL DEFAULT '0',
  `anio` int(4) NOT NULL DEFAULT '0',
  `fecha` date DEFAULT NULL,
  `monto` double DEFAULT NULL,
  PRIMARY KEY (`cod_curso`,`dni_alu`,`mes`,`anio`),
  KEY `FKPAgos_Alumnos` (`dni_alu`),
  CONSTRAINT `FKPAgos_Alumnos` FOREIGN KEY (`dni_alu`) REFERENCES `alumnos` (`dni`),
  CONSTRAINT `FKPagos_Cursos` FOREIGN KEY (`cod_curso`) REFERENCES `cursos` (`cod_curso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `pagos` */

insert  into `pagos`(`dni_alu`,`cod_curso`,`mes`,`anio`,`fecha`,`monto`) values 
(11111111,'1',3,2023,'2023-03-05',2500),
(11111111,'1',4,2023,'2023-04-05',2500),
(11111111,'1',5,2023,'2023-05-05',2500),
(11111111,'1',6,2023,'2023-06-05',2500),
(33333333,'1',3,2023,'2023-03-05',2500),
(33333333,'1',4,2023,'2023-04-05',2500),
(33333333,'1',5,2023,'2023-05-05',2500),
(33333333,'1',6,2023,'2023-06-05',2500),
(11111111,'4',6,2023,'2023-06-05',2500),
(22222222,'4',6,2023,'2023-06-05',2500),
(33333333,'4',6,2023,'2023-06-05',2500);

/*Table structure for table `profesores` */

DROP TABLE IF EXISTS `profesores`;

CREATE TABLE `profesores` (
  `dni` int(10) NOT NULL DEFAULT '0',
  `apellido` varchar(100) DEFAULT NULL,
  `nombres` varchar(100) DEFAULT NULL,
  `calle` varchar(100) DEFAULT NULL,
  `nro` int(10) DEFAULT NULL,
  `cod_titulo` int(5) NOT NULL,
  PRIMARY KEY (`dni`),
  KEY `FKProfesor_Titulo` (`cod_titulo`),
  CONSTRAINT `FKProfesor_Titulo` FOREIGN KEY (`cod_titulo`) REFERENCES `titulos_habilitantes` (`cod_titulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `profesores` */

insert  into `profesores`(`dni`,`apellido`,`nombres`,`calle`,`nro`,`cod_titulo`) values 
(10111111,'Pérez','Roberto','San Luis',365,1),
(10222222,'López','Luis','Chacabuco',3615,3),
(10333333,'Villar','María','Lopez Torrez',2045,4),
(10444444,'Vazquez','David','Alberto Roth',2315,5),
(10555555,'Olmedo','Estela','San Martin',615,2),
(10666666,'Zado','Roxana','Santa Fé',315,6),
(10777777,'Escobar','Luis','Las Américas',365,3),
(10888888,'Martinez','Mónica','Santa Catalina',4615,6);

/*Table structure for table `telefonos_alumnos` */

DROP TABLE IF EXISTS `telefonos_alumnos`;

CREATE TABLE `telefonos_alumnos` (
  `dni` int(10) NOT NULL,
  `cod_tipo_tel` int(3) NOT NULL,
  `numero` int(20) NOT NULL,
  PRIMARY KEY (`dni`,`cod_tipo_tel`,`numero`),
  KEY `FKTelefonos_Alumnos_Tipo_Tel` (`cod_tipo_tel`),
  CONSTRAINT `FKTelefonos_Alumnos_Alum` FOREIGN KEY (`dni`) REFERENCES `alumnos` (`dni`),
  CONSTRAINT `FKTelefonos_Alumnos_Tipo_Tel` FOREIGN KEY (`cod_tipo_tel`) REFERENCES `tipos_telefonos` (`cod_tipo_tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `telefonos_alumnos` */

insert  into `telefonos_alumnos`(`dni`,`cod_tipo_tel`,`numero`) values 
(11111111,1,42424242),
(22222222,1,24242424),
(33333333,1,5425897),
(55555555,1,4248424),
(66666666,1,8247434),
(22222222,2,6424424),
(44444444,2,1254783),
(66666666,2,5298743);

/*Table structure for table `telefonos_profesores` */

DROP TABLE IF EXISTS `telefonos_profesores`;

CREATE TABLE `telefonos_profesores` (
  `dni` int(10) NOT NULL,
  `cod_tipo_tel` int(3) NOT NULL,
  `numero` int(20) NOT NULL,
  PRIMARY KEY (`dni`,`cod_tipo_tel`,`numero`),
  KEY `FKTelefonos_Profesores_Tipo_Tel` (`cod_tipo_tel`),
  CONSTRAINT `FKTelefonos_Profesores_Profe` FOREIGN KEY (`dni`) REFERENCES `profesores` (`dni`),
  CONSTRAINT `FKTelefonos_Profesores_Tipo_Tel` FOREIGN KEY (`cod_tipo_tel`) REFERENCES `tipos_telefonos` (`cod_tipo_tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `telefonos_profesores` */

insert  into `telefonos_profesores`(`dni`,`cod_tipo_tel`,`numero`) values 
(10111111,1,42424242),
(10222222,1,24242424),
(10333333,1,5425897),
(10555555,1,4248424),
(10666666,1,8247434),
(10222222,2,6424424),
(10444444,2,1254783),
(10666666,2,5298743);

/*Table structure for table `tipos_telefonos` */

DROP TABLE IF EXISTS `tipos_telefonos`;

CREATE TABLE `tipos_telefonos` (
  `cod_tipo_tel` int(3) NOT NULL DEFAULT '0',
  `descripcion` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`cod_tipo_tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tipos_telefonos` */

insert  into `tipos_telefonos`(`cod_tipo_tel`,`descripcion`) values 
(1,'Fijo'),
(2,'Celular');

/*Table structure for table `titulos_habilitantes` */

DROP TABLE IF EXISTS `titulos_habilitantes`;

CREATE TABLE `titulos_habilitantes` (
  `cod_titulo` int(5) NOT NULL DEFAULT '0',
  `titulo` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`cod_titulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `titulos_habilitantes` */

insert  into `titulos_habilitantes`(`cod_titulo`,`titulo`) values 
(1,'Instructor Java'),
(2,'Instructor Front End'),
(3,'Instructor Back End'),
(4,'Instructor Base Datos'),
(5,'Instructor Ofimática'),
(6,'Instructor App Movil');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
