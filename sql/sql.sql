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

/*Table structure for table `fa_customer` */

DROP TABLE IF EXISTS `fa_customer`;

CREATE TABLE `fa_customer` (
  `customerid` int NOT NULL AUTO_INCREMENT,
  `customername` varchar(51) DEFAULT NULL COMMENT '客户名字',
  `customermemo` varchar(101) DEFAULT NULL COMMENT '客户备注',
  `customeraddress_id` varchar(101) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '客户地址',
  `customeravatar` varchar(101) DEFAULT NULL COMMENT '客户头像',
  `customerphone` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '客户电话',
  `type` varchar(21) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'customerpage',
  PRIMARY KEY (`customerid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `fa_customer` */

insert  into `fa_customer`(`customerid`,`customername`,`customermemo`,`customeraddress_id`,`customeravatar`,`customerphone`,`type`) values (1,'高启强','强哥','京海市强盛集团','/uploads/20230216/bdf0e6c1a7691909e5dd7a909e4ec5df.jpg','123999','customerpage'),(2,'高启盛','小盛','京海市强盛集团','/uploads/20230216/c7e48d48475e86337e12c110ebc8fc7e.jpeg','123000','customerpage'),(3,'孟德海','曹孟德','京海市','/uploads/20230216/cd49cc348ad5dbe6c34b2e685e1e8ce7.jpeg','123333','customerpage'),(4,'陈泰','泰叔','京海市建工集团','/uploads/20230216/bd23cad88ae5c7e27e8e9a97eb2a94f6.jpeg','123222','customerpage'),(5,'安欣','安心','京海市刑侦大队','/uploads/20230216/d89ad3d86ea1ef14971daa303bb113bd.jpeg','123111','customerpage'),(6,'康子润','大帅哥','福建省漳州市芗城区','/uploads/20230216/ea14a7e1f9621f8b44c074236dc9f6b5.png','123888','customerpage'),(8,'老默','老默','京海市旧厂街鱼档','/uploads/20230224/2581a46f21f2e0d2196a8062a18b6dc1.jpeg','123123','customerpage');

/*Table structure for table `fa_customeraddress` */

DROP TABLE IF EXISTS `fa_customeraddress`;

CREATE TABLE `fa_customeraddress` (
  `addressid` int NOT NULL AUTO_INCREMENT,
  `addressname` varchar(11) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '客户名字',
  `addressmobile` varchar(101) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '客户地址',
  `type` varchar(51) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'addresspage',
  `addressphone` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`addressid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `fa_customeraddress` */

insert  into `fa_customeraddress`(`addressid`,`addressname`,`addressmobile`,`type`,`addressphone`) values (1,'高启强','京海市强盛集团','addresspage','123999'),(2,'高启强','京海市旧厂街厂房宿舍','addresspage','123999'),(3,'高启强','京海市建工集团','addresspage','123999'),(4,'高启盛','京海市省理工大','addresspage','123000'),(5,'李有田','京海市青华区莽村','addresspage','123777'),(6,'安欣','京海市刑侦大队','addresspage','123111'),(7,'康子润','福建省泉州市惠安县','addresspage','123888'),(8,'康子润','福建省漳州市芗城区','addresspage','123888'),(9,'老默','京海市旧厂街鱼档','addresspage','123123');

/*Table structure for table `fa_goods` */

DROP TABLE IF EXISTS `fa_goods`;

CREATE TABLE `fa_goods` (
  `goodsid` int NOT NULL AUTO_INCREMENT,
  `goodsname` varchar(51) DEFAULT NULL COMMENT '商品名称',
  `goodsimage` varchar(101) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '商品图',
  `goodscontent` text COMMENT '商品简介',
  `goodsunit` int DEFAULT NULL COMMENT '商品数量（件/斤）',
  `goodsprice` float DEFAULT NULL COMMENT '商品单价',
  `goodscategory_id` varchar(51) DEFAULT NULL COMMENT '商品分类',
  PRIMARY KEY (`goodsid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `fa_goods` */

insert  into `fa_goods`(`goodsid`,`goodsname`,`goodsimage`,`goodscontent`,`goodsunit`,`goodsprice`,`goodscategory_id`) values (3,'薯片','/uploads/20230216/9ec44310e366a563c52de5c881bcf153.jpeg','<p>非常好吃</p>',100,9.9,'零食'),(4,'椅子','/uploads/20230216/e4f3c7db18730d3a8d63cf0d9aacfba9.jpeg','<p>坐不坏</p>',100,198,'家具'),(6,'大白菜','/uploads/20230216/99789b24f5b17a7f4fd46335169a83da.jpg','<p>问问为</p>',100,12,'蔬菜'),(7,'奥特曼','/uploads/20230223/46f757e193048fa8a1b9d8bcdf493742.jpeg','<p>很好玩</p>',123,100,'玩具'),(8,'鱼','/uploads/20230224/906b3421257e6c166d517111e228b103.jpeg','<p>老默我想吃鱼了</p>',90,12.8,'海鲜');

/*Table structure for table `fa_goodscategory` */

DROP TABLE IF EXISTS `fa_goodscategory`;

CREATE TABLE `fa_goodscategory` (
  `categoryid` int NOT NULL AUTO_INCREMENT,
  `categoryname` varchar(51) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '商品类名',
  `categoryimage` varchar(101) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '商品图',
  `type` varchar(21) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'goodspage',
  PRIMARY KEY (`categoryid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `fa_goodscategory` */

insert  into `fa_goodscategory`(`categoryid`,`categoryname`,`categoryimage`,`type`) values (1,'玩具','/uploads/20230216/490133f4a1cdac98a87d28d1620118ea.jpeg','goodspage'),(2,'蔬菜','/uploads/20230216/4738039c946c87b77900f5052298c47f.jpg','goodspage'),(3,'家具','/uploads/20230216/086507d8b658da96555d44e7d56f23a9.jpeg','goodspage'),(4,'零食','/uploads/20230216/bdc6ca4281188cc4bbd08d08485b1bfe.jpeg','goodspage'),(5,'海鲜','/uploads/20230224/906b3421257e6c166d517111e228b103.jpeg','goodspage');

/*Table structure for table `fa_goodsorder` */

DROP TABLE IF EXISTS `fa_goodsorder`;

CREATE TABLE `fa_goodsorder` (
  `orderid` int NOT NULL AUTO_INCREMENT,
  `createtime` bigint DEFAULT NULL COMMENT '下单时间',
  `customer_id` int DEFAULT NULL COMMENT '客户ID',
  `address_id` varchar(101) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '收货地址',
  `name_id` varchar(21) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '收货姓名',
  `phone_id` varchar(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '收货电话',
  `status` enum('0','1','2') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '状态:0=待发货,1=已发货,2=取消订单',
  `totalprice` float DEFAULT NULL COMMENT '订单总价',
  PRIMARY KEY (`orderid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `fa_goodsorder` */

insert  into `fa_goodsorder`(`orderid`,`createtime`,`customer_id`,`address_id`,`name_id`,`phone_id`,`status`,`totalprice`) values (1,1676614915,6,'福建省漳州市芗城区','康子润','123888','0',207.9),(2,1676821412,4,'京海市建工集团','陈泰','123222','0',12),(6,1677158366,1,'京海市旧厂街厂房宿舍','高启强','123999','1',55.8),(7,1677161541,2,'京海市旧厂街厂房宿舍','高启盛','123000','0',1200),(9,1677170277,3,'京海市刑侦大队','孟德海','123333','1',163.8),(10,1677220534,5,'京海市刑侦大队','安欣','123111','2',6336),(11,1677221676,8,'京海市旧厂街鱼档','老默','123123','1',422.4);

/*Table structure for table `fa_goodsorderitems` */

DROP TABLE IF EXISTS `fa_goodsorderitems`;

CREATE TABLE `fa_goodsorderitems` (
  `itemsid` int NOT NULL AUTO_INCREMENT,
  `itemsname` varchar(51) DEFAULT NULL COMMENT '货品名称',
  `itemsimage` varchar(101) DEFAULT NULL COMMENT '货品图片',
  `itemscontent` text COMMENT '货品简介',
  `itemsunit` int DEFAULT NULL COMMENT '货品单位（件/斤）',
  `itemsprice` float DEFAULT NULL COMMENT '货品单价',
  `itemsquantity` int DEFAULT NULL COMMENT '采购数量',
  `items_idss` varchar(21) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '所属订单',
  PRIMARY KEY (`itemsid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `fa_goodsorderitems` */

insert  into `fa_goodsorderitems`(`itemsid`,`itemsname`,`itemsimage`,`itemscontent`,`itemsunit`,`itemsprice`,`itemsquantity`,`items_idss`) values (1,'薯片','/uploads/20230216/9ec44310e366a563c52de5c881bcf153.jpeg','<p>很好吃</p>',100,9.9,1,'1'),(2,'椅子','/uploads/20230216/e4f3c7db18730d3a8d63cf0d9aacfba9.jpeg','<p>坐不坏</p>',100,198,1,'1'),(3,'大白菜','/assets/img/qrcode.png','<p>嗡嗡嗡</p>',10,12,1,'2'),(4,'大白菜','/uploads/20230216/99789b24f5b17a7f4fd46335169a83da.jpg','<p>问问为</p>',1,12,3,'6'),(5,'薯片','/uploads/20230216/9ec44310e366a563c52de5c881bcf153.jpeg','<p>非常好吃</p>',100,9.9,2,'6'),(6,'奥特曼','/uploads/20230223/46f757e193048fa8a1b9d8bcdf493742.jpeg','<p>很好玩</p>',123,100,12,'7'),(9,'大白菜','/uploads/20230216/99789b24f5b17a7f4fd46335169a83da.jpg','<p>问问为</p>',100,12,12,'9'),(10,'薯片','/uploads/20230216/9ec44310e366a563c52de5c881bcf153.jpeg','<p>非常好吃</p>',100,9.9,2,'9'),(11,'椅子','/uploads/20230216/e4f3c7db18730d3a8d63cf0d9aacfba9.jpeg','<p>坐不坏</p>',100,198,32,'10'),(12,'鱼','/uploads/20230224/906b3421257e6c166d517111e228b103.jpeg','<p>老默我想吃鱼了</p>',90,12.8,33,'11');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
