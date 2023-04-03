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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `fa_objectmodel` */

insert  into `fa_objectmodel`(`id`,`name`,`identifier`,`weigh`,`tag`,`readswitch`,`chartswitch`,`datatype`,`definition`,`createtime`) values (4,'室内亮度','brightness',4,'properties',0,0,'integer','{\"min\":\"0\",\"max\":\"100\",\"unit\":\"1\",\"step\":\"cd\\/m2\",\"type\":\"integer\"}',1680243100),(5,'设备开关','switch',5,'functions',0,0,'bool','{\"trueText\":\"\\u6253\\u5f00\",\"falseText\":\"\\u5173\\u95ed\",\"type\":\"bool\"}',1680243678),(6,'空气湿度','humidity',6,'properties',0,0,'decimal','{\"min\":\"0\",\"max\":\"100\",\"unit\":\"%\",\"step\":\"0.1\",\"type\":\"decimal\"}',1680243796),(7,'设备发生异常','exception',7,'events',0,0,'string','{\"maxLength\":\"1024\",\"type\":\"string\"}',1680244178),(8,'灯光色值','light_color',8,'functions',0,0,'array','{\"arrayCount\":\"3\",\"arrayType\":\"integer\",\"type\":\"array\"}',1680244689),(12,'运行挡位','gear',12,'functions',0,0,'enum','{\"type\":\"enum\",\"enumList\":[{\"text\":\"\\u4f4e\\u901f\\u6321\\u4f4d\",\"value\":\"0\"},{\"text\":\"\\u4e2d\\u901f\\u6321\\u4f4d\",\"value\":\"1\"},{\"text\":\"\\u4e2d\\u9ad8\\u901f\\u6321\\u4f4d\",\"value\":\"2\"},{\"text\":\"\\u9ad8\\u901f\\u6863\\u4f4d\",\"value\":\"3\"}]}',1680251868),(14,'状态灯色','color',14,'functions',0,0,'enum','{\"type\":\"enum\",\"enumList\":[{\"text\":\"\\u7ea2\\u8272\",\"value\":\"0\"},{\"text\":\"\\u7eff\\u8272\",\"value\":\"1\"},{\"text\":\"\\u84dd\\u8272\",\"value\":\"2\"},{\"text\":\"\\u9ec4\\u8272\",\"value\":\"3\"}]}',1680340601),(17,'功能分组','cetegory',17,'functions',0,0,'object','{\"type\":\"object\",\"objecttype\":[{\"objectname\":\"\\u7a7a\\u6c14\\u6e7f\\u5ea6\",\"datatype\":\"{\\\"min\\\":\\\"0\\\",\\\"max\\\":\\\"100\\\",\\\"unit\\\":\\\"%\\\",\\\"step\\\":\\\"0.1\\\",\\\"type\\\":\\\"decimal\\\"}\"},{\"objectname\":\"\\u8bbe\\u5907\\u53d1\\u751f\\u5f02\\u5e38\",\"datatype\":\"{\\\"maxLength\\\":\\\"1024\\\",\\\"type\\\":\\\"string\\\"}\"}]}',1680349328),(18,'屏显消息','message',18,'functions',0,0,'string','{\"maxLength\":\"1024\",\"type\":\"string\"}',1680354189),(22,'上报数据','report_monitor',22,'functions',0,0,'integer','{\"min\":\"1\",\"max\":\"10\",\"unit\":\"\\u6b21\",\"step\":\"1\",\"type\":\"integer\"}',1680419123),(23,'光照强度','light_level',23,'properties',0,0,'decimal','{\"min\":\"2.5\",\"max\":\"89.2\",\"unit\":\"L\\/g\",\"step\":\"0.1\",\"type\":\"decimal\"}',1680492625),(24,'上报数据','report_monitor',24,'functions',0,0,'integer','{\"min\":\"1\",\"max\":\"10\",\"unit\":\"\\u6b21\",\"step\":\"1\",\"type\":\"integer\"}',1680531024);

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `fa_product` */

insert  into `fa_product`(`id`,`name`,`category_id`,`devicetype`,`network`,`content`,`image`,`switch`,`authentication`,`mqttaccount`,`mqttpwd`,`type`) values (1,'智能门锁','家居安防','直连设备','WIFI','<p>防盗<br><br></p>','/assets/img/qrcode.png',1,'简单认证','QkSqRPC50etEqwhiC1It','QB1v52aZUikwSOQtTO4v','devicepage'),(2,'油烟机','厨房电器','直连设备','WIFI','<p>清爽控油</p>','/assets/img/qrcode.png',0,'简单认证','bxKeCOEpj3P5pZ0hOjyw','TGvurZ89wFdIjceDt6DF','devicepage'),(3,'电灯','电工照明','直连设备','WIFI','<p>照亮你的美</p>','/assets/img/qrcode.png',0,'简单认证','9g3vZKrlsXWhVxPPvMw9','seESstLfBvg6oVTZviZ5','devicepage'),(4,'智能窗帘','家居安防','直连设备','WIFI','<p>防偷窥</p>','/assets/img/qrcode.png',0,'简单认证','m9L6HG7pCLiyeoEeoZ8T','ih1LJ3nT9SNuh6JLW82a','devicepage'),(7,'电饭煲','厨房电器','直连设备','WIFI','<p>喂你吃米饭</p>','/uploads/20230329/c698026090893b6abc25a0d7eb48c7ca.jpeg',0,'简单认证','7JodWAMnLF51gvN5yimc','CgbS4jDjf7lhl90k5QPj','devicepage'),(8,'微波炉','厨房电器','直连设备','其他','<p>加热饭菜</p>','/uploads/20230331/d2ae6bb4803f4333b1a33867d084ea2e.jpg',0,'简单认证','gNToj5j091WW09HVJthB','qbqJZd4mu5oTtyL5gj09','devicepage');

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
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `fa_productmodel` */

insert  into `fa_productmodel`(`id`,`name`,`identifier`,`weigh`,`tag`,`readswitch`,`chartswitch`,`datatype`,`definition`,`createtime`,`productid`) values (5,'运行挡位','gear',5,'functions',0,0,'enum','{\"type\":\"enum\",\"enumList\":[{\"text\":\"\\u4f4e\\u901f\\u6321\\u4f4d\",\"value\":\"0\"},{\"text\":\"\\u4e2d\\u901f\\u6321\\u4f4d\",\"value\":\"1\"}]}',1680417814,2),(10,'上报数据','report_monitor',10,'functions',0,0,'integer','{\"min\":\"1\",\"max\":\"10\",\"unit\":\"\\u6b21\",\"step\":\"1\",\"type\":\"integer\"}',1680419041,1),(24,'设备重启','reset',24,'functions',0,0,'string','{\"maxLength\":\"1024\",\"type\":\"string\"}',1680424564,1),(45,'设备开关','switch',45,'functions',0,0,'bool','{\"trueText\":\"\\u6253\\u5f00\",\"falseText\":\"\\u5173\\u95ed\",\"type\":\"bool\"}',1680430413,1),(60,'室内亮度','brightness',60,'properties',0,0,'integer','{\"min\":\"0\",\"max\":\"100\",\"unit\":\"1\",\"step\":\"cd\\/m2\",\"type\":\"integer\"}',1680432671,1),(67,'室内亮度','brightness',67,'properties',0,0,'integer','{\"min\":\"0\",\"max\":\"100\",\"unit\":\"1\",\"step\":\"cd\\/m2\",\"type\":\"integer\"}',1680449385,8),(68,'上报数据','report_monitor',68,'functions',0,0,'string','{\"maxLength\":\"1024\",\"type\":\"string\"}',1680449573,8),(69,'上报数据','report_monitor',69,'functions',0,0,'integer','{\"min\":\"1\",\"max\":\"10\",\"unit\":\"\\u6b21\",\"step\":\"1\",\"type\":\"integer\"}',1680450523,7),(70,'上报数据','report_monitor',70,'functions',0,0,'integer','{\"min\":\"1\",\"max\":\"10\",\"unit\":\"\\u6b21\",\"step\":\"1\",\"type\":\"integer\"}',1680531218,4),(71,'室内亮度','brightness',71,'properties',0,0,'integer','{\"min\":\"0\",\"max\":\"100\",\"unit\":\"1\",\"step\":\"cd\\/m2\",\"type\":\"integer\"}',1680531663,4),(72,'设备发生异常','exception',72,'events',0,0,'string','{\"maxLength\":\"1024\",\"type\":\"string\"}',1680531771,1);

/*Table structure for table `fa_test` */

DROP TABLE IF EXISTS `fa_test`;

CREATE TABLE `fa_test` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int DEFAULT '0' COMMENT '会员ID',
  `admin_id` int DEFAULT '0' COMMENT '管理员ID',
  `category_id` int unsigned DEFAULT '0' COMMENT '分类ID(单选)',
  `category_ids` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类ID(多选)',
  `tags` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '标签',
  `week` enum('monday','tuesday','wednesday') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '星期(单选):monday=星期一,tuesday=星期二,wednesday=星期三',
  `flag` set('hot','index','recommend') COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '标志(多选):hot=热门,index=首页,recommend=推荐',
  `genderdata` enum('male','female') COLLATE utf8mb4_unicode_ci DEFAULT 'male' COMMENT '性别(单选):male=男,female=女',
  `hobbydata` set('music','reading','swimming') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '爱好(多选):music=音乐,reading=读书,swimming=游泳',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '标题',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '图片',
  `images` varchar(1500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '图片组',
  `attachfile` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '附件',
  `keywords` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '关键字',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '描述',
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '省市',
  `json` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '配置:key=名称,value=值',
  `multiplejson` varchar(1500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '二维数组:title=标题,intro=介绍,author=作者,age=年龄',
  `price` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '价格',
  `views` int unsigned DEFAULT '0' COMMENT '点击',
  `workrange` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '时间区间',
  `startdate` date DEFAULT NULL COMMENT '开始日期',
  `activitytime` datetime DEFAULT NULL COMMENT '活动时间(datetime)',
  `year` year DEFAULT NULL COMMENT '年',
  `times` time DEFAULT NULL COMMENT '时间',
  `refreshtime` bigint DEFAULT NULL COMMENT '刷新时间',
  `createtime` bigint DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint DEFAULT NULL COMMENT '更新时间',
  `deletetime` bigint DEFAULT NULL COMMENT '删除时间',
  `weigh` int DEFAULT '0' COMMENT '权重',
  `switch` tinyint(1) DEFAULT '0' COMMENT '开关',
  `status` enum('normal','hidden') COLLATE utf8mb4_unicode_ci DEFAULT 'normal' COMMENT '状态',
  `state` enum('0','1','2') COLLATE utf8mb4_unicode_ci DEFAULT '1' COMMENT '状态值:0=禁用,1=正常,2=推荐',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='测试表';

/*Data for the table `fa_test` */

insert  into `fa_test`(`id`,`user_id`,`admin_id`,`category_id`,`category_ids`,`tags`,`week`,`flag`,`genderdata`,`hobbydata`,`title`,`content`,`image`,`images`,`attachfile`,`keywords`,`description`,`city`,`json`,`multiplejson`,`price`,`views`,`workrange`,`startdate`,`activitytime`,`year`,`times`,`refreshtime`,`createtime`,`updatetime`,`deletetime`,`weigh`,`switch`,`status`,`state`) values (1,1,1,12,'12,13','互联网,计算机','monday','hot,index','male','music,reading','我是一篇测试文章','<p>我是测试内容</p>','/assets/img/avatar.png','/assets/img/avatar.png,/assets/img/qrcode.png','/assets/img/avatar.png','关键字','描述','广西壮族自治区/百色市','{\"a\":\"1\",\"b\":\"2\"}','[{\"title\":\"标题一\",\"intro\":\"介绍一\",\"author\":\"小明\",\"age\":\"21\"}]','0.00',0,'2020-10-01 00:00:00 - 2021-10-31 23:59:59','2017-07-10','2017-07-10 18:24:45',2017,'18:24:45',1491635035,1491635035,1677158743,NULL,0,1,'normal','1');

/*Table structure for table `fa_user` */

DROP TABLE IF EXISTS `fa_user`;

CREATE TABLE `fa_user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `group_id` int unsigned NOT NULL DEFAULT '0' COMMENT '组别ID',
  `username` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '昵称',
  `password` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '密码',
  `salt` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '密码盐',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '手机号',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '头像',
  `level` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '等级',
  `gender` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `bio` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '格言',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `score` int NOT NULL DEFAULT '0' COMMENT '积分',
  `successions` int unsigned NOT NULL DEFAULT '1' COMMENT '连续登录天数',
  `maxsuccessions` int unsigned NOT NULL DEFAULT '1' COMMENT '最大连续登录天数',
  `prevtime` bigint DEFAULT NULL COMMENT '上次登录时间',
  `logintime` bigint DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '登录IP',
  `loginfailure` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '失败次数',
  `joinip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '加入IP',
  `jointime` bigint DEFAULT NULL COMMENT '加入时间',
  `createtime` bigint DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint DEFAULT NULL COMMENT '更新时间',
  `token` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'Token',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '状态',
  `verification` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '验证',
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `email` (`email`),
  KEY `mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员表';

/*Data for the table `fa_user` */

insert  into `fa_user`(`id`,`group_id`,`username`,`nickname`,`password`,`salt`,`email`,`mobile`,`avatar`,`level`,`gender`,`birthday`,`bio`,`money`,`score`,`successions`,`maxsuccessions`,`prevtime`,`logintime`,`loginip`,`loginfailure`,`joinip`,`jointime`,`createtime`,`updatetime`,`token`,`status`,`verification`) values (1,1,'admin','admin','f65827a387ee69e81266bd9edc313a1b','49eb03','admin@163.com','13888888888','http://www.mybt.com/assets/img/avatar.png',0,0,'2017-04-08','','0.00',0,1,1,1491635035,1491635035,'127.0.0.1',0,'127.0.0.1',1491635035,0,1491635035,'','normal','');

/*Table structure for table `fa_user_group` */

DROP TABLE IF EXISTS `fa_user_group`;

CREATE TABLE `fa_user_group` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '组名',
  `rules` text COLLATE utf8mb4_unicode_ci COMMENT '权限节点',
  `createtime` bigint DEFAULT NULL COMMENT '添加时间',
  `updatetime` bigint DEFAULT NULL COMMENT '更新时间',
  `status` enum('normal','hidden') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员组表';

/*Data for the table `fa_user_group` */

insert  into `fa_user_group`(`id`,`name`,`rules`,`createtime`,`updatetime`,`status`) values (1,'默认组','1,2,3,4,5,6,7,8,9,10,11,12',1491635035,1491635035,'normal');

/*Table structure for table `fa_user_money_log` */

DROP TABLE IF EXISTS `fa_user_money_log`;

CREATE TABLE `fa_user_money_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更余额',
  `before` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更前余额',
  `after` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更后余额',
  `memo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '备注',
  `createtime` bigint DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员余额变动表';

/*Data for the table `fa_user_money_log` */

/*Table structure for table `fa_user_rule` */

DROP TABLE IF EXISTS `fa_user_rule`;

CREATE TABLE `fa_user_rule` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `pid` int DEFAULT NULL COMMENT '父ID',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '标题',
  `remark` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `ismenu` tinyint(1) DEFAULT NULL COMMENT '是否菜单',
  `createtime` bigint DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint DEFAULT NULL COMMENT '更新时间',
  `weigh` int DEFAULT '0' COMMENT '权重',
  `status` enum('normal','hidden') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员规则表';

/*Data for the table `fa_user_rule` */

insert  into `fa_user_rule`(`id`,`pid`,`name`,`title`,`remark`,`ismenu`,`createtime`,`updatetime`,`weigh`,`status`) values (1,0,'index','Frontend','',1,1491635035,1491635035,1,'normal'),(2,0,'api','API Interface','',1,1491635035,1491635035,2,'normal'),(3,1,'user','User Module','',1,1491635035,1491635035,12,'normal'),(4,2,'user','User Module','',1,1491635035,1491635035,11,'normal'),(5,3,'index/user/login','Login','',0,1491635035,1491635035,5,'normal'),(6,3,'index/user/register','Register','',0,1491635035,1491635035,7,'normal'),(7,3,'index/user/index','User Center','',0,1491635035,1491635035,9,'normal'),(8,3,'index/user/profile','Profile','',0,1491635035,1491635035,4,'normal'),(9,4,'api/user/login','Login','',0,1491635035,1491635035,6,'normal'),(10,4,'api/user/register','Register','',0,1491635035,1491635035,8,'normal'),(11,4,'api/user/index','User Center','',0,1491635035,1491635035,10,'normal'),(12,4,'api/user/profile','Profile','',0,1491635035,1491635035,3,'normal');

/*Table structure for table `fa_user_score_log` */

DROP TABLE IF EXISTS `fa_user_score_log`;

CREATE TABLE `fa_user_score_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `score` int NOT NULL DEFAULT '0' COMMENT '变更积分',
  `before` int NOT NULL DEFAULT '0' COMMENT '变更前积分',
  `after` int NOT NULL DEFAULT '0' COMMENT '变更后积分',
  `memo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '备注',
  `createtime` bigint DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员积分变动表';

/*Data for the table `fa_user_score_log` */

/*Table structure for table `fa_user_token` */

DROP TABLE IF EXISTS `fa_user_token`;

CREATE TABLE `fa_user_token` (
  `token` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Token',
  `user_id` int unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `createtime` bigint DEFAULT NULL COMMENT '创建时间',
  `expiretime` bigint DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员Token表';

/*Data for the table `fa_user_token` */

/*Table structure for table `fa_version` */

DROP TABLE IF EXISTS `fa_version`;

CREATE TABLE `fa_version` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `oldversion` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '旧版本号',
  `newversion` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '新版本号',
  `packagesize` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '包大小',
  `content` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '升级内容',
  `downloadurl` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '下载地址',
  `enforce` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '强制更新',
  `createtime` bigint DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint DEFAULT NULL COMMENT '更新时间',
  `weigh` int NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='版本表';

/*Data for the table `fa_version` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
