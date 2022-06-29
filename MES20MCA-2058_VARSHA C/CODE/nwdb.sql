/*
SQLyog Community Edition- MySQL GUI v8.03 
MySQL - 5.1.32-community : Database - road damage
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`road damage` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `road damage`;

/*Table structure for table `accident` */

DROP TABLE IF EXISTS `accident`;

CREATE TABLE `accident` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `lattitude` int(11) DEFAULT NULL,
  `longitude` int(11) DEFAULT NULL,
  `date` varchar(200) DEFAULT NULL,
  `speed` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

/*Data for the table `accident` */

insert  into `accident`(`id`,`user_id`,`lattitude`,`longitude`,`date`,`speed`) values (1,2,6789,2346,'2020-11-22',456),(2,2,11,76,'2022-06-14',154.826),(3,2,11,76,'2022-06-14',30.4232),(4,2,11,76,'2022-06-14',65.5149),(5,2,11,76,'2022-06-14',3091.78),(6,2,11,76,'2022-06-14',70.6747),(7,2,11,76,'2022-06-14',461.047),(8,2,11,76,'2022-06-14',379.741),(9,2,11,76,'2022-06-14',2180.54),(10,2,11,76,'2022-06-14',79.607),(11,2,11,76,'2022-06-14',181.78),(12,2,11,65,'2022-08-09',NULL),(13,3,22,66,'2022-08-09',33),(14,2,11,76,'2022-06-27',149.392),(15,2,11,76,'2022-06-27',118.76);

/*Table structure for table `alert` */

DROP TABLE IF EXISTS `alert`;

CREATE TABLE `alert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imei` varchar(43) DEFAULT NULL,
  `lattitude` varchar(43) DEFAULT NULL,
  `longitude` varchar(43) DEFAULT NULL,
  `image` varchar(43) DEFAULT NULL,
  `result` varchar(34) DEFAULT NULL,
  `datetime` varchar(43) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=latin1;

/*Data for the table `alert` */

insert  into `alert`(`id`,`imei`,`lattitude`,`longitude`,`image`,`result`,`datetime`) values (1,'2720ecffcba4d58d','11.1409852','75.856845','abc.jpg','cracks','2022-02-01 11:26:56'),(2,'2720ecffcba4d58d','11.140555','75.8673749','abc.jpg','cracks','2022-02-01 11:42:45'),(3,'2720ecffcba4d58d','11.140555','75.8673749','abc.jpg','cracks','2022-02-01 11:42:54'),(4,'2720ecffcba4d58d','11.140555','75.8673749','abc.jpg','cracks','2022-02-01 11:43:04'),(5,'2720ecffcba4d58d','11.140555','75.8673749','abc.jpg','cracks','2022-02-01 11:43:15'),(6,'2720ecffcba4d58d','11.140555','75.8673749','abc.jpg','cracks','2022-02-01 11:43:27'),(7,'2720ecffcba4d58d','11.140555','75.8673749','abc.jpg','cracks','2022-02-01 11:43:39'),(8,'2720ecffcba4d58d','11.139121','75.8590236','abc.jpg','cracks','2022-02-01 11:43:54'),(9,'2720ecffcba4d58d','11.1373625','75.8655594','abc.jpg','cracks','2022-02-01 11:44:02'),(10,'2720ecffcba4d58d','11.140555','75.8673749','abc.jpg','cracks','2022-02-01 11:44:06'),(11,'2720ecffcba4d58d','11.1342378','75.8579343','abc.jpg','cracks','2022-02-01 11:44:16'),(12,'2720ecffcba4d58d','11.1342378','75.8579343','abc.jpg','cracks','2022-02-01 11:44:26'),(13,'2720ecffcba4d58d','11.1342378','75.8579343','abc.jpg','cracks','2022-02-01 11:44:37'),(14,'2720ecffcba4d58d','11.143505','75.8641071','abc.jpg','cracks','2022-02-01 11:44:50'),(15,'2720ecffcba4d58d','11.1422789','75.860113','abc.jpg','cracks','2022-02-01 11:45:04'),(16,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 11:45:19'),(17,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 11:45:34'),(18,'2720ecffcba4d58d','11.14278779','75.86286368','abc.jpg','cracks','2022-02-01 11:45:50'),(19,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 11:46:07'),(20,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 11:46:24'),(21,'2720ecffcba4d58d','11.14280719','75.86261139','abc.jpg','cracks','2022-02-01 11:46:43'),(22,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 11:47:04'),(23,'2720ecffcba4d58d','11.14288907','75.86287248','abc.jpg','cracks','2022-02-01 11:47:24'),(24,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 11:47:45'),(25,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 11:48:07'),(26,'2720ecffcba4d58d','11.14286344','75.86279156','abc.jpg','cracks','2022-02-01 11:48:31'),(27,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 11:48:59'),(28,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 11:49:07'),(29,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 11:49:17'),(30,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 11:49:27'),(31,'2720ecffcba4d58d','11.14295336','75.86290568','abc.jpg','cracks','2022-02-01 11:49:39'),(32,'2720ecffcba4d58d','11.14295336','75.86290568','abc.jpg','cracks','2022-02-01 11:49:51'),(33,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 11:50:04'),(34,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 11:50:18'),(35,'2720ecffcba4d58d','11.14292922','75.86289118','abc.jpg','cracks','2022-02-01 11:50:33'),(36,'2720ecffcba4d58d','11.14292922','75.86289118','abc.jpg','cracks','2022-02-01 11:50:48'),(37,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 11:51:05'),(38,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 11:51:22'),(39,'2720ecffcba4d58d','11.14293037','75.86291531','abc.jpg','cracks','2022-02-01 11:51:40'),(40,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 11:51:59'),(41,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 11:52:18'),(42,'2720ecffcba4d58d','11.14293862','75.86293235','abc.jpg','cracks','2022-02-01 11:52:38'),(43,'2720ecffcba4d58d','11.14293862','75.86293235','abc.jpg','cracks','2022-02-01 11:52:59'),(44,'2720ecffcba4d58d','11.1448855','75.8641071','abc.jpg','cracks','2022-02-01 11:53:22'),(45,'2720ecffcba4d58d','11.1448855','75.8641071','abc.jpg','cracks','2022-02-01 11:53:45'),(46,'2720ecffcba4d58d','11.1448855','75.8641071','abc.jpg','cracks','2022-02-01 11:54:09'),(47,'2720ecffcba4d58d','11.1448855','75.8641071','abc.jpg','cracks','2022-02-01 11:54:34'),(48,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 11:55:00'),(49,'2720ecffcba4d58d','11.14290741','75.86291958','abc.jpg','cracks','2022-02-01 11:55:26'),(50,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 11:55:56'),(51,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 11:56:06'),(52,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 11:56:16'),(53,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 11:56:27'),(54,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 11:56:34'),(55,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 11:56:47'),(56,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 11:57:02'),(57,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 11:57:11'),(58,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 11:57:21'),(59,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 11:57:32'),(60,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 11:57:44'),(61,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 11:57:57'),(62,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 11:58:06'),(63,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 11:58:17'),(64,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 11:58:28'),(65,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 11:58:40'),(66,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 11:58:53'),(67,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 11:59:06'),(68,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 11:59:21'),(69,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 11:59:37'),(70,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 11:59:54'),(71,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 12:00:12'),(72,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 12:00:31'),(73,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 12:00:51'),(74,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 12:01:12'),(75,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 12:01:34'),(76,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 12:01:57'),(77,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 12:02:20'),(78,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 12:02:45'),(79,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 12:03:12'),(80,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 12:03:40'),(81,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 12:04:05'),(82,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 12:04:19'),(83,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 12:04:33'),(84,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 12:04:47'),(85,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 12:05:01'),(86,'2720ecffcba4d58d','11.1438484','75.856845','abc.jpg','cracks','2022-02-01 12:05:17'),(87,'2720ecffcba4d58d','11.1438484','75.856845','abc.jpg','cracks','2022-02-01 12:05:33'),(88,'2720ecffcba4d58d','11.1448855','75.8641071','abc.jpg','cracks','2022-02-01 12:05:52'),(89,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 12:06:13'),(90,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 12:06:36'),(91,'2720ecffcba4d58d','11.1414864','75.8651963','abc.jpg','cracks','2022-02-01 12:07:10'),(92,'2720ecffcba4d58d','11.1414864','75.8651963','abc.jpg','cracks','2022-02-01 12:07:22'),(93,'2720ecffcba4d58d','11.1414864','75.8651963','abc.jpg','cracks','2022-02-01 12:07:34'),(94,'2720ecffcba4d58d','11.1414864','75.8651963','abc.jpg','cracks','2022-02-01 12:07:45'),(95,'2720ecffcba4d58d','11.1414864','75.8651963','abc.jpg','cracks','2022-02-01 12:08:00'),(96,'2720ecffcba4d58d','11.1414864','75.8651963','abc.jpg','cracks','2022-02-01 12:08:13'),(97,'2720ecffcba4d58d','11.1414864','75.8651963','abc.jpg','cracks','2022-02-01 12:08:27'),(98,'2720ecffcba4d58d','11.1438484','75.856845','abc.jpg','cracks','2022-02-01 12:08:42'),(99,'2720ecffcba4d58d','11.1438484','75.856845','abc.jpg','cracks','2022-02-01 12:08:58'),(100,'2720ecffcba4d58d','11.1438484','75.856845','abc.jpg','cracks','2022-02-01 12:09:16'),(101,'2720ecffcba4d58d','11.1438484','75.856845','abc.jpg','cracks','2022-02-01 12:09:26'),(102,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 12:09:37'),(103,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 12:09:46'),(104,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 12:09:57'),(105,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 12:10:12'),(106,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 12:10:30'),(107,'2720ecffcba4d58d','11.1448837','75.856845','abc.jpg','cracks','2022-02-01 12:10:48'),(108,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 12:11:05'),(109,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 12:11:18'),(110,'2720ecffcba4d58d','11.1409852','75.8619285','abc.jpg','cracks','2022-02-01 12:11:36'),(111,'2720ecffcba4d58d','11.1429188','75.8662856','abc.jpg','cracks','2022-02-01 12:11:49'),(112,'2720ecffcba4d58d','11.1429188','75.8662856','abc.jpg','cracks','2022-02-01 12:12:04'),(113,'2720ecffcba4d58d','11.1429188','75.8662856','abc.jpg','cracks','2022-02-01 12:12:18'),(114,'2720ecffcba4d58d','11.1429188','75.8662856','abc.jpg','cracks','2022-02-01 12:12:35'),(115,'2720ecffcba4d58d','11.1429188','75.8662856','abc.jpg','cracks','2022-02-01 12:12:52'),(116,'2720ecffcba4d58d','11.1429188','75.8662856','abc.jpg','cracks','2022-02-01 12:13:10'),(117,'2720ecffcba4d58d','11.1429188','75.8662856','abc.jpg','cracks','2022-02-01 12:13:29'),(118,'2720ecffcba4d58d','11.1429188','75.8662856','abc.jpg','cracks','2022-02-01 12:13:49'),(119,'2720ecffcba4d58d','11.1429188','75.8662856','abc.jpg','cracks','2022-02-01 12:14:02'),(120,'2720ecffcba4d58d','11.1429188','75.8662856','abc.jpg','cracks','2022-02-01 12:14:16'),(121,'2720ecffcba4d58d','11.1429188','75.8662856','abc.jpg','cracks','2022-02-01 12:14:31'),(122,'2720ecffcba4d58d','11.1429188','75.8662856','abc.jpg','cracks','2022-02-01 12:14:47'),(123,'2720ecffcba4d58d','11.1429188','75.8662856','abc.jpg','cracks','2022-02-01 12:15:04'),(124,'2720ecffcba4d58d','11.1429188','75.8662856','abc.jpg','cracks','2022-02-01 12:15:22'),(125,'2720ecffcba4d58d','11.1429188','75.8662856','abc.jpg','cracks','2022-02-01 12:15:41'),(126,'2720ecffcba4d58d','11.1429188','75.8662856','abc.jpg','cracks','2022-02-01 12:16:01'),(127,'2720ecffcba4d58d','11.1432622','75.8590236','abc.jpg','cracks','2022-02-01 12:16:22'),(128,'2720ecffcba4d58d','11.1432622','75.8590236','abc.jpg','cracks','2022-02-01 12:16:43'),(129,'2720ecffcba4d58d','11.1432622','75.8590236','abc.jpg','cracks','2022-02-01 12:16:56'),(130,'2720ecffcba4d58d','11.1409852','75.8619285','abc.jpg','cracks','2022-02-01 12:17:10'),(131,'2720ecffcba4d58d','11.1409852','75.8619285','abc.jpg','cracks','2022-02-01 12:17:25'),(132,'2720ecffcba4d58d','11.1409852','75.8619285','abc.jpg','cracks','2022-02-01 12:17:41'),(133,'2720ecffcba4d58d','11.1429188','75.8662856','abc.jpg','cracks','2022-02-01 12:17:58'),(134,'2720ecffcba4d58d','11.1429188','75.8662856','abc.jpg','cracks','2022-02-01 12:18:16'),(135,'2720ecffcba4d58d','11.1429188','75.8662856','abc.jpg','cracks','2022-02-01 12:18:34'),(136,'2720ecffcba4d58d','11.1429188','75.8662856','abc.jpg','cracks','2022-02-01 12:18:53'),(137,'2720ecffcba4d58d','11.1422789','75.860113','abc.jpg','cracks','2022-02-01 12:19:15'),(138,'2720ecffcba4d58d','11.139121','75.8590236','abc.jpg','cracks','2022-02-01 12:19:50'),(139,'2720ecffcba4d58d','11.1422789','75.860113','abc.jpg','cracks','2022-02-01 12:20:03'),(140,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 12:20:18'),(141,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 12:20:34'),(142,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 12:20:47'),(143,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 12:21:01'),(144,'2720ecffcba4d58d','11.1433143','75.860113','abc.jpg','cracks','2022-02-01 12:21:16'),(145,'2720ecffcba4d58d','11.1448855','75.8641071','abc.jpg','cracks','2022-02-01 12:21:46'),(146,'2720ecffcba4d58d','11.1448855','75.8641071','abc.jpg','cracks','2022-02-01 12:22:00'),(147,'2720ecffcba4d58d','11.1448855','75.8641071','abc.jpg','cracks','2022-02-01 12:24:08'),(148,'2720ecffcba4d58d','11.14307313','75.86298109','abc.jpg','cracks','2022-02-01 12:24:18'),(149,'2720ecffcba4d58d','11.14307313','75.86298109','abc.jpg','cracks','2022-02-01 12:24:29'),(150,'2720ecffcba4d58d','11.14307313','75.86298109','abc.jpg','cracks','2022-02-01 12:24:39'),(151,'2720ecffcba4d58d','11.14307313','75.86298109','abc.jpg','cracks','2022-02-01 12:24:49'),(152,'2720ecffcba4d58d','11.14307313','75.86298109','abc.jpg','cracks','2022-02-01 12:25:00'),(153,'69df941e80ee14b6','76.0228','10.8299','abc.jpg','cracks','2022-05-27 14:33:33'),(154,'69df941e80ee14b6','11.2576728','75.7827506','abc.jpg','cracks','2022-05-27 14:33:56'),(155,'69df941e80ee14b6','11.2576728','75.7827506','abc.jpg','cracks','2022-05-27 14:34:12'),(156,'69df941e80ee14b6','11.2576728','75.7827506','abc.jpg','cracks','2022-05-27 14:34:31'),(157,'69df941e80ee14b6','11.2576728','75.7827506','abc.jpg','cracks','2022-05-27 14:34:51'),(158,'69df941e80ee14b6','11.258762','75.7838405','abc.jpg','cracks','2022-05-27 14:35:11'),(159,'c05a6cd8e535174a','11.258762','75.7838405','abc.jpg','cracks','2022-05-27 14:40:09'),(160,'c05a6cd8e535174a','11.2541833','75.782024','abc.jpg','cracks','2022-05-27 14:40:34'),(161,'c05a6cd8e535174a','11.2541833','75.782024','abc.jpg','cracks','2022-05-27 14:41:03'),(162,'c05a6cd8e535174a','11.2541833','75.782024','abc.jpg','cracks','2022-05-27 14:42:00'),(163,'c05a6cd8e535174a','11.2541833','75.782024','abc.jpg','cracks','2022-05-27 14:42:32'),(164,'c05a6cd8e535174a','11.2540669','75.7867469','abc.jpg','cracks','2022-05-27 14:43:06'),(165,'c05a6cd8e535174a','11.2540669','75.7867469','abc.jpg','cracks','2022-05-27 14:43:35'),(166,'c05a6cd8e535174a','11.2533937','75.7871102','abc.jpg','cracks','2022-05-27 17:48:45'),(167,'1e8d244d79259142','11.2574373','75.7842571','abc.jpg','cracks','2022-06-04 12:31:44'),(168,'1e8d244d79259142','11.2574373','75.7842571','abc.jpg','cracks','2022-06-04 12:32:08'),(169,'1e8d244d79259142','11.2574373','75.7842571','abc.jpg','cracks','2022-06-04 12:32:36'),(170,'1e8d244d79259142','11.2569809','75.7840937','abc.jpg','cracks','2022-06-04 14:55:04'),(171,'1e8d244d79259142','11.2569809','75.7840937','abc.jpg','cracks','2022-06-04 16:06:43'),(172,'1e8d244d79259142','11.2569809','75.7840937','abc.jpg','cracks','2022-06-04 16:07:12'),(173,'1e8d244d79259142','11.2584342','75.7842038','abc.jpg','cracks','2022-06-04 17:16:24'),(174,'1e8d244d79259142','10.7460205','75.9536246','abc.jpg','cracks','2022-06-07 16:09:44'),(175,'1e8d244d79259142','10.7460205','75.9536246','abc.jpg','cracks','2022-06-07 16:10:05'),(176,'1e8d244d79259142','10.8301308','76.0234819','abc.jpg','cracks','2022-06-08 14:47:30'),(177,'1e8d244d79259142','10.8347942','76.0205136','abc.jpg','cracks','2022-06-08 14:47:59'),(178,'1e8d244d79259142','10.8347942','76.0205136','abc.jpg','cracks','2022-06-08 14:48:21'),(179,'1e8d244d79259142','10.8347942','76.0205136','abc.jpg','cracks','2022-06-08 14:48:52'),(180,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-14 11:08:06'),(181,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-14 11:08:31'),(182,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-14 11:08:55'),(183,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-14 11:11:51'),(184,'1e8d244d79259142','11.2594529','75.7838405','abc.jpg','cracks','2022-06-14 11:12:23'),(185,'1e8d244d79259142','11.2594529','75.7838405','abc.jpg','cracks','2022-06-14 11:12:58'),(186,'1e8d244d79259142','11.2577257','75.7838405','abc.jpg','cracks','2022-06-14 11:22:11'),(187,'1e8d244d79259142','11.2541833','75.782024','abc.jpg','cracks','2022-06-14 11:22:36'),(188,'1e8d244d79259142','11.2541833','75.782024','abc.jpg','cracks','2022-06-14 11:23:03'),(189,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-14 11:23:26'),(190,'1e8d244d79259142','11.2537215','75.7867469','abc.jpg','cracks','2022-06-14 13:32:19'),(191,'1e8d244d79259142','11.2537215','75.7867469','abc.jpg','cracks','2022-06-14 13:32:48'),(192,'1e8d244d79259142','11.2577257','75.7838405','abc.jpg','cracks','2022-06-14 13:33:18'),(193,'1e8d244d79259142','11.258762','75.7838405','abc.jpg','cracks','2022-06-14 14:06:04'),(194,'1e8d244d79259142','11.258762','75.7838405','abc.jpg','cracks','2022-06-14 14:39:00'),(195,'1e8d244d79259142','11.2603658','75.7812974','abc.jpg','cracks','2022-06-14 14:39:19'),(196,'1e8d244d79259142','11.2603658','75.7812974','abc.jpg','cracks','2022-06-14 14:39:57'),(197,'1e8d244d79259142','11.2594352','75.7834772','abc.jpg','cracks','2022-06-14 14:40:32'),(198,'1e8d244d79259142','11.2594352','75.7834772','abc.jpg','cracks','2022-06-14 14:41:06'),(199,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:11:41'),(200,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:12:19'),(201,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:12:50'),(202,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:13:21'),(203,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:13:52'),(204,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:14:36'),(205,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:15:01'),(206,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:16:15'),(207,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:16:42'),(208,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:26:58'),(209,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:27:27'),(210,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:27:59'),(211,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:32:56'),(212,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:33:50'),(213,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:36:44'),(214,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:38:18'),(215,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:39:18'),(216,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:43:50'),(217,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:44:14'),(218,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:44:48'),(219,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:45:47'),(220,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:47:01'),(221,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:54:16'),(222,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:54:46'),(223,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:55:38'),(224,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:56:05'),(225,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:56:34'),(226,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:57:03'),(227,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:57:34'),(228,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:59:16'),(229,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 13:59:59'),(230,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 16:11:21'),(231,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 16:11:48'),(232,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 16:12:16'),(233,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 16:12:49'),(234,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 16:13:18'),(235,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 16:14:03'),(236,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 16:14:45'),(237,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 16:15:31'),(238,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 16:16:19'),(239,'1e8d244d79259142','76.0228','10.8299','abc.jpg','cracks','2022-06-27 16:17:02'),(240,'1e8d244d79259142','11.2577257','75.7838405','abc.jpg','cracks','2022-06-27 16:23:54'),(241,'1e8d244d79259142','11.2577257','75.7838405','abc.jpg','cracks','2022-06-27 16:24:26'),(242,'1e8d244d79259142','11.2577257','75.7838405','abc.jpg','cracks','2022-06-27 16:24:58'),(243,'1e8d244d79259142','11.2577257','75.7838405','abc.jpg','cracks','2022-06-27 16:25:36'),(244,'1e8d244d79259142','11.2533937','75.7871102','abc.jpg','cracks','2022-06-27 16:26:31'),(245,'1e8d244d79259142','11.2533937','75.7871102','abc.jpg','cracks','2022-06-27 16:27:19'),(246,'1e8d244d79259142','11.2540669','75.7867469','abc.jpg','cracks','2022-06-27 16:28:09'),(247,'1e8d244d79259142','11.2553429','75.7845671','abc.jpg','cracks','2022-06-27 16:29:19'),(248,'1e8d244d79259142','11.2587796','75.7842038','abc.jpg','cracks','2022-06-27 16:35:57'),(249,'1e8d244d79259142','11.2587796','75.7842038','abc.jpg','cracks','2022-06-27 16:37:21'),(250,'1e8d244d79259142','11.2540669','75.7867469','abc.jpg','cracks','2022-06-27 16:50:38'),(251,'1e8d244d79259142','11.2577257','75.7838405','abc.jpg','cracks','2022-06-27 16:57:52'),(252,'1e8d244d79259142','11.2577257','75.7838405','abc.jpg','cracks','2022-06-27 16:58:23');

/*Table structure for table `complaint` */

DROP TABLE IF EXISTS `complaint`;

CREATE TABLE `complaint` (
  `sc_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) DEFAULT NULL,
  `latitude` bigint(20) DEFAULT NULL,
  `longitude` bigint(20) DEFAULT NULL,
  `complaint` varchar(60) DEFAULT NULL,
  `status` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`sc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `complaint` */

insert  into `complaint`(`sc_id`,`uid`,`latitude`,`longitude`,`complaint`,`status`) values (0,2,9,5,'amee','hghjghj'),(1,10,6,7,'uuu','pending'),(2,5,4,5,'bb','pending'),(3,6,4,5,'ggg','pending');

/*Table structure for table `emergency` */

DROP TABLE IF EXISTS `emergency`;

CREATE TABLE `emergency` (
  `ea_id` bigint(20) DEFAULT NULL,
  `uid` bigint(20) DEFAULT NULL,
  `latitude` bigint(20) DEFAULT NULL,
  `longitude` bigint(20) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `status` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `emergency` */

insert  into `emergency`(`ea_id`,`uid`,`latitude`,`longitude`,`description`,`status`) values (1,1,9,4,'bm','pending');

/*Table structure for table `feedback` */

DROP TABLE IF EXISTS `feedback`;

CREATE TABLE `feedback` (
  `fid` int(11) NOT NULL AUTO_INCREMENT,
  `user_lid` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `feedback` varchar(54) DEFAULT NULL,
  PRIMARY KEY (`fid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `feedback` */

insert  into `feedback`(`fid`,`user_lid`,`date`,`feedback`) values (1,2,'2022-01-29','feedback'),(2,3,'2022-01-29','good'),(3,3,'2022-01-29','average'),(4,4,'2022-01-30','poor');

/*Table structure for table `location` */

DROP TABLE IF EXISTS `location`;

CREATE TABLE `location` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `uid` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

/*Data for the table `location` */

insert  into `location`(`id`,`latitude`,`longitude`,`uid`) values (1,11.3432998,75.7388215,2),(2,11.3432998,75.7388215,3),(3,11.3432998,75.7445,4),(19,11.3432998,75.744,14),(20,11.34556666,75.75,18);

/*Table structure for table `login` */

DROP TABLE IF EXISTS `login`;

CREATE TABLE `login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(54) DEFAULT NULL,
  `password` varchar(54) DEFAULT NULL,
  `usertype` varchar(54) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

/*Data for the table `login` */

insert  into `login`(`id`,`username`,`password`,`usertype`) values (1,'admin','admin123','admin'),(2,'user','user','user'),(3,'zuu','huu','user'),(4,'qwerty','qwerty','user'),(5,'varsha','varsha','police'),(8,'amrutha','amrutha','police'),(12,'amrutha121','123456','police'),(13,'anjana','anju123','police'),(14,'anjali','anju@123','user'),(16,'ammu','ammu@123','user'),(18,'shilpa','shil@123','user');

/*Table structure for table `notification` */

DROP TABLE IF EXISTS `notification`;

CREATE TABLE `notification` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `date` varchar(90) DEFAULT NULL,
  `notification` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `notification` */

insert  into `notification`(`nid`,`date`,`notification`) values (3,'2022-01-05','meeting\r\n'),(4,'2022-06-02','hi'),(5,'2022-06-27','damaged');

/*Table structure for table `place` */

DROP TABLE IF EXISTS `place`;

CREATE TABLE `place` (
  `ip_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `description` varchar(40) DEFAULT NULL,
  `latitude` bigint(20) DEFAULT NULL,
  `longitude` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ip_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `place` */

insert  into `place`(`ip_id`,`name`,`description`,`latitude`,`longitude`) values (1,'cb ','cbgcv',5,7),(2,'njjj','fs',7,3),(3,'2','om kree mahakalikayenamah',0,7),(4,'ujhkj','jkhk',66,77);

/*Table structure for table `police` */

DROP TABLE IF EXISTS `police`;

CREATE TABLE `police` (
  `tp_id` bigint(60) NOT NULL AUTO_INCREMENT,
  `lid` bigint(20) DEFAULT NULL,
  `fname` varchar(60) DEFAULT NULL,
  `mname` varchar(60) DEFAULT NULL,
  `lname` varchar(60) DEFAULT NULL,
  `phone` bigint(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`tp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `police` */

insert  into `police`(`tp_id`,`lid`,`fname`,`mname`,`lname`,`phone`,`email`) values (2,12,'varsha','c','priyesh',7034710195,'varsha@gmail.com'),(3,13,'anjana','m','s',9087654321,'anju@gmail.com');

/*Table structure for table `route` */

DROP TABLE IF EXISTS `route`;

CREATE TABLE `route` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from` varchar(55) DEFAULT NULL,
  `to` varchar(45) DEFAULT NULL,
  `route` varchar(44) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `route` */

insert  into `route`(`id`,`from`,`to`,`route`) values (2,'kozhikode','Thrissur','89');

/*Table structure for table `signals` */

DROP TABLE IF EXISTS `signals`;

CREATE TABLE `signals` (
  `ts_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `latitude` bigint(20) DEFAULT NULL,
  `longitude` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ts_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `signals` */

insert  into `signals`(`ts_id`,`name`,`latitude`,`longitude`) values (1,'parvati',23,33),(3,'mahadeva',111,333),(4,'hghj',66,77);

/*Table structure for table `track` */

DROP TABLE IF EXISTS `track`;

CREATE TABLE `track` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_lid` int(11) DEFAULT NULL,
  `lattitude` varchar(54) DEFAULT NULL,
  `longitude` varchar(54) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `track` */

insert  into `track`(`id`,`user_lid`,`lattitude`,`longitude`) values (1,2,'11.32','75.33');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `user_lid` int(11) DEFAULT NULL,
  `fname` varchar(55) DEFAULT NULL,
  `lname` varchar(33) DEFAULT NULL,
  `place` varchar(44) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `phone` (`phone`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `user` */

insert  into `user`(`uid`,`user_lid`,`fname`,`lname`,`place`,`phone`,`email`) values (1,2,'anu','p','calicut','9922113300','anu@gmail.com'),(2,3,'hhhhhhhz','zzz','gzz','6958253669','fhh@gmail.com'),(3,4,'uuu','p','calicut','9625146958','asdkkk@gmail.com'),(4,14,'Anjali','m','kuttippala','9806532147','anj@gmail.com'),(6,18,'Shilpa','s','edappal','9806532085','shil@gmail.com');

/*Table structure for table `userregistration` */

DROP TABLE IF EXISTS `userregistration`;

CREATE TABLE `userregistration` (
  `uid` bigint(20) NOT NULL AUTO_INCREMENT,
  `lid` bigint(20) DEFAULT NULL,
  `fname` varchar(40) DEFAULT NULL,
  `mname` varchar(60) DEFAULT NULL,
  `lname` varchar(60) DEFAULT NULL,
  `phone` bigint(20) DEFAULT NULL,
  `email_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `userregistration` */

insert  into `userregistration`(`uid`,`lid`,`fname`,`mname`,`lname`,`phone`,`email_id`) values (1,2,'m ','hjkj','gjg',5678787,'ffghgjhg@gmail.com'),(4,5,'hgfh','ghfh','ghhg',87989,'hjgjh'),(5,6,'hjgjh','hjghj','jkhkj',78687,'gvgn'),(6,10,'ljlkj','hjgjh','gdgf',76767576,'vnb');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
