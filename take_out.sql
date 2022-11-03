/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 8.0.30 : Database - take_out
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`take_out` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `take_out`;

/*Table structure for table `address_book` */

DROP TABLE IF EXISTS `address_book`;

CREATE TABLE `address_book` (
  `id` bigint NOT NULL COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `consignee` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '收货人',
  `sex` tinyint NOT NULL DEFAULT '1' COMMENT '性别 0 女 1 男',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '手机号',
  `province_code` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '省级区划编号',
  `province_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '省级名称',
  `city_code` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '市级区划编号',
  `city_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '市级名称',
  `district_code` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '区级区划编号',
  `district_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '区级名称',
  `detail` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '详细地址',
  `label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标签',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默认 0 否 1是',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建人',
  `update_user` bigint NOT NULL COMMENT '修改人',
  `is_deleted` int NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='地址管理';

/*Data for the table `address_book` */

insert  into `address_book`(`id`,`user_id`,`consignee`,`sex`,`phone`,`province_code`,`province_name`,`city_code`,`city_name`,`district_code`,`district_name`,`detail`,`label`,`is_default`,`create_time`,`update_time`,`create_user`,`update_user`,`is_deleted`) values (1417414526093082626,1417012167126876162,'小明',1,'13812345678',NULL,NULL,NULL,NULL,NULL,NULL,'昌平区金燕龙办公楼','公司',1,'2021-07-20 17:22:12','2021-07-20 17:26:33',1417012167126876162,1417012167126876162,0),(1417414926166769666,1417012167126876162,'小李',1,'13512345678',NULL,NULL,NULL,NULL,NULL,NULL,'测试','家',0,'2021-07-20 17:23:47','2021-07-20 17:23:47',1417012167126876162,1417012167126876162,0),(1535574227775545346,2,'邓鸿宇',1,'15181551844',NULL,'北京市',NULL,'北京市','110101','东城区','四川民族学院A校区','公司',0,'2022-06-11 18:46:40','2022-06-11 18:46:40',2,2,0),(1535590661197029377,2,'邓鸿宇',1,'15181551844',NULL,'山西省',NULL,'太原市','140105','小店区','四川民族学院A校区','家',0,'2022-06-11 19:51:58','2022-06-11 19:51:58',2,2,0),(1582935120157884418,2,'邓鸿宇',1,'15181551822',NULL,'四川省',NULL,'甘孜藏族自治州','513301','康定市','四川民族学院A校区','公司',1,'2022-10-20 11:21:57','2022-10-20 11:58:40',2,2,0);

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` bigint NOT NULL COMMENT '主键',
  `type` int DEFAULT NULL COMMENT '类型   1 菜品分类 2 套餐分类',
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '分类名称',
  `sort` int NOT NULL DEFAULT '0' COMMENT '顺序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建人',
  `update_user` bigint NOT NULL COMMENT '修改人',
  `is_deleted` int NOT NULL DEFAULT '0' COMMENT '是否删除0未删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_category_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='菜品及套餐分类';

/*Data for the table `category` */

insert  into `category`(`id`,`type`,`name`,`sort`,`create_time`,`update_time`,`create_user`,`update_user`,`is_deleted`) values (1397844263642378242,1,'湘菜',1,'2021-05-27 09:16:58','2021-07-15 20:25:23',1,1,0),(1397844303408574465,1,'川菜',2,'2021-05-27 09:17:07','2021-06-02 14:27:22',1,1,0),(1397844391040167938,1,'粤菜',3,'2021-05-27 09:17:28','2021-07-09 14:37:13',1,1,0),(1413341197421846529,1,'饮品',11,'2021-07-09 11:36:15','2021-07-09 14:39:15',1,1,0),(1413342269393674242,2,'商务套餐',5,'2021-07-09 11:40:30','2021-07-09 14:43:45',1,1,0),(1413386191767674881,2,'儿童套餐',6,'2021-07-09 14:35:02','2021-07-09 14:39:05',1,1,0),(1529092782202785794,1,'主食',22,'2022-05-24 21:31:43','2022-05-24 21:31:43',1,1,0),(1534141220346806273,2,'成人套餐',12,'2022-06-07 19:52:24','2022-06-07 19:52:24',1,1,0);

/*Table structure for table `dish` */

DROP TABLE IF EXISTS `dish`;

CREATE TABLE `dish` (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '菜品名称',
  `category_id` bigint NOT NULL COMMENT '菜品分类id',
  `price` decimal(10,2) DEFAULT NULL COMMENT '菜品价格',
  `code` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '商品码',
  `image` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '图片',
  `description` varchar(400) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '描述信息',
  `status` int NOT NULL DEFAULT '1' COMMENT '0 停售 1 起售',
  `review_count` int DEFAULT '0' COMMENT '评论数量',
  `sales_volume` bigint DEFAULT '0' COMMENT '销量',
  `sort` int NOT NULL DEFAULT '0' COMMENT '顺序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建人',
  `update_user` bigint NOT NULL COMMENT '修改人',
  `is_deleted` int NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_dish_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='菜品管理';

/*Data for the table `dish` */

insert  into `dish`(`id`,`name`,`category_id`,`price`,`code`,`image`,`description`,`status`,`review_count`,`sales_volume`,`sort`,`create_time`,`update_time`,`create_user`,`update_user`,`is_deleted`) values (1397849739276890114,'辣子鸡',1397844263642378242,'1000.00','222222222','567e38aa-9282-41e1-8678-48ee487cbf9e.png','来自鲜嫩美味的小鸡，值得一尝',1,0,0,0,'2021-05-27 09:38:43','2022-10-31 15:17:13',1,2,0),(1397850140982161409,'毛氏红烧肉',1397844263642378242,'1000.00','123412341234','965d7ddc-fc67-40f8-85e0-cc54ecfb710c.png','毛氏红烧肉毛氏红烧肉，确定不来一份？',0,0,0,0,'2021-05-27 09:40:19','2022-10-31 15:17:49',1,2,0),(1397850392090947585,'组庵鱼翅',1397844263642378242,'1000.00','123412341234','90ab4e91-f371-408e-a49e-63d1b5d6fe5c.png','组庵鱼翅，看图足以表明好吃程度',0,0,0,0,'2021-05-27 09:41:19','2022-10-31 15:18:15',1,2,0),(1397850851245600769,'霸王别姬',1397844263642378242,'1000.00','123412341234','c338df6f-9e73-403b-9411-33446e0c5704.jpg','还有什么比霸王别姬更美味的呢？',1,0,0,0,'2021-05-27 09:43:08','2022-06-12 17:19:27',1,1,0),(1397851099502260226,'全家福',1397844263642378242,'1000.00','23412341234','4de1af61-4f8b-4c31-9102-33dfc1d8d031.jpg','别光吃肉啦，来份全家福吧，让你长寿又美味',1,0,0,0,'2021-05-27 09:44:08','2022-06-12 17:19:47',1,1,0),(1397851370462687234,'邵阳猪血丸子',1397844263642378242,'1000.00','1246812345678','65d0b451-0464-41d4-8f7e-208fb4403a00.jpg','看，美味不？来嘛来嘛，这才是最爱吖',1,3,3,0,'2021-05-27 09:45:12','2022-10-29 14:28:36',1,2,0),(1397851668262465537,'口味蛇',1397844263642378242,'1000.00','1234567812345678','d446b1be-b6dc-4f3e-8d01-307f755991d1.jpg','爬行界的扛把子，东兴-口味蛇，让你欲罢不能',1,0,1,0,'2021-05-27 09:46:23','2022-10-27 15:36:42',1,2,0),(1397852391150759938,'辣子鸡丁',1397844303408574465,'1000.00','2346812468','58bca98c-0ef1-4590-8329-c3f35513be0b.jpg','辣子鸡丁，辣子鸡丁，永远的魂',1,0,0,0,'2021-05-27 09:49:16','2022-06-12 17:21:09',1,1,0),(1397853183287013378,'麻辣兔头',1397844303408574465,'1000.00','123456787654321','70a177a7-0fac-4ca0-85c7-25226295c59b.jpg','麻辣兔头的详细制作，麻辣鲜香，色泽红润，回味悠长',1,0,0,0,'2021-05-27 09:52:24','2022-06-12 17:20:14',1,1,0),(1397853709101740034,'蒜泥白肉',1397844303408574465,'1000.00','1234321234321','fd8e46a4-5b90-4d09-8836-f2a56cfbb51c.jpeg','多么的有食欲啊',1,0,0,0,'2021-05-27 09:54:30','2022-06-12 17:20:52',1,1,0),(1397853890262118402,'鱼香肉丝',1397844303408574465,'1000.00','1234212321234','5c0a349a-c0d9-43d0-bfe7-7c1720c068d3.jpg','鱼香肉丝简直就是我们童年回忆的一道经典菜，上学的时候点个鱼香肉丝盖饭坐在宿舍床上看着肥皂剧，绝了！现在完美复刻一下上学的时候感觉',1,0,0,0,'2021-05-27 09:55:13','2022-06-12 17:20:35',1,1,0),(1397854652581064706,'麻辣水煮鱼',1397844303408574465,'1000.00','2345312·345321','50f361c7-ce7f-45a2-9ca4-3108f2d8fc29.jpg','鱼片是买的切好的鱼片，放几个虾，增加味道',1,0,0,0,'2021-05-27 09:58:15','2022-06-12 17:19:07',1,1,0),(1397854865672679425,'鱼香炒鸡蛋',1397844303408574465,'1000.00','23456431·23456','d7817507-09c0-4a63-a4cc-a8eef9abb5a0.jpg','鱼香菜也是川味的特色。里面没有鱼却鱼香味',0,0,0,0,'2021-05-27 09:59:06','2022-06-03 20:25:01',1,1,0),(1397860242057375745,'脆皮烧鹅',1397844391040167938,'1000.00','123456786543213456','546c9e25-a9b6-4de7-a17d-8baaea004a7f.jpeg','“广东烤鸭美而香，却胜烧鹅说古冈（今新会），燕瘦环肥各佳妙，君休偏重便宜坊”，可见烧鹅与烧鸭在粤菜之中已早负盛名。作为广州最普遍和最受欢迎的烧烤肉食，以它的“色泽金红，皮脆肉嫩，味香可口”的特色，在省城各大街小巷的烧卤店随处可见。',0,0,0,0,'2021-05-27 10:20:27','2022-06-03 20:25:01',1,1,0),(1397860578738352129,'白切鸡',1397844391040167938,'1000.00','12345678654','4fde8d92-0db6-4538-afb3-b768ed6d4676.jpeg','白切鸡是一道色香味俱全的特色传统名肴，又叫白斩鸡，是粤菜系鸡肴中的一种，始于清代的民间。白切鸡通常选用细骨农家鸡与沙姜、蒜茸等食材，慢火煮浸白切鸡皮爽肉滑，清淡鲜美。著名的泮溪酒家白切鸡，曾获商业部优质产品金鼎奖。湛江白切鸡更是驰名粤港澳。粤菜厨坛中，鸡的菜式有200余款之多，而最为人常食不厌的正是白切鸡，深受食家青睐。',1,0,0,0,'2021-05-27 10:21:48','2022-06-02 14:47:19',1,1,0),(1397860792492666881,'烤乳猪',1397844391040167938,'1000.00','213456432123456','f9c8c2c0-d03d-463d-9686-cf5290f024e4.jpg','广式烧乳猪主料是小乳猪，辅料是蒜，调料是五香粉、芝麻酱、八角粉等，本菜品主要通过将食材放入炭火中烧烤而成。烤乳猪是广州最著名的特色菜，并且是“满汉全席”中的主打菜肴之一。烤乳猪也是许多年来广东人祭祖的祭品之一，是家家都少不了的应节之物，用乳猪祭完先人后，亲戚们再聚餐食用。',1,0,0,0,'2021-05-27 10:22:39','2022-06-02 14:45:19',1,1,0),(1397860963880316929,'脆皮乳鸽',1397844391040167938,'1000.00','1234563212345','4dd6534f-4f59-4ba9-8aec-480626893bd3.jpeg','“脆皮乳鸽”是广东菜中的一道传统名菜，属于粤菜系，具有皮脆肉嫩、色泽红亮、鲜香味美的特点，常吃可使身体强健，清肺顺气。随着菜品制作工艺的不断发展，逐渐形成了熟炸法、生炸法和烤制法三种制作方法。无论那种制作方法，都是在鸽子经过一系列的加工，挂脆皮水后再加工而成，正宗的“脆皮乳鸽皮脆肉嫩、色泽红亮、鲜香味美、香气馥郁。这三种方法的制作过程都不算复杂，但想达到理想的效果并不容易。',1,0,0,0,'2021-05-27 10:23:19','2022-06-02 14:44:10',1,1,0),(1397861683434139649,'清蒸河鲜海鲜',1397844391040167938,'1000.00','1234567876543213456','c25c850b-3ade-4fc5-b0a2-fb4f4fc3c445.jpeg','新鲜的海鲜，清蒸是最好的处理方式。鲜，体会为什么叫海鲜。清蒸是广州最经典的烹饪手法，过去岭南地区由于峻山大岭阻隔，交通不便，经济发展起步慢，自家打的鱼放在锅里煮了就吃，没有太多的讲究，但却发现这清淡的煮法能使鱼的鲜甜跃然舌尖。',1,0,0,0,'2021-05-27 10:26:11','2022-06-01 23:01:54',1,1,0),(1397862198033297410,'老火靓汤',1397844391040167938,'1000.00','123456786532455','119f5fac-d610-4a5b-9af3-f8a182c9469b.jpeg','老火靓汤又称广府汤，是广府人传承数千年的食补养生秘方，慢火煲煮的中华老火靓汤，火候足，时间长，既取药补之效，又取入口之甘甜。 广府老火汤种类繁多，可以用各种汤料和烹调方法，烹制出各种不同口味、不同功效的汤来。',1,0,0,0,'2021-05-27 10:28:14','2022-06-01 23:53:47',1,1,0),(1397862477831122945,'上汤焗龙虾',1397844391040167938,'1000.00','1234567865432','84b15971-8ea8-4b68-a3f2-07ed8101b9c2.jpeg','上汤焗龙虾是一道色香味俱全的传统名菜，属于粤菜系。此菜以龙虾为主料，配以高汤制成的一道海鲜美食。本品肉质洁白细嫩，味道鲜美，蛋白质含量高，脂肪含量低，营养丰富。是色香味俱全的传统名菜。',1,0,0,0,'2021-05-27 10:29:20','2022-06-01 23:00:35',1,1,0),(1413342036832100354,'北冰洋',1413341197421846529,'500.00','','9335d9f3-3e87-4ae8-b6fc-a6b6f2b6fb9c.png','无',1,0,0,0,'2021-07-09 11:39:35','2022-06-01 23:55:06',1,1,0),(1413384757047271425,'王老吉',1413341197421846529,'500.00','','2b67474c-4541-4137-ae07-8cdb40752b08.jpg','无',1,0,0,0,'2021-07-09 14:29:20','2022-06-01 22:57:40',1,1,0),(1413385247889891330,'米饭',1529092782202785794,'200.00','','6e7c4689-6f16-4519-81db-71ce4daa1d42.png','香喷喷的米饭哟',1,0,1,0,'2021-07-09 14:31:17','2022-10-27 10:58:05',1,2,0),(1531970493397045250,'test',1397844303408574465,'1000.00','','c444009c-e4de-4af3-9270-b11104dcb51e.jpg','无',1,0,0,0,'2022-06-01 20:06:42','2022-06-12 17:22:09',1,1,0);

/*Table structure for table `dish_flavor` */

DROP TABLE IF EXISTS `dish_flavor`;

CREATE TABLE `dish_flavor` (
  `id` bigint NOT NULL COMMENT '主键',
  `dish_id` bigint NOT NULL COMMENT '菜品',
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '口味名称',
  `value` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '口味数据list',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建人',
  `update_user` bigint NOT NULL COMMENT '修改人',
  `is_deleted` int NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='菜品口味关系表';

/*Data for the table `dish_flavor` */

insert  into `dish_flavor`(`id`,`dish_id`,`name`,`value`,`create_time`,`update_time`,`create_user`,`update_user`,`is_deleted`) values (1397849417888346113,1397849417854791681,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2021-05-27 09:37:27','2021-05-27 09:37:27',1,1,0),(1397849739297861633,1397849739276890114,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]','2022-10-31 15:17:13','2022-10-31 15:17:13',2,2,0),(1397849739323027458,1397849739276890114,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2022-10-31 15:17:13','2022-10-31 15:17:13',2,2,0),(1397849936421761025,1397849936404983809,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]','2021-05-27 09:39:30','2021-05-27 09:39:30',1,1,0),(1397849936438538241,1397849936404983809,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2021-05-27 09:39:30','2021-05-27 09:39:30',1,1,0),(1397850141015715841,1397850140982161409,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]','2022-10-31 15:17:49','2022-10-31 15:17:49',2,2,0),(1397850141040881665,1397850140982161409,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2022-10-31 15:17:49','2022-10-31 15:17:49',2,2,0),(1397850392120307713,1397850392090947585,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2022-10-31 15:18:15','2022-10-31 15:18:15',2,2,0),(1397850392137084929,1397850392090947585,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2022-10-31 15:18:15','2022-10-31 15:18:15',2,2,0),(1397850630734262274,1397850630700707841,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]','2021-05-27 09:42:16','2021-05-27 09:42:16',1,1,0),(1397850630755233794,1397850630700707841,'辣度','[\"微辣\",\"中辣\",\"重辣\"]','2021-05-27 09:42:16','2021-05-27 09:42:16',1,1,0),(1397850851274960898,1397850851245600769,'忌口','[\"不要蒜\",\"不要香菜\",\"不要辣\"]','2022-06-12 17:19:27','2022-06-12 17:19:27',1,1,0),(1397850851283349505,1397850851245600769,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2022-06-12 17:19:27','2022-06-12 17:19:27',1,1,0),(1397851099523231745,1397851099502260226,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]','2022-06-12 17:19:47','2022-06-12 17:19:47',1,1,0),(1397851099527426050,1397851099502260226,'辣度','[\"不辣\",\"微辣\",\"中辣\"]','2022-06-12 17:19:47','2022-06-12 17:19:47',1,1,0),(1397851370483658754,1397851370462687234,'温度','[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]','2022-06-12 17:21:42','2022-06-12 17:21:42',1,1,0),(1397851370483658755,1397851370462687234,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]','2022-06-12 17:21:42','2022-06-12 17:21:42',1,1,0),(1397851370483658756,1397851370462687234,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2022-06-12 17:21:42','2022-06-12 17:21:42',1,1,0),(1397851668283437058,1397851668262465537,'温度','[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]','2022-06-12 17:21:25','2022-06-12 17:21:25',1,1,0),(1397852391180120065,1397852391150759938,'忌口','[\"不要葱\",\"不要香菜\",\"不要辣\"]','2022-06-12 17:21:09','2022-06-12 17:21:09',1,1,0),(1397852391196897281,1397852391150759938,'辣度','[\"不辣\",\"微辣\",\"重辣\"]','2022-06-12 17:21:09','2022-06-12 17:21:09',1,1,0),(1397853183307984898,1397853183287013378,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2022-06-12 17:20:14','2022-06-12 17:20:14',1,1,0),(1397853423486414850,1397853423461249026,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2021-05-27 09:53:22','2021-05-27 09:53:22',1,1,0),(1397853709126905857,1397853709101740034,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]','2022-06-12 17:20:52','2022-06-12 17:20:52',1,1,0),(1397853890283089922,1397853890262118402,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2022-06-12 17:20:35','2022-06-12 17:20:35',1,1,0),(1397854133632413697,1397854133603053569,'温度','[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]','2021-05-27 09:56:11','2021-05-27 09:56:11',1,1,0),(1397854652623007745,1397854652581064706,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]','2022-06-12 17:19:07','2022-06-12 17:19:07',1,1,0),(1397854652635590658,1397854652581064706,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2022-06-12 17:19:07','2022-06-12 17:19:07',1,1,0),(1397854865735593986,1397854865672679425,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2022-06-02 16:05:08','2022-06-02 16:05:08',1,1,0),(1397855742303186946,1397855742273826817,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2021-05-27 10:02:35','2021-05-27 10:02:35',1,1,0),(1397855906497605633,1397855906468245506,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]','2021-05-27 10:03:14','2021-05-27 10:03:14',1,1,0),(1397856190573621250,1397856190540066818,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2021-05-27 10:04:21','2021-05-27 10:04:21',1,1,0),(1397859056709316609,1397859056684150785,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2021-05-27 10:15:45','2021-05-27 10:15:45',1,1,0),(1397859277837217794,1397859277812051969,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2021-05-27 10:16:37','2021-05-27 10:16:37',1,1,0),(1397859487502086146,1397859487476920321,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2021-05-27 10:17:27','2021-05-27 10:17:27',1,1,0),(1397859757061615618,1397859757036449794,'甜味','[\"无糖\",\"少糖\",\"半躺\",\"多糖\",\"全糖\"]','2021-05-27 10:18:32','2021-05-27 10:18:32',1,1,0),(1397860242086735874,1397860242057375745,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2022-06-02 16:04:56','2022-06-02 16:04:56',1,1,0),(1397860963918065665,1397860963880316929,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2022-06-02 14:44:10','2022-06-02 14:44:10',1,1,0),(1397861135754506242,1397861135733534722,'甜味','[\"无糖\",\"少糖\",\"半躺\",\"多糖\",\"全糖\"]','2021-05-27 10:24:00','2021-05-27 10:24:00',1,1,0),(1397861370035744769,1397861370010578945,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2021-05-27 10:24:56','2021-05-27 10:24:56',1,1,0),(1397861683459305474,1397861683434139649,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]','2022-06-01 23:01:54','2022-06-01 23:01:54',1,1,0),(1397861898467717121,1397861898438356993,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]','2021-05-27 10:27:02','2021-05-27 10:27:02',1,1,0),(1397862198054268929,1397862198033297410,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]','2022-06-01 23:53:47','2022-06-01 23:53:47',1,1,0),(1397862477835317250,1397862477831122945,'辣度','[\"不辣\",\"微辣\",\"中辣\"]','2022-06-01 23:00:36','2022-06-01 23:00:36',1,1,0),(1398089545865015297,1398089545676271617,'温度','[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]','2021-05-28 01:31:38','2021-05-28 01:31:38',1,1,0),(1398089782323097601,1398089782285348866,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2021-05-28 01:32:34','2021-05-28 01:32:34',1,1,0),(1398090003262255106,1398090003228700673,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]','2021-05-28 01:33:27','2021-05-28 01:33:27',1,1,0),(1398090264554811394,1398090264517062657,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]','2021-05-28 01:34:29','2021-05-28 01:34:29',1,1,0),(1398090455399837698,1398090455324340225,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2021-05-28 01:35:14','2021-05-28 01:35:14',1,1,0),(1398090685449023490,1398090685419663362,'温度','[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]','2021-05-28 01:36:09','2021-05-28 01:36:09',1,1,0),(1398090825358422017,1398090825329061889,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]','2021-05-28 01:36:43','2021-05-28 01:36:43',1,1,0),(1398091007051476993,1398091007017922561,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2021-05-28 01:37:26','2021-05-28 01:37:26',1,1,0),(1398091296164851713,1398091296131297281,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2021-05-28 01:38:35','2021-05-28 01:38:35',1,1,0),(1398091546531246081,1398091546480914433,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]','2021-05-28 01:39:35','2021-05-28 01:39:35',1,1,0),(1398091729809747969,1398091729788776450,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2021-05-28 01:40:18','2021-05-28 01:40:18',1,1,0),(1398091889499484161,1398091889449152513,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2021-05-28 01:40:56','2021-05-28 01:40:56',1,1,0),(1398092095179763713,1398092095142014978,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2021-05-28 01:41:45','2021-05-28 01:41:45',1,1,0),(1398092283877306370,1398092283847946241,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2021-05-28 01:42:30','2021-05-28 01:42:30',1,1,0),(1398094018939236354,1398094018893099009,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2021-05-28 01:49:24','2021-05-28 01:49:24',1,1,0),(1398094391494094850,1398094391456346113,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2021-05-28 01:50:53','2021-05-28 01:50:53',1,1,0),(1399574026165727233,1399305325713600514,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2021-06-01 03:50:25','2021-06-01 03:50:25',1399309715396669441,1399309715396669441,0),(1413389540592263169,1413384757047271425,'温度','[\"常温\",\"冷藏\"]','2022-06-01 22:57:40','2022-06-01 22:57:40',1,1,0),(1413389684020682754,1413342036832100354,'温度','[\"常温\",\"冷藏\"]','2022-06-01 23:55:06','2022-06-01 23:55:06',1,1,0),(1531970493522874369,1531970493397045250,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]','2022-06-12 17:22:09','2022-06-12 17:22:09',1,1,0),(1531970493522874370,1531970493397045250,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]','2022-06-12 17:22:09','2022-06-12 17:22:09',1,1,0);

/*Table structure for table `employee` */

DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '姓名',
  `username` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '密码',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '手机号',
  `sex` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '性别',
  `id_number` varchar(18) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '身份证号',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态 0:禁用，1:正常',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建人',
  `update_user` bigint NOT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='员工信息';

/*Data for the table `employee` */

insert  into `employee`(`id`,`name`,`username`,`password`,`phone`,`sex`,`id_number`,`status`,`create_time`,`update_time`,`create_user`,`update_user`) values (1,'管理员','admin','e10adc3949ba59abbe56e057f20f883e','15181551841','男','110101199001010047',1,'2021-05-06 17:20:07','2022-06-07 22:59:40',1,1),(1527993042081914881,'张三','test123','e10adc3949ba59abbe56e057f20f883e','15181551842','女','513433200103081818',1,'2022-05-21 20:41:44','2022-06-07 23:12:11',1,1);

/*Table structure for table `favorites_list` */

DROP TABLE IF EXISTS `favorites_list`;

CREATE TABLE `favorites_list` (
  `id` bigint NOT NULL COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `dish_id` bigint NOT NULL COMMENT '菜品id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

/*Data for the table `favorites_list` */

/*Table structure for table `goods_description` */

DROP TABLE IF EXISTS `goods_description`;

CREATE TABLE `goods_description` (
  `id` bigint NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '菜品名称',
  `dish_id` bigint NOT NULL COMMENT '菜品id',
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '菜品图片',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '菜品描述',
  `main_material` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '菜品主料',
  `production_method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '菜品制作方式',
  `count` int DEFAULT NULL COMMENT '每份数量',
  `taste` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '菜品口味',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

/*Data for the table `goods_description` */

insert  into `goods_description`(`id`,`name`,`dish_id`,`image`,`description`,`main_material`,`production_method`,`count`,`taste`) values (1582198326978150402,'辣子鸡',1397849739276890114,'0a3b3288-3446-4420-bbff-f263d0c02d8e.jpg',NULL,NULL,NULL,0,NULL),(1582198327200448514,'毛氏红烧肉',1397850140982161409,'0a3b3288-3446-4420-bbff-f263d0c02d8e.jpg',NULL,NULL,NULL,0,NULL),(1582198327267557378,'组庵鱼翅',1397850392090947585,'740c79ce-af29-41b8-b78d-5f49c96e38c4.jpg',NULL,NULL,NULL,0,NULL),(1582198327330471937,'霸王别姬',1397850851245600769,'c338df6f-9e73-403b-9411-33446e0c5704.jpg',NULL,NULL,NULL,0,NULL),(1582198327397580802,'全家福',1397851099502260226,'4de1af61-4f8b-4c31-9102-33dfc1d8d031.jpg','发发发发发发付付付付付付付付付付','xxx','发发发',1,'发发发'),(1582198327464689666,'邵阳猪血丸子',1397851370462687234,'65d0b451-0464-41d4-8f7e-208fb4403a00.jpg',NULL,NULL,NULL,0,NULL),(1582198327531798530,'口味蛇',1397851668262465537,'d446b1be-b6dc-4f3e-8d01-307f755991d1.jpg',NULL,NULL,NULL,0,NULL),(1582198327598907393,'辣子鸡丁',1397852391150759938,'58bca98c-0ef1-4590-8329-c3f35513be0b.jpg',NULL,NULL,NULL,0,NULL),(1582198327661821953,'麻辣兔头',1397853183287013378,'70a177a7-0fac-4ca0-85c7-25226295c59b.jpg',NULL,NULL,NULL,0,NULL),(1582198327796039681,'蒜泥白肉',1397853709101740034,'fd8e46a4-5b90-4d09-8836-f2a56cfbb51c.jpeg',NULL,NULL,NULL,0,NULL),(1582198327796039682,'鱼香肉丝',1397853890262118402,'5c0a349a-c0d9-43d0-bfe7-7c1720c068d3.jpg',NULL,NULL,NULL,0,NULL),(1582198328249024513,'麻辣水煮鱼',1397854652581064706,'50f361c7-ce7f-45a2-9ca4-3108f2d8fc29.jpg',NULL,NULL,NULL,0,NULL),(1582198328504877058,'鱼香炒鸡蛋',1397854865672679425,'d7817507-09c0-4a63-a4cc-a8eef9abb5a0.jpg',NULL,NULL,NULL,0,NULL),(1582198328760729602,'脆皮烧鹅',1397860242057375745,'546c9e25-a9b6-4de7-a17d-8baaea004a7f.jpeg',NULL,NULL,NULL,0,NULL),(1582198328953667586,'白切鸡',1397860578738352129,'4fde8d92-0db6-4538-afb3-b768ed6d4676.jpeg',NULL,NULL,NULL,0,NULL),(1582198329146605569,'烤乳猪',1397860792492666881,'f9c8c2c0-d03d-463d-9686-cf5290f024e4.jpg',NULL,NULL,NULL,0,NULL),(1582198329343737858,'脆皮乳鸽',1397860963880316929,'4dd6534f-4f59-4ba9-8aec-480626893bd3.jpeg',NULL,NULL,NULL,0,NULL),(1582198329473761282,'清蒸河鲜海鲜',1397861683434139649,'c25c850b-3ade-4fc5-b0a2-fb4f4fc3c445.jpeg',NULL,NULL,NULL,0,NULL),(1582198329540870146,'老火靓汤',1397862198033297410,'119f5fac-d610-4a5b-9af3-f8a182c9469b.jpeg',NULL,NULL,NULL,0,NULL),(1582198329603784706,'上汤焗龙虾',1397862477831122945,'84b15971-8ea8-4b68-a3f2-07ed8101b9c2.jpeg',NULL,NULL,NULL,0,NULL),(1582198329666699266,'北冰洋',1413342036832100354,'9335d9f3-3e87-4ae8-b6fc-a6b6f2b6fb9c.png',NULL,NULL,NULL,0,NULL),(1582198329738002433,'王老吉',1413384757047271425,'2b67474c-4541-4137-ae07-8cdb40752b08.jpg',NULL,NULL,NULL,0,NULL),(1582198329796722690,'米饭',1413385247889891330,'6e7c4689-6f16-4519-81db-71ce4daa1d42.png',NULL,NULL,NULL,0,NULL),(1582198329922551810,'test',1531970493397045250,'c444009c-e4de-4af3-9270-b11104dcb51e.jpg',NULL,NULL,NULL,0,NULL);

/*Table structure for table `order_detail` */

DROP TABLE IF EXISTS `order_detail`;

CREATE TABLE `order_detail` (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '名字',
  `image` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '图片',
  `order_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '订单id',
  `dish_id` bigint DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '口味',
  `number` int NOT NULL DEFAULT '1' COMMENT '数量',
  `amount` decimal(10,2) NOT NULL COMMENT '金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='订单明细表';

/*Data for the table `order_detail` */

insert  into `order_detail`(`id`,`name`,`image`,`order_id`,`dish_id`,`setmeal_id`,`dish_flavor`,`number`,`amount`) values (1585465830408257538,'邵阳猪血丸子','65d0b451-0464-41d4-8f7e-208fb4403a00.jpg','9bad282ea008443ba8fad8a2294cc5d4',1397851370462687234,NULL,NULL,1,'1000.00'),(1585465830534086658,'米饭','6e7c4689-6f16-4519-81db-71ce4daa1d42.png','9bad282ea008443ba8fad8a2294cc5d4',1413385247889891330,NULL,NULL,1,'200.00'),(1585533768444215298,'邵阳猪血丸子','65d0b451-0464-41d4-8f7e-208fb4403a00.jpg','70f7cb90d7554f6790eb03e79964e831',1397851370462687234,NULL,NULL,1,'1000.00'),(1585534920577519617,'邵阳猪血丸子','65d0b451-0464-41d4-8f7e-208fb4403a00.jpg','204f75dd74dd4ea594dadd71ea31b436',1397851370462687234,NULL,NULL,1,'1000.00'),(1585535946361671681,'口味蛇','d446b1be-b6dc-4f3e-8d01-307f755991d1.jpg','dee331d66e5646c98f18e8a40ce8d9f4',1397851668262465537,NULL,NULL,1,'1000.00');

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` bigint NOT NULL COMMENT '主键',
  `number` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '订单号',
  `status` int NOT NULL DEFAULT '1' COMMENT '订单状态 1待付款，2待派送，3已派送，4已完成',
  `user_id` bigint NOT NULL COMMENT '下单用户',
  `address_book_id` bigint NOT NULL COMMENT '地址id',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `dinner_out_time` datetime DEFAULT NULL COMMENT '商家出餐时间',
  `order_complete_time` datetime DEFAULT NULL COMMENT '用户收到餐时间',
  `checkout_time` datetime NOT NULL COMMENT '结账时间',
  `pay_method` int NOT NULL DEFAULT '1' COMMENT '支付方式 1微信,2支付宝',
  `amount` decimal(10,2) NOT NULL COMMENT '实收金额',
  `remark` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '备注',
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `consignee` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='订单表';

/*Data for the table `orders` */

insert  into `orders`(`id`,`number`,`status`,`user_id`,`address_book_id`,`order_time`,`dinner_out_time`,`order_complete_time`,`checkout_time`,`pay_method`,`amount`,`remark`,`phone`,`address`,`user_name`,`consignee`) values (1585465830601195521,'9bad282ea008443ba8fad8a2294cc5d4',2,2,1582935120157884418,'2022-10-27 10:58:05',NULL,NULL,'2022-10-27 10:58:05',1,'1200.00','xxxxxx','15181551822','四川省甘孜藏族自治州康定市四川民族学院A校区','user','邓鸿宇'),(1585533768507129858,'70f7cb90d7554f6790eb03e79964e831',2,2,1582935120157884418,'2022-10-27 15:28:03',NULL,NULL,'2022-10-27 15:28:03',1,'1000.00','xxxx','15181551822','四川省甘孜藏族自治州康定市四川民族学院A校区','user','邓鸿宇'),(1585534920640434178,'204f75dd74dd4ea594dadd71ea31b436',2,2,1582935120157884418,'2022-10-27 15:32:38',NULL,NULL,'2022-10-27 15:32:38',1,'1000.00','11111','15181551822','四川省甘孜藏族自治州康定市四川民族学院A校区','user','邓鸿宇'),(1585535946428780545,'dee331d66e5646c98f18e8a40ce8d9f4',3,2,1582935120157884418,'2022-10-27 15:36:42','2022-11-02 17:05:43',NULL,'2022-10-27 15:36:42',1,'1000.00','666','15181551822','四川省甘孜藏族自治州康定市四川民族学院A校区','user','邓鸿宇');

/*Table structure for table `product_reviews` */

DROP TABLE IF EXISTS `product_reviews`;

CREATE TABLE `product_reviews` (
  `id` bigint NOT NULL,
  `dish_id` bigint DEFAULT NULL,
  `setmeal_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `rating` int DEFAULT '1' COMMENT '1,2,3,4,5打分级别',
  `text` longtext COMMENT '用户评论',
  `image` text COMMENT '评论图片',
  `create_time` datetime DEFAULT NULL COMMENT '评论时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

/*Data for the table `product_reviews` */

insert  into `product_reviews`(`id`,`dish_id`,`setmeal_id`,`user_id`,`avatar`,`rating`,`text`,`image`,`create_time`) values (1585900970523529217,1397851370462687234,NULL,2,'6c9a602c-4c06-4e22-8a0f-bf7b2d141f2f.png',5,'xxxxxxxx','24170ae6-fc82-4aea-91fd-b28ab4891eb0.png','2022-10-28 15:47:11'),(1586190230438838273,1397851370462687234,NULL,2,'6c9a602c-4c06-4e22-8a0f-bf7b2d141f2f.png',5,'xxxxx21312123221232','2261656c-0206-4a9c-b146-5bf2e097ed5f.png','2022-10-29 10:56:36'),(1586243584485572609,1397851370462687234,NULL,2,'6c9a602c-4c06-4e22-8a0f-bf7b2d141f2f.png',4,'6666666666666','379ab2ce-dd41-47fa-bc54-d56abb96493d.png,eacc5315-6db3-48b9-ad0a-65b599168e85.png,704d29fd-2e47-4027-ae54-ca0108760a6e.png','2022-10-29 14:28:36');

/*Table structure for table `sales_volume` */

DROP TABLE IF EXISTS `sales_volume`;

CREATE TABLE `sales_volume` (
  `id` bigint NOT NULL COMMENT '主键',
  `dish_id` bigint NOT NULL COMMENT '菜品ID',
  `quantity` int DEFAULT '0' COMMENT '菜品销售量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

/*Data for the table `sales_volume` */

/*Table structure for table `setmeal` */

DROP TABLE IF EXISTS `setmeal`;

CREATE TABLE `setmeal` (
  `id` bigint NOT NULL COMMENT '主键',
  `category_id` bigint NOT NULL COMMENT '菜品分类id',
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '套餐名称',
  `review_count` int DEFAULT '0' COMMENT '评论数量',
  `sales_volume` bigint DEFAULT '0' COMMENT '销量',
  `price` decimal(10,2) NOT NULL COMMENT '套餐价格',
  `status` int DEFAULT '1' COMMENT '状态 0:停用 1:启用',
  `code` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '编码',
  `description` varchar(512) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '描述信息',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '图片',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建人',
  `update_user` bigint NOT NULL COMMENT '修改人',
  `is_deleted` int NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_setmeal_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='套餐';

/*Data for the table `setmeal` */

insert  into `setmeal`(`id`,`category_id`,`name`,`review_count`,`sales_volume`,`price`,`status`,`code`,`description`,`image`,`create_time`,`update_time`,`create_user`,`update_user`,`is_deleted`) values (1415580119015145474,1413386191767674881,'儿童套餐A计划',0,0,'4000.00',1,'','适合10岁以上儿童','62e66d51-6ea2-4515-a468-7cc3074820f8.jpg','2021-07-15 15:52:55','2022-06-07 23:07:55',1415576781934608386,1,0),(1533825387368189954,1413342269393674242,'经典四人餐',0,0,'15000.00',1,NULL,'无','88411409-305a-4073-ae1b-7b22dea47599.jpg','2022-06-06 22:57:24','2022-06-07 22:48:57',1,1,0),(1533829940146769922,1413342269393674242,'经典三人餐',0,0,'27800.00',1,NULL,'无','62e66d51-6ea2-4515-a468-7cc3074820f8.jpg','2022-06-06 23:15:29','2022-06-06 23:15:29',1,1,0);

/*Table structure for table `setmeal_dish` */

DROP TABLE IF EXISTS `setmeal_dish`;

CREATE TABLE `setmeal_dish` (
  `id` bigint NOT NULL COMMENT '主键',
  `setmeal_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '套餐id ',
  `dish_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '菜品id',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '菜品名称 （冗余字段）',
  `price` decimal(10,2) DEFAULT NULL COMMENT '菜品原价（冗余字段）',
  `copies` int NOT NULL COMMENT '份数',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建人',
  `update_user` bigint NOT NULL COMMENT '修改人',
  `is_deleted` int NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='套餐菜品关系';

/*Data for the table `setmeal_dish` */

insert  into `setmeal_dish`(`id`,`setmeal_id`,`dish_id`,`name`,`price`,`copies`,`sort`,`create_time`,`update_time`,`create_user`,`update_user`,`is_deleted`) values (1415580119052894209,'1415580119015145474','1397862198033297410','老火靓汤','49800.00',1,0,'2021-07-15 15:52:55','2022-06-07 20:33:12',1415576781934608386,1,0),(1415580119061282817,'1415580119015145474','1413342036832100354','北冰洋','500.00',1,0,'2021-07-15 15:52:55','2022-06-07 20:33:12',1415576781934608386,1,0),(1415580119069671426,'1415580119015145474','1413385247889891330','米饭','200.00',1,0,'2021-07-15 15:52:55','2022-06-07 20:33:12',1415576781934608386,1,0),(1533829940146769923,'1533829940146769922','1397849739276890114','辣子鸡','7800.00',1,0,'2022-06-06 23:15:29','2022-06-06 23:15:29',1,1,0),(1533829940146769924,'1533829940146769922','1413384757047271425','王老吉','500.00',1,0,'2022-06-06 23:15:29','2022-06-06 23:15:29',1,1,0),(1533829940146769925,'1533829940146769922','1413385247889891330','米饭','200.00',1,0,'2022-06-06 23:15:29','2022-06-06 23:15:29',1,1,0),(1533829940146769926,'1533829940146769922','1397850851245600769','霸王别姬','12800.00',1,0,'2022-06-06 23:15:29','2022-06-06 23:15:29',1,1,0);

/*Table structure for table `shopping_cart` */

DROP TABLE IF EXISTS `shopping_cart`;

CREATE TABLE `shopping_cart` (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '名称',
  `image` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '图片',
  `user_id` bigint NOT NULL COMMENT '主键',
  `dish_id` bigint DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '口味',
  `number` int NOT NULL DEFAULT '1' COMMENT '数量',
  `amount` decimal(10,2) NOT NULL COMMENT '金额',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='购物车';

/*Data for the table `shopping_cart` */

insert  into `shopping_cart`(`id`,`name`,`image`,`user_id`,`dish_id`,`setmeal_id`,`dish_flavor`,`number`,`amount`,`create_time`) values (1585909234032218114,'经典四人餐','88411409-305a-4073-ae1b-7b22dea47599.jpg',2,NULL,NULL,NULL,2,'15000.00','2022-10-28 16:24:20'),(1585910888320241666,'邵阳猪血丸子','65d0b451-0464-41d4-8f7e-208fb4403a00.jpg',2,1397851370462687234,NULL,'中辣',1,'1000.00','2022-10-28 16:26:35');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '姓名',
  `phone` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '手机号',
  `sex` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '性别',
  `id_number` varchar(18) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '身份证号',
  `avatar` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '头像',
  `status` int DEFAULT '0' COMMENT '状态 0:禁用，1:正常',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='用户信息';

/*Data for the table `user` */

insert  into `user`(`id`,`name`,`phone`,`sex`,`id_number`,`avatar`,`status`) values (1,'admin','1848761082@qq.com','0','513433200103081818',NULL,0),(2,'user','1554254032@qq.com','1','513433200103081818','6c9a602c-4c06-4e22-8a0f-bf7b2d141f2f.png',0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
