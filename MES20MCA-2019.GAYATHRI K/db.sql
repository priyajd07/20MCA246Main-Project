/*
SQLyog Community v13.0.1 (64 bit)
MySQL - 5.5.20-log : Database - intelligent chatbot
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`intelligent chatbot` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `intelligent chatbot`;

/*Table structure for table `chat` */

DROP TABLE IF EXISTS `chat`;

CREATE TABLE `chat` (
  `Chatid` int(11) NOT NULL AUTO_INCREMENT,
  `Fromid` int(11) DEFAULT NULL,
  `Toid` int(11) DEFAULT NULL,
  `Message` varchar(100) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  PRIMARY KEY (`Chatid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `chat` */

/*Table structure for table `chatbot_chat` */

DROP TABLE IF EXISTS `chatbot_chat`;

CREATE TABLE `chatbot_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `questions` varchar(500) DEFAULT NULL,
  `answers` varchar(1000) DEFAULT NULL,
  `date` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;

/*Data for the table `chatbot_chat` */

insert  into `chatbot_chat`(`id`,`user_id`,`questions`,`answers`,`date`) values 
(1,18,'hai','helloo','2022-02-18'),
(2,18,'hhh','I can not understand the question','2022-02-18'),
(3,NULL,'Are you not feeling well?','No',NULL),
(4,NULL,NULL,NULL,NULL),
(5,18,'Are you not feeling well','I can not understand the question','2022-02-18'),
(6,18,'what can i do? Can you help me','I can not understand the question','2022-02-18'),
(7,18,'iam not feeling well','I can not understand the question','2022-02-18'),
(8,18,'iam not feeling well','I can not understand the question','2022-02-18'),
(9,18,'iam not feeling well','I can not understand the question','2022-02-18'),
(10,18,'iam not feeling well','ok,what happen to you','2022-02-18'),
(11,18,'what can i do? Can you help me\n','Yes,Ofcourse','2022-02-18'),
(12,2,'hai','helloo','2022-02-18'),
(13,2,'please help me','yes.','2022-02-18'),
(14,2,'Iam not well','ok,what happen to you','2022-02-18'),
(15,2,'I always have tensions.','Be positive','2022-02-18'),
(16,2,'please help me\n','yes.','2022-02-18'),
(17,2,'i am sad please help me','dont worry i am there','2022-02-18'),
(18,5,'hai','helloo','2022-02-22'),
(19,5,'iam so sad','I can not understand the question','2022-02-22'),
(20,5,'how can i reduce my stress','Confidence is the key to unlocking your stress.','2022-02-22'),
(21,5,'i always have tensions','Be positive','2022-02-22'),
(22,5,'please help me','yes.','2022-02-22'),
(23,5,'my mind is disturbed','Always think positively.Do things that make the mind happy.','2022-02-22'),
(24,5,'??\n\nmy friend passed away ','I can not understand the question','2022-02-22'),
(25,5,'I am going for a movie\n','I can not understand the question','2022-02-22'),
(26,5,'I am going for a movie\n','I can not understand the question','2022-02-22'),
(27,5,'I am going for a movie ','I can not understand the question','2022-02-22'),
(28,5,'I am going  for a movies ','I can not understand the question','2022-02-22'),
(29,5,'Iam going for a movie.','Ok ','2022-02-22'),
(30,16,'hai','helloo','2022-02-22'),
(31,16,'I am going for a movie','Ok ,You go and free your mind.','2022-02-22'),
(32,16,'she is passed','I can not understand the question','2022-02-22'),
(33,16,'I do not remember what I learned','Meditate before you sit downn to study','2022-02-22'),
(34,16,'what I do to fall asleep','blink your eyes for two minutes','2022-02-22'),
(35,16,'what is the weather right now\n','sorry,My area is stress','2022-02-22'),
(36,16,'I am going for a movie ','Ok ,You go and free your mind.','2022-02-22'),
(37,19,'hai','helloo','2022-02-26'),
(38,19,'how are you','I can not understand the question','2022-02-26'),
(39,19,'iam not well','ok,what happen to you','2022-02-26'),
(40,19,'iam going for a movie','Ok ,You go and free your mind.','2022-02-26'),
(41,19,'ok','I can not understand the question','2022-02-26'),
(42,19,'I have always tensions','Be positive','2022-02-26'),
(43,19,'ok, bye','I can not understand the question','2022-02-26'),
(44,19,'bye','I can not understand the question','2022-02-26'),
(45,19,'good morning','I can not understand the question','2022-02-26');

/*Table structure for table `chatbot_ds` */

DROP TABLE IF EXISTS `chatbot_ds`;

CREATE TABLE `chatbot_ds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `questions` varchar(500) DEFAULT NULL,
  `answers` varchar(1000) DEFAULT NULL,
  `negative_answer` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

/*Data for the table `chatbot_ds` */

insert  into `chatbot_ds`(`id`,`questions`,`answers`,`negative_answer`) values 
(1,'Hai,Goodafternoon','hai','Goodafternoon'),
(2,'Hai,Goodmorning','yes','Goodmorning'),
(3,'Goodnight','ok,bye','Take care'),
(4,'hai','helloo','hello good morng,What is your name?'),
(5,'what can i do?Can you help me','Yes,Ofcourse','Sure,I will help you.'),
(6,'iam not feeling well','what happen','ok,what happen to you'),
(7,'please help me','yes.','dont worry i am there'),
(8,'Iam not well.','what happen.','Don\'t worry be confident'),
(9,'I always have tensions.','Be positive','Be positive'),
(10,'my mind is disturbed.','Always think positively.Do things that make the mind happy.','Always think positively.Do things that make the mind happy.'),
(11,'Thankyou','Welcome','you can chat with me for any doubts.'),
(12,'I\'m so stressed,I can\'t think straight','Don\'t worry','Keep calm and meditate on.'),
(13,'How can I reduce my stress?','Listening to your favourite tracks expecially mellow music.','Confidence is the key to unlocking your stress.'),
(14,'My friend passed away','Don\'t worry,this time will also pass','Don\'t worry,this time will also pass'),
(15,'I\'m going for a movie.','Ok ,You go and free your mind.','Ok,you can go.'),
(16,'I do not remember what i learned','Meditate before you sit downn to study','Meditate and deep breath'),
(17,'what to do to fall asleep faster','blink your eyes for two minutes','blink your eyes for two minutes'),
(18,'can i play game for releasing stress','No,you can play game.','It will reduce your stress.'),
(19,'can i contact any of my friends for releasing stress','ofcourse,you can contact your friends','ofcourse'),
(20,'what is the weather right now','sorry,My area is stress','Stress release');

/*Table structure for table `comment` */

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `Commentid` int(11) NOT NULL AUTO_INCREMENT,
  `Pid` int(11) DEFAULT NULL,
  `Userid` int(11) DEFAULT NULL,
  `Comment` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`Commentid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `comment` */

/*Table structure for table `complaint` */

DROP TABLE IF EXISTS `complaint`;

CREATE TABLE `complaint` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `user_lid` int(11) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `complaint` varchar(44) DEFAULT NULL,
  `reply` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `complaint` */

insert  into `complaint`(`cid`,`user_lid`,`date`,`complaint`,`reply`) values 
(1,2,'2022-01-31','dhcbehdg','kkk'),
(2,3,'2022-02-05','nm bd','oK'),
(3,2,'2022-02-18','better improvement','ok.We will '),
(4,2,'2022-02-22','better improvement','oK,WE WILL CONSIDER IT.'),
(5,NULL,NULL,NULL,NULL),
(6,5,'2022-02-22','There is nothing more to be right','pending');

/*Table structure for table `counsellor` */

DROP TABLE IF EXISTS `counsellor`;

CREATE TABLE `counsellor` (
  `counsellor_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_id` int(11) DEFAULT NULL,
  `fname` varchar(40) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` varchar(40) DEFAULT NULL,
  `place` varchar(30) DEFAULT NULL,
  `post` varchar(60) DEFAULT NULL,
  `pincode` int(11) DEFAULT NULL,
  `qualification` varchar(80) DEFAULT NULL,
  `phone_no` bigint(20) DEFAULT NULL,
  `email_id` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`counsellor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `counsellor` */

insert  into `counsellor`(`counsellor_id`,`login_id`,`fname`,`lname`,`dob`,`gender`,`place`,`post`,`pincode`,`qualification`,`phone_no`,`email_id`) values 
(2,26,'Devika','S','1999-07-01','Female','ponnani','ponnani',679577,'MSW',9539670328,'devika@gmail.com');

/*Table structure for table `feedback` */

DROP TABLE IF EXISTS `feedback`;

CREATE TABLE `feedback` (
  `fid` int(11) NOT NULL AUTO_INCREMENT,
  `user_lid` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `feedback` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`fid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Data for the table `feedback` */

insert  into `feedback`(`fid`,`user_lid`,`date`,`feedback`) values 
(1,2,'2022-01-05','good'),
(2,3,'2022-02-05','nice one'),
(3,2,'2022-02-18','very good'),
(4,18,'2022-02-18','good'),
(5,2,'2022-02-22','it is a good one'),
(6,2,'2022-02-22','it is very helpful to me'),
(7,2,'2022-02-22','Thankyou'),
(8,2,'2022-02-22','I got a relief when chat with this app'),
(9,NULL,NULL,NULL),
(10,5,'2022-02-22','it is very helpful to me');

/*Table structure for table `friendrequest` */

DROP TABLE IF EXISTS `friendrequest`;

CREATE TABLE `friendrequest` (
  `Fid` int(11) NOT NULL AUTO_INCREMENT,
  `Fromid` int(11) DEFAULT NULL,
  `Toid` int(11) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Status` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`Fid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `friendrequest` */

/*Table structure for table `login` */

DROP TABLE IF EXISTS `login`;

CREATE TABLE `login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(54) DEFAULT NULL,
  `usertype` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;

/*Data for the table `login` */

insert  into `login`(`id`,`username`,`password`,`usertype`) values 
(1,'admin','123','admin'),
(2,'user','user','user'),
(3,'QWE','54321','user'),
(5,'anu','123456','user'),
(16,'anupama','qwerty','user'),
(18,'anupama123','qwerty','user'),
(19,'gayathri','gayathri','user'),
(26,'devu','devu@123','counsellor');

/*Table structure for table `post` */

DROP TABLE IF EXISTS `post`;

CREATE TABLE `post` (
  `Pid` int(11) NOT NULL AUTO_INCREMENT,
  `Userid` int(11) DEFAULT NULL,
  `Post` varchar(60) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Pid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `post` */

/*Table structure for table `tips` */

DROP TABLE IF EXISTS `tips`;

CREATE TABLE `tips` (
  `t_id` int(11) NOT NULL AUTO_INCREMENT,
  `counsellor_id` int(11) DEFAULT NULL,
  `tips` text,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`t_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `tips` */

insert  into `tips`(`t_id`,`counsellor_id`,`tips`,`date`) values 
(2,26,'ghfhf','2022-06-01'),
(3,26,'very good','2022-06-01');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `lid` int(11) NOT NULL,
  `fname` varchar(44) DEFAULT NULL,
  `lname` varchar(45) DEFAULT NULL,
  `place` varchar(45) DEFAULT NULL,
  `phone` bigint(20) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `image` varchar(90) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`uid`,`lid`,`fname`,`lname`,`place`,`phone`,`email`,`image`) values 
(1,2,'anu','p','calicut',9922334455,'anu@gmail.com',NULL),
(2,3,'jjn','kkk','clt',8925658908,'bbb@gm.com',NULL),
(5,18,'anu','k','ponnani',9842153698,'anupama@gmail.com',NULL),
(6,19,'Gayathri','k','ponnani',6532854725,'gayathri@gmail.com',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
