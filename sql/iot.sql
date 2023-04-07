/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 8.0.29 : Database - www_mybt_com
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`www_mybt_com` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `www_mybt_com`;

/*Table structure for table `fa_device` */

DROP TABLE IF EXISTS `fa_device`;

CREATE TABLE `fa_device` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(101) DEFAULT NULL,
  `product_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `version` float DEFAULT NULL,
  `image` varchar(101) DEFAULT NULL,
  `deviceswitch` tinyint(1) DEFAULT '0' COMMENT '禁用设备',
  `shadowswitch` tinyint(1) DEFAULT '0' COMMENT '设备影子',
  `content` text,
  `createtime` bigint DEFAULT NULL COMMENT '激活时间',
  `longitude` varchar(255) DEFAULT NULL COMMENT '经度',
  `latitude` varchar(255) DEFAULT NULL COMMENT '纬度',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `fa_device` */

insert  into `fa_device`(`id`,`name`,`product_id`,`version`,`image`,`deviceswitch`,`shadowswitch`,`content`,`createtime`,`longitude`,`latitude`) values (2,'油烟机1','油烟机',1,'/assets/img/qrcode.png',0,0,'<p>清爽控油</p>',1680091343,'1111','1111'),(3,'门锁1','智能门锁',1,'/assets/img/qrcode.png',0,0,'<p>防盗</p>',1680092126,'1111','1111'),(4,'电灯1','电灯',1,'/assets/img/qrcode.png',0,0,'<p>照亮你的美</p>',1680092257,'1111','1111'),(5,'电灯2','电灯',1,'/assets/img/qrcode.png',0,0,'<p>照亮你的美</p>',1680092402,'2222','2222'),(6,'门锁2','智能门锁',1,'/assets/img/qrcode.png',0,0,'<p>防盗</p>',1680092442,'3333','3333'),(7,'窗帘1','智能窗帘',1,'/assets/img/qrcode.png',0,0,'<p>防偷窥</p>',1680092601,'4444','4444'),(12,'油烟机2','油烟机',1,'/assets/img/qrcode.png',0,0,'<p>清爽控油</p>',1680102621,'3333','3333'),(13,'电饭煲1','电饭煲',1,'/uploads/20230329/c698026090893b6abc25a0d7eb48c7ca.jpeg',0,0,'<p>做出你的米</p>',1680102939,'3333','4444'),(14,'微波炉1','微波炉',1,'/uploads/20230331/d2ae6bb4803f4333b1a33867d084ea2e.jpg',0,0,'<p>加热饭菜</p>',1680264608,'1111','1111');

/*Table structure for table `fa_devicelog` */

DROP TABLE IF EXISTS `fa_devicelog`;

CREATE TABLE `fa_devicelog` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tag` varchar(101) DEFAULT NULL,
  `pattern` varchar(101) DEFAULT NULL,
  `createtime` bigint DEFAULT NULL,
  `identifier` varchar(101) DEFAULT NULL,
  `action` longtext,
  `content` text,
  `deviceid` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `fa_devicelog` */

/*Table structure for table `fa_monitor` */

DROP TABLE IF EXISTS `fa_monitor`;

CREATE TABLE `fa_monitor` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tag` varchar(101) DEFAULT NULL,
  `pattern` varchar(101) DEFAULT NULL,
  `createtime` bigint DEFAULT NULL,
  `identifier` varchar(101) DEFAULT NULL,
  `action` longtext,
  `content` text,
  `deviceid` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `fa_monitor` */

/*Table structure for table `fa_objectmodel` */

DROP TABLE IF EXISTS `fa_objectmodel`;

CREATE TABLE `fa_objectmodel` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(101) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `identifier` varchar(101) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `weigh` int DEFAULT NULL,
  `tag` varchar(101) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `readswitch` tinyint(1) DEFAULT '0' COMMENT '只读',
  `chartswitch` tinyint(1) DEFAULT '0' COMMENT '图表显示',
  `datatype` varchar(101) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `definition` longtext COLLATE utf8mb4_general_ci,
  `createtime` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `fa_objectmodel` */

insert  into `fa_objectmodel`(`id`,`name`,`identifier`,`weigh`,`tag`,`readswitch`,`chartswitch`,`datatype`,`definition`,`createtime`) values (4,'室内亮度','brightness',4,'properties',0,0,'integer','{\"min\":\"0\",\"max\":\"100\",\"unit\":\"1\",\"step\":\"cd\\/m2\",\"type\":\"integer\"}',1680243100),(5,'设备开关','switch',5,'functions',0,0,'bool','{\"trueText\":\"\\u6253\\u5f00\",\"falseText\":\"\\u5173\\u95ed\",\"type\":\"bool\"}',1680243678),(6,'空气湿度','humidity',6,'properties',0,0,'decimal','{\"min\":\"0\",\"max\":\"100\",\"unit\":\"%\",\"step\":\"0.1\",\"type\":\"decimal\"}',1680243796),(7,'设备发生异常','exception',7,'events',0,0,'string','{\"maxLength\":\"1024\",\"type\":\"string\"}',1680244178),(8,'灯光色值','light_color',8,'functions',0,0,'array','{\"arrayCount\":\"3\",\"arrayType\":\"integer\",\"type\":\"array\"}',1680244689),(12,'运行挡位','gear',12,'functions',0,0,'enum','{\"type\":\"enum\",\"enumList\":[{\"text\":\"\\u4f4e\\u901f\\u6321\\u4f4d\",\"value\":\"0\"},{\"text\":\"\\u4e2d\\u901f\\u6321\\u4f4d\",\"value\":\"1\"},{\"text\":\"\\u4e2d\\u9ad8\\u901f\\u6321\\u4f4d\",\"value\":\"2\"},{\"text\":\"\\u9ad8\\u901f\\u6863\\u4f4d\",\"value\":\"3\"}]}',1680251868),(14,'状态灯色','color',14,'functions',0,0,'enum','{\"type\":\"enum\",\"enumList\":[{\"text\":\"\\u7ea2\\u8272\",\"value\":\"0\"},{\"text\":\"\\u7eff\\u8272\",\"value\":\"1\"},{\"text\":\"\\u84dd\\u8272\",\"value\":\"2\"},{\"text\":\"\\u9ec4\\u8272\",\"value\":\"3\"}]}',1680340601),(18,'屏显消息','message',18,'functions',0,0,'string','{\"maxLength\":\"1024\",\"type\":\"string\"}',1680354189),(22,'上报数据','report_monitor',22,'functions',0,0,'integer','{\"min\":\"1\",\"max\":\"10\",\"unit\":\"\\u6b21\",\"step\":\"1\",\"type\":\"integer\"}',1680419123),(23,'光照强度','light_level',23,'properties',0,0,'decimal','{\"min\":\"2.5\",\"max\":\"89.9\",\"unit\":\"L\\/g\",\"step\":\"0.1\",\"type\":\"decimal\"}',1680492625),(24,'上报数据','report_monitor',24,'functions',0,0,'integer','{\"min\":\"1\",\"max\":\"10\",\"unit\":\"\\u6b21\",\"step\":\"2\",\"type\":\"integer\"}',1680531024),(28,'单位','unit',28,'events',0,0,'array','{\"arrayCount\":\"5\",\"arrayType\":\"decimal\",\"type\":\"array\"}',1680848224),(30,'功能分组','category',30,'functions',0,0,'object','{\"type\":\"object\",\"objecttype\":[{\"objectid\":\"7\",\"objectname\":\"\\u8bbe\\u5907\\u53d1\\u751f\\u5f02\\u5e38\",\"datatype\":\"{\\\"maxLength\\\":\\\"1024\\\",\\\"type\\\":\\\"string\\\"}\"},{\"objectid\":\"6\",\"objectname\":\"\\u7a7a\\u6c14\\u6e7f\\u5ea6\",\"datatype\":\"{\\\"min\\\":\\\"0\\\",\\\"max\\\":\\\"100\\\",\\\"unit\\\":\\\"%\\\",\\\"step\\\":\\\"0.1\\\",\\\"type\\\":\\\"decimal\\\"}\"}]}',1680853664),(31,'测试功能','test',31,'functions',0,0,'object','{\"type\":\"object\",\"objecttype\":[{\"objectid\":\"18\",\"objectname\":\"\\u5c4f\\u663e\\u6d88\\u606f\",\"datatype\":\"{\\\"maxLength\\\":\\\"1024\\\",\\\"type\\\":\\\"string\\\"}\"},{\"objectid\":\"23\",\"objectname\":\"\\u5149\\u7167\\u5f3a\\u5ea6\",\"datatype\":\"{\\\"min\\\":\\\"2.5\\\",\\\"max\\\":\\\"89.9\\\",\\\"unit\\\":\\\"L\\\\\\/g\\\",\\\"step\\\":\\\"0.1\\\",\\\"type\\\":\\\"decimal\\\"}\"},{\"objectid\":\"5\",\"objectname\":\"\\u8bbe\\u5907\\u5f00\\u5173\",\"datatype\":\"{\\\"trueText\\\":\\\"\\\\u6253\\\\u5f00\\\",\\\"falseText\\\":\\\"\\\\u5173\\\\u95ed\\\",\\\"type\\\":\\\"bool\\\"}\"}]}',1680853735);

/*Table structure for table `fa_product` */

DROP TABLE IF EXISTS `fa_product`;

CREATE TABLE `fa_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(101) DEFAULT NULL,
  `category_id` varchar(101) DEFAULT NULL,
  `devicetype` varchar(101) DEFAULT NULL,
  `network` varchar(51) DEFAULT NULL,
  `content` text,
  `image` varchar(101) DEFAULT NULL,
  `switch` tinyint(1) DEFAULT '0' COMMENT '启用授权',
  `authentication` varchar(51) DEFAULT NULL,
  `mqttaccount` varchar(101) DEFAULT NULL,
  `mqttpwd` varchar(101) DEFAULT NULL,
  `type` varchar(101) DEFAULT 'devicepage',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `fa_product` */

insert  into `fa_product`(`id`,`name`,`category_id`,`devicetype`,`network`,`content`,`image`,`switch`,`authentication`,`mqttaccount`,`mqttpwd`,`type`) values (1,'智能门锁','家居安防','直连设备','WIFI','<p>防盗<br><br></p>','/assets/img/qrcode.png',1,'简单认证','QkSqRPC50etEqwhiC1It','QB1v52aZUikwSOQtTO4v','devicepage'),(2,'油烟机','厨房电器','直连设备','WIFI','<p>清爽控油</p>','/assets/img/qrcode.png',0,'简单认证','bxKeCOEpj3P5pZ0hOjyw','TGvurZ89wFdIjceDt6DF','devicepage'),(3,'电灯','电工照明','直连设备','WIFI','<p>照亮你的美</p>','/assets/img/qrcode.png',0,'简单认证','9g3vZKrlsXWhVxPPvMw9','seESstLfBvg6oVTZviZ5','devicepage'),(4,'智能窗帘','家居安防','直连设备','WIFI','<p>防偷窥</p>','/assets/img/qrcode.png',0,'简单认证','m9L6HG7pCLiyeoEeoZ8T','ih1LJ3nT9SNuh6JLW82a','devicepage'),(7,'电饭煲','厨房电器','直连设备','其他','<p>喂你吃米饭</p>','/uploads/20230329/c698026090893b6abc25a0d7eb48c7ca.jpeg',0,'简单认证','avI33COh2Heiwq6x6D0o','sudV1FlR6gfX6XfenUB8','devicepage'),(8,'微波炉','厨房电器','直连设备','其他','<p>加热饭菜</p>','/uploads/20230331/d2ae6bb4803f4333b1a33867d084ea2e.jpg',0,'简单认证','gNToj5j091WW09HVJthB','qbqJZd4mu5oTtyL5gj09','devicepage'),(9,'摄像头','家居安防','监控设备','WIFI','<p>火眼金睛</p>','/uploads/20230404/2edbed7622b9d17c1ec6d9a9514cbe14.jpg',0,'简单认证','JqPGjoIg6CXZWVkR2ftQ','TU27VziLiSpjTGrMD4PF','devicepage');

/*Table structure for table `fa_productcategory` */

DROP TABLE IF EXISTS `fa_productcategory`;

CREATE TABLE `fa_productcategory` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(101) DEFAULT NULL,
  `nickname` varchar(101) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `weigh` int DEFAULT NULL,
  `createtime` bigint DEFAULT NULL,
  `type` varchar(101) DEFAULT 'productpage',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `fa_productcategory` */

insert  into `fa_productcategory`(`id`,`name`,`nickname`,`image`,`weigh`,`createtime`,`type`) values (2,'电工照明','例如：电灯、插座','/assets/img/qrcode.png',2,1680057807,'productpage'),(3,'厨房电器','例如：电饭煲、油烟机、微波炉','/assets/img/qrcode.png',3,1680057885,'productpage'),(4,'家居安防','例如：智能门锁、智能窗帘、摄像头','/assets/img/qrcode.png',4,1680057980,'productpage');

/*Table structure for table `fa_productmodel` */

DROP TABLE IF EXISTS `fa_productmodel`;

CREATE TABLE `fa_productmodel` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(101) DEFAULT NULL,
  `identifier` varchar(101) DEFAULT NULL,
  `weigh` int DEFAULT NULL,
  `tag` varchar(101) DEFAULT NULL,
  `readswitch` tinyint(1) DEFAULT '0' COMMENT '只读',
  `chartswitch` tinyint(1) DEFAULT '0' COMMENT '图表显示',
  `datatype` varchar(101) DEFAULT NULL,
  `definition` longtext,
  `createtime` bigint DEFAULT NULL,
  `productid` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `fa_productmodel` */

insert  into `fa_productmodel`(`id`,`name`,`identifier`,`weigh`,`tag`,`readswitch`,`chartswitch`,`datatype`,`definition`,`createtime`,`productid`) values (5,'运行挡位','gear',5,'functions',0,0,'enum','{\"type\":\"enum\",\"enumList\":[{\"text\":\"\\u4f4e\\u901f\\u6321\\u4f4d\",\"value\":\"0\"},{\"text\":\"\\u4e2d\\u901f\\u6321\\u4f4d\",\"value\":\"1\"}]}',1680417814,2),(10,'上报数据','report_monitor',10,'functions',0,0,'integer','{\"min\":\"1\",\"max\":\"10\",\"unit\":\"\\u6b21\",\"step\":\"1\",\"type\":\"integer\"}',1680419041,1),(24,'设备重启','reset',24,'functions',0,0,'string','{\"maxLength\":\"1024\",\"type\":\"string\"}',1680424564,1),(45,'设备开关','switch',45,'functions',0,0,'bool','{\"trueText\":\"\\u6253\\u5f00\",\"falseText\":\"\\u5173\\u95ed\",\"type\":\"bool\"}',1680430413,1),(60,'室内亮度','brightness',60,'properties',0,0,'integer','{\"min\":\"0\",\"max\":\"100\",\"unit\":\"1\",\"step\":\"cd\\/m2\",\"type\":\"integer\"}',1680432671,1),(67,'室内亮度','brightness',67,'properties',0,0,'integer','{\"min\":\"0\",\"max\":\"101\",\"unit\":\"1\",\"step\":\"cd\\/m2\",\"type\":\"integer\"}',1680449385,8),(68,'上报数据','report_monitor',68,'functions',0,0,'string','{\"maxLength\":\"1024\",\"type\":\"string\"}',1680449573,8),(69,'上报数据','report_monitor',69,'functions',0,0,'integer','{\"min\":\"1\",\"max\":\"10\",\"unit\":\"\\u6b21\",\"step\":\"2\",\"type\":\"integer\"}',1680450523,7),(70,'上报数据','report_monitor',70,'functions',0,0,'integer','{\"min\":\"1\",\"max\":\"10\",\"unit\":\"\\u6b21\",\"step\":\"1\",\"type\":\"integer\"}',1680531218,4),(71,'室内亮度','brightness',71,'properties',0,0,'integer','{\"min\":\"0\",\"max\":\"100\",\"unit\":\"1\",\"step\":\"cd\\/m2\",\"type\":\"integer\"}',1680531663,4),(72,'设备发生异常','exception',72,'events',0,0,'string','{\"maxLength\":\"1024\",\"type\":\"string\"}',1680531771,1),(73,'室内亮度','brightness',73,'properties',0,0,'integer','{\"min\":\"0\",\"max\":\"99\",\"unit\":\"1\",\"step\":\"cd\\/m2\",\"type\":\"integer\"}',1680593687,7),(74,'上报数据','report_monitor',74,'functions',0,0,'integer','{\"min\":\"1\",\"max\":\"10\",\"unit\":\"\\u6b21\",\"step\":\"1\",\"type\":\"integer\"}',1680593761,3),(75,'上报数据','report_monitor',75,'functions',0,0,'integer','{\"min\":\"1\",\"max\":\"10\",\"unit\":\"\\u6b21\",\"step\":\"1\",\"type\":\"integer\"}',1680593947,9),(76,'灯光色值','light_color',76,'functions',0,0,'array','{\"arrayCount\":\"3\",\"arrayType\":\"integer\",\"type\":\"array\"}',1680850787,9),(77,'','',77,'properties',0,0,'array','{\"arrayCount\":\"3\",\"arrayType\":\"string\",\"type\":\"array\"}',1680850812,9);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
