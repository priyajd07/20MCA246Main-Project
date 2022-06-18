/*
SQLyog Community v13.0.1 (64 bit)
MySQL - 5.1.32-community : Database - project
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`project` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `project`;

/*Table structure for table `allocation` */

DROP TABLE IF EXISTS `allocation`;

CREATE TABLE `allocation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subid` int(11) DEFAULT NULL,
  `staffid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `allocation` */

insert  into `allocation`(`id`,`subid`,`staffid`) values 
(2,0,30),
(4,1,30),
(5,11,32),
(6,2,30);

/*Table structure for table `answer` */

DROP TABLE IF EXISTS `answer`;

CREATE TABLE `answer` (
  `ans_id` int(10) NOT NULL AUTO_INCREMENT,
  `student_id` int(10) DEFAULT NULL,
  `exam_id` int(10) DEFAULT NULL,
  `ans_paper` text,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  PRIMARY KEY (`ans_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `answer` */

insert  into `answer`(`ans_id`,`student_id`,`exam_id`,`ans_paper`,`date`,`time`) values 
(1,6,3,'storage_6666-3331_DCIM_Camera_20170423_172907.jpg','2022-02-08','21:57:42'),
(2,6,2,'storage_emulated_0_Download_teacher-education-school-classroom-computer-icons-teacher.jpg','2022-02-09','02:33:24'),
(3,9,3,'storage_emulated_0_Pictures_1645185440672.jpg','2022-02-18','17:31:07'),
(4,9,3,'storage_emulated_0_Pictures_1645185440672.jpg','2022-02-18','17:31:11'),
(5,9,3,'storage_emulated_0_Pictures_1645185440672.jpg','2022-02-18','17:34:48'),
(6,9,3,'storage_emulated_0_Pictures_1645185440672.jpg','2022-02-18','17:34:52'),
(7,9,3,'storage_emulated_0_Pictures_1645185440672.jpg','2022-02-18','17:34:54'),
(8,9,3,'storage_emulated_0_Pictures_1645185440672.jpg','2022-02-18','17:34:59'),
(9,9,2,'storage_emulated_0_DCIM_Screenshots_Screenshot_20220219-062833_Where_is_my_Train.jpg','2022-02-19','09:48:28'),
(10,9,2,'storage_emulated_0_DCIM_Screenshots_Screenshot_20220219-062833_Where_is_my_Train.jpg','2022-02-19','09:48:30'),
(11,9,2,'storage_emulated_0_WhatsApp_Media_WhatsApp_Documents_New_Doc_2021-08-18_14.17.27.pdf','2022-02-19','14:22:44'),
(12,9,2,'storage_emulated_0_WhatsApp_Media_WhatsApp_Documents_New_Doc_2021-08-18_14.17.27.pdf','2022-02-19','14:22:46'),
(13,9,30,'storage_emulated_0_WhatsApp_Media_WhatsApp_Images_IMG-20220223-WA0004.jpeg','2022-02-23','11:40:39'),
(14,9,30,'storage_emulated_0_WhatsApp_Media_WhatsApp_Images_IMG-20220223-WA0004.jpeg','2022-02-23','11:40:42');

/*Table structure for table `attendance` */

DROP TABLE IF EXISTS `attendance`;

CREATE TABLE `attendance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) DEFAULT NULL,
  `attendance` varchar(30) DEFAULT NULL,
  `date` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `attendance` */

insert  into `attendance`(`id`,`sid`,`attendance`,`date`) values 
(1,4,'1','987654e'),
(2,4,'16431_sign.jpg','2022-06-04');

/*Table structure for table `chat` */

DROP TABLE IF EXISTS `chat`;

CREATE TABLE `chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fromid` int(11) DEFAULT NULL,
  `toid` int(11) DEFAULT NULL,
  `msg` varchar(40) DEFAULT NULL,
  `date` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `chat` */

insert  into `chat`(`id`,`fromid`,`toid`,`msg`,`date`) values 
(1,30,23,'submit assignment ','2022-05-27'),
(2,30,9,'anjana','2022-05-27'),
(3,30,9,'anjana','2022-05-27'),
(4,30,9,'submit it','2022-05-27'),
(5,30,9,'hai','2022-05-27');

/*Table structure for table `course_table` */

DROP TABLE IF EXISTS `course_table`;

CREATE TABLE `course_table` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `course` varchar(20) DEFAULT NULL,
  `description` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `course_table` */

insert  into `course_table`(`id`,`course`,`description`) values 
(1,'BCA','Bachelor of Computer Application'),
(5,'MCA','Master of Computer Application');

/*Table structure for table `exam` */

DROP TABLE IF EXISTS `exam`;

CREATE TABLE `exam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) DEFAULT NULL,
  `date` varchar(20) DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL,
  `exam_name` varchar(100) DEFAULT NULL,
  `duration` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `exam` */

insert  into `exam`(`id`,`sid`,`date`,`time`,`exam_name`,`duration`) values 
(1,1,'2022-06-07','14:55','second series','1 hr');

/*Table structure for table `examnotification` */

DROP TABLE IF EXISTS `examnotification`;

CREATE TABLE `examnotification` (
  `id` int(11) NOT NULL,
  `staffid` int(11) DEFAULT NULL,
  `examid` int(11) DEFAULT NULL,
  `notification` varchar(20) DEFAULT NULL,
  `date` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `examnotification` */

/*Table structure for table `login` */

DROP TABLE IF EXISTS `login`;

CREATE TABLE `login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

/*Data for the table `login` */

insert  into `login`(`id`,`username`,`password`,`type`) values 
(1,'admin','admin','admin'),
(5,'sachin123','123sachin','staff'),
(9,'anjana','anjana','student'),
(22,'Manimangarath','Manimangarath','student'),
(23,'amirtha','amirtha','student'),
(30,'vasudevan','vasu','staff'),
(31,'aswathy','aswathy','student'),
(32,'jalaja','jalaja','staff');

/*Table structure for table `marks` */

DROP TABLE IF EXISTS `marks`;

CREATE TABLE `marks` (
  `Markid` int(11) NOT NULL AUTO_INCREMENT,
  `lid` int(11) DEFAULT NULL,
  `eid` int(11) DEFAULT NULL,
  `marks` int(11) DEFAULT NULL,
  PRIMARY KEY (`Markid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `marks` */

/*Table structure for table `pics` */

DROP TABLE IF EXISTS `pics`;

CREATE TABLE `pics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stud_id` int(11) DEFAULT NULL,
  `pic` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Data for the table `pics` */

insert  into `pics`(`id`,`stud_id`,`pic`) values 
(1,6,'aa.jpg'),
(2,7,'user.jpg'),
(4,9,'2022-01-25-16-52-08-700.jpg'),
(8,22,'MAnikandan.jpg'),
(9,23,'2022-01-25-16-52-08-700.jpg'),
(10,31,'2022-01-25-16-52-08-700.jpg');

/*Table structure for table `questions` */

DROP TABLE IF EXISTS `questions`;

CREATE TABLE `questions` (
  `Qid` int(11) NOT NULL AUTO_INCREMENT,
  `exam_id` int(11) DEFAULT NULL,
  `question` text,
  `option1` text,
  `option2` text,
  `option3` text,
  `option4` text,
  `answer` text,
  PRIMARY KEY (`Qid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `questions` */

insert  into `questions`(`Qid`,`exam_id`,`question`,`option1`,`option2`,`option3`,`option4`,`answer`) values 
(1,1,'Which of the following is generally used for performing tasks like creating the structure of the relations, deleting relation?','DML(Data Manipulation Language)','Query','Relational Schema','DDL(Data Definition Language)','DDL(Data Definition Language)'),
(3,1,'A Database Management System is a type of _________software?','It is a type of system software','It is a kind of application software','It is a kind of general software','Both A and C','It is a type of system software'),
(4,1,'What do you mean by one to many relationships?','One class may have many teachers','One teacher can have many classes','Many classes may have many teachers','Many teachers may have many classes','One teacher can have many classes');

/*Table structure for table `staff` */

DROP TABLE IF EXISTS `staff`;

CREATE TABLE `staff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loginid` int(11) DEFAULT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `dob` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `place` varchar(50) DEFAULT NULL,
  `post` varchar(50) DEFAULT NULL,
  `pin` bigint(20) DEFAULT NULL,
  `qualification` varchar(50) DEFAULT NULL,
  `phone` bigint(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `staff` */

insert  into `staff`(`id`,`loginid`,`fname`,`lname`,`dob`,`gender`,`place`,`post`,`pin`,`qualification`,`phone`,`email`) values 
(2,30,'vasudevan','nair','1990-01-01','male','vattamkulam','vattamkulam',678654,'Mphil',8976543456,'vasudevan@gmail.com'),
(3,32,'jalaja','K','1988-02-02','female','ponnani','ponnani',679567,'PG,Mphil',7845673267,'jalaja@gmail.com');

/*Table structure for table `student_table` */

DROP TABLE IF EXISTS `student_table`;

CREATE TABLE `student_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login_id` int(11) DEFAULT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `middle_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `dob` varchar(20) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `course` int(11) DEFAULT NULL,
  `place` varchar(20) DEFAULT NULL,
  `post` varchar(20) DEFAULT NULL,
  `pin` bigint(20) DEFAULT NULL,
  `phone` bigint(20) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `date_of_admision` varchar(30) DEFAULT NULL,
  `semester` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`,`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

/*Data for the table `student_table` */

insert  into `student_table`(`id`,`login_id`,`first_name`,`middle_name`,`last_name`,`dob`,`gender`,`course`,`place`,`post`,`pin`,`phone`,`email`,`date_of_admision`,`semester`) values 
(4,9,'anjana','m','s','2019-12-10','female',5,'vattamkulam','vattamkulam',679578,7902613267,'anjanamsmangarath@gmail.com','2022-03-02','3'),
(11,22,'Manikandan','M','S','2000-01-01','male',6,'ponnani','ponnani',679578,9856762310,'manikandanman@gmail.com','2022-02-19','1'),
(12,23,'amirtha','m','c','2019-12-03','female',2,'kozhikod','kozhikod',678745,9567048450,'amirtha@gmail.com','2022-05-09','1'),
(13,31,'aswathy','m','d','2019-12-03','female',2,'velliyancode','velliyancode',675432,9656784519,'aswathy@gmail.com','2022-05-25','6');

/*Table structure for table `study_material` */

DROP TABLE IF EXISTS `study_material`;

CREATE TABLE `study_material` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sub_id` int(11) DEFAULT NULL,
  `material` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

/*Data for the table `study_material` */

insert  into `study_material`(`id`,`sub_id`,`material`) values 
(1,1,'Blackboard_Teachers_Day_Poster'),
(2,2,'CF_M4_S3_MASC.pdf'),
(3,3,'16431_sign.jpg'),
(4,4,'Anjanams_21091999.pdf'),
(5,10,'Anjanams_21091999.pdf'),
(6,11,'ID_card_03-Dec-2021.pdf'),
(7,8,'answers.pdf'),
(8,9,'09AnjanaMS_Assignment.pdf'),
(9,10,'MINIProject_Presentationupdated.pdf'),
(10,3,'OBC_SCHOLARSHIP.pdf'),
(11,1,'Mini_Project_Proposal.pdf'),
(12,1,'20191026_195054.jpg'),
(13,3,'20191026_195054.jpg'),
(14,4,'1520659482854.jpg'),
(15,1,'09-AnjanaTutorial3.pdf'),
(16,1,'09-ANJANA_MS.pdf');

/*Table structure for table `subject_table` */

DROP TABLE IF EXISTS `subject_table`;

CREATE TABLE `subject_table` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `course_id` int(5) NOT NULL,
  `semester` varchar(15) NOT NULL,
  `subject` varchar(20) NOT NULL,
  `description` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `subject_table` */

insert  into `subject_table`(`id`,`course_id`,`semester`,`subject`,`description`) values 
(1,1,'1','Descrete Maths','1st Semester BCA subject'),
(2,1,'1','HTML','first sem subject'),
(7,3,'5','Statistics','bcom'),
(8,6,'1','finance','Mcom'),
(9,4,'2','zeitgiest','english'),
(11,5,'1','Data Structure','First sem subject'),
(12,5,'1','software engineering','First sem subject');

/*Table structure for table `timetable` */

DROP TABLE IF EXISTS `timetable`;

CREATE TABLE `timetable` (
  `timetable` varchar(30) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `courseid` int(11) DEFAULT NULL,
  `sem` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `timetable` */

insert  into `timetable`(`timetable`,`id`,`courseid`,`sem`) values 
('09-ANJANA_MS.pdf',1,1,'2'),
('20191026_195054.jpg',2,5,'2');

/*Table structure for table `video` */

DROP TABLE IF EXISTS `video`;

CREATE TABLE `video` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staffid` int(11) DEFAULT NULL,
  `subid` int(11) DEFAULT NULL,
  `Topic` varchar(30) DEFAULT NULL,
  `video` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `video` */

insert  into `video`(`id`,`staffid`,`subid`,`Topic`,`video`) values 
(1,30,4,'scalarmatrix','video_1548940386000.mp4'),
(2,30,4,'scalarmatrix','video_1548940386000.mp4');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
