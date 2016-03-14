-- 导出 jfinalshop 的数据库结构
CREATE DATABASE IF NOT EXISTS `jfinalshop` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `jfinalshop`;
SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity` (
	`id` varchar(32) NOT NULL COMMENT '编号',
	`createDate` datetime DEFAULT NULL COMMENT '创建时间',
	`modifyDate` datetime DEFAULT NULL COMMENT '更新时间',
	`name` varchar(64) DEFAULT NULL COMMENT '名称',
	`type` varchar(32) DEFAULT NULL COMMENT '类型',
	`startTime` datetime(6) DEFAULT NULL COMMENT '开始时间',
	`endTime` datetime(6) DEFAULT NULL COMMENT '结束时间',
	`state` char(1) DEFAULT NULL COMMENT '状态',
	`maxProNum` int(11) DEFAULT NULL COMMENT '最大数量',
	`postage` decimal(10,2) DEFAULT NULL COMMENT '邮资',
	`memo` varchar(255) DEFAULT NULL COMMENT '备注',
	`bannerUrl` varchar(255) DEFAULT NULL COMMENT '图片',
	`flowUrl` varchar(255) DEFAULT NULL,
	`buyLimit` int(11) DEFAULT NULL COMMENT '限购数量',
	`isDelete` bit(1) DEFAULT b'0' COMMENT '删除状态：1=删除',
	`imageText` text COMMENT '图文信息',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
	`id` varchar(32) NOT NULL COMMENT 'ID',
	`createDate` datetime DEFAULT NULL COMMENT '建立日期',
	`modifyDate` datetime DEFAULT NULL COMMENT '修改日期',
	`department` varchar(255) DEFAULT NULL COMMENT '部门',
	`email` varchar(255) NOT NULL COMMENT 'E-mail',
	`isAccountEnabled` bit(1) NOT NULL COMMENT '账号是否启用',
	`isAccountExpired` bit(1) NOT NULL COMMENT '账号是否过期',
	`isAccountLocked` bit(1) NOT NULL COMMENT '账号是否锁定',
	`isCredentialsExpired` bit(1) NOT NULL COMMENT '凭证是否过期',
	`lockedDate` datetime DEFAULT NULL COMMENT '账号锁定日期',
	`loginDate` datetime DEFAULT NULL COMMENT '最后登录日期',
	`loginFailureCount` int(11) NOT NULL COMMENT '连续登录失败的次数',
	`loginIp` varchar(255) DEFAULT NULL COMMENT '最后登录IP',
	`name` varchar(255) DEFAULT NULL COMMENT '姓名',
	`password` varchar(255) NOT NULL COMMENT '密码',
	`username` varchar(255) NOT NULL COMMENT '用户名',
	PRIMARY KEY (`id`),
	UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for admin_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_role`;
CREATE TABLE `admin_role` (
	`adminSet_id` varchar(32) NOT NULL,
	`roleSet_id` varchar(32) NOT NULL,
	PRIMARY KEY (`adminSet_id`,`roleSet_id`),
	KEY `FK9FC63FA6DAED032` (`adminSet_id`),
	KEY `FK9FC63FA6C7B24C48` (`roleSet_id`),
	CONSTRAINT `FK9FC63FA6C7B24C48` FOREIGN KEY (`roleSet_id`) REFERENCES `role` (`id`),
	CONSTRAINT `FK9FC63FA6DAED032` FOREIGN KEY (`adminSet_id`) REFERENCES `admin` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for agreement
-- ----------------------------
DROP TABLE IF EXISTS `agreement`;
CREATE TABLE `agreement` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`content` text,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for area
-- ----------------------------
DROP TABLE IF EXISTS `area`;
CREATE TABLE `area` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`name` varchar(255) NOT NULL COMMENT '地区名称',
	`path` text,
	`parent_id` varchar(32) DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `name` (`name`,`parent_id`),
	KEY `FK1F44ADB4D9BB21` (`parent_id`),
	CONSTRAINT `FK1F44ADB4D9BB21` FOREIGN KEY (`parent_id`) REFERENCES `area` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`author` varchar(255) DEFAULT NULL,
	`content` text NOT NULL,
	`hits` int(11) NOT NULL,
	`htmlFilePath` varchar(255) DEFAULT NULL,
	`isPublication` bit(1) NOT NULL,
	`isRecommend` bit(1) NOT NULL,
	`isTop` bit(1) NOT NULL,
	`metaDescription` text,
	`metaKeywords` text,
	`pageCount` int(11) NOT NULL,
	`title` varchar(255) NOT NULL,
	`articleCategory_id` varchar(32) NOT NULL,
	PRIMARY KEY (`id`),
	KEY `FK379164D65A9A516` (`articleCategory_id`),
	CONSTRAINT `FK379164D65A9A516` FOREIGN KEY (`articleCategory_id`) REFERENCES `articlecategory` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for articlecategory
-- ----------------------------
DROP TABLE IF EXISTS `articlecategory`;
CREATE TABLE `articlecategory` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`metaDescription` text,
	`metaKeywords` text,
	`name` varchar(255) NOT NULL,
	`orderList` int(11) NOT NULL,
	`path` text,
	`parent_id` varchar(32) DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `FKC9FF4FF4AC430CA0` (`parent_id`),
	CONSTRAINT `FKC9FF4FF4AC430CA0` FOREIGN KEY (`parent_id`) REFERENCES `articlecategory` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for brand
-- ----------------------------
DROP TABLE IF EXISTS `brand`;
CREATE TABLE `brand` (
	`id` varchar(32) NOT NULL COMMENT '编号',
	`createDate` datetime DEFAULT NULL COMMENT '创建时间',
	`modifyDate` datetime DEFAULT NULL COMMENT '更新时间',
	`introduction` text COMMENT '介绍',
	`logo` varchar(255) DEFAULT NULL COMMENT '品牌图片',
	`name` varchar(255) NOT NULL COMMENT '品牌名称',
	`orderList` int(11) NOT NULL COMMENT '排序',
	`url` varchar(255) DEFAULT NULL COMMENT '链接',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cartitem
-- ----------------------------
DROP TABLE IF EXISTS `cartitem`;
CREATE TABLE `cartitem` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`quantity` int(11) NOT NULL,
	`product_id` varchar(32) NOT NULL,
	`member_id` varchar(32) NOT NULL,
	`packet_id` varchar(32) DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `FK4393E73CA10C3E` (`member_id`),
	KEY `FK4393E73F4E7D716` (`product_id`),
	KEY `FKPACKET` (`packet_id`),
	CONSTRAINT `FKPACKET` FOREIGN KEY (`packet_id`) REFERENCES `packet` (`id`),
	CONSTRAINT `FK4393E73CA10C3E` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
	CONSTRAINT `FK4393E73F4E7D716` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for deliverycorp
-- ----------------------------
DROP TABLE IF EXISTS `deliverycorp`;
CREATE TABLE `deliverycorp` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`name` varchar(255) NOT NULL,
	`orderList` int(11) NOT NULL,
	`url` varchar(255) DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for deliveryitem
-- ----------------------------
DROP TABLE IF EXISTS `deliveryitem`;
CREATE TABLE `deliveryitem` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`deliveryQuantity` int(11) NOT NULL,
	`productHtmlFilePath` varchar(255) NOT NULL,
	`productName` varchar(255) NOT NULL,
	`productSn` varchar(255) NOT NULL,
	`shipping_id` varchar(32) DEFAULT NULL,
	`product_id` varchar(32) DEFAULT NULL,
	`reship_id` varchar(32) DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `FK326C45475F5222BE` (`shipping_id`),
	KEY `FK326C4547425C301E` (`reship_id`),
	KEY `FK326C4547F4E7D716` (`product_id`),
	CONSTRAINT `FK326C4547425C301E` FOREIGN KEY (`reship_id`) REFERENCES `reship` (`id`),
	CONSTRAINT `FK326C45475F5222BE` FOREIGN KEY (`shipping_id`) REFERENCES `shipping` (`id`),
	CONSTRAINT `FK326C4547F4E7D716` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for deliverytype
-- ----------------------------
DROP TABLE IF EXISTS `deliverytype`;
CREATE TABLE `deliverytype` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`continueWeight` double NOT NULL,
	`continueWeightPrice` decimal(15,5) NOT NULL,
	`continueWeightUnit` int(11) NOT NULL,
	`deliveryMethod` int(11) NOT NULL,
	`description` text,
	`firstWeight` double NOT NULL,
	`firstWeightPrice` decimal(15,5) NOT NULL,
	`firstWeightUnit` int(11) NOT NULL,
	`name` varchar(255) NOT NULL,
	`orderList` int(11) NOT NULL,
	`defaultDeliveryCorp_id` varchar(32) DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `name` (`name`),
	KEY `FK3271596E37A10E7D` (`defaultDeliveryCorp_id`),
	CONSTRAINT `FK3271596E37A10E7D` FOREIGN KEY (`defaultDeliveryCorp_id`) REFERENCES `deliverycorp` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for deposit
-- ----------------------------
DROP TABLE IF EXISTS `deposit`;
CREATE TABLE `deposit` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`balance` decimal(19,2) NOT NULL COMMENT '当前余额',
	`credit` decimal(19,2) NOT NULL COMMENT '存入金额',
	`debit` decimal(19,2) NOT NULL COMMENT '支出金额',
	`depositType` int(11) NOT NULL COMMENT '预存款操作类型（会员充值、会员支付、后台代支付、后台代扣费、后台代充值、后台退款）',
	`member_id` varchar(32) DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `FKBFDFAE7ECA10C3E` (`member_id`),
	CONSTRAINT `FKBFDFAE7ECA10C3E` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for dicts
-- ----------------------------
DROP TABLE IF EXISTS `dicts`;
CREATE TABLE `dicts` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`dict_value` varchar(50) NOT NULL COMMENT '字段值',
	`dict_name` varchar(50) NOT NULL COMMENT '显示名称',
	`model` varchar(50) NOT NULL COMMENT '类名',
	`field` varchar(50) NOT NULL COMMENT '字段名称',
	`ext` varchar(255) DEFAULT '' COMMENT '扩展Json',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for footer
-- ----------------------------
DROP TABLE IF EXISTS `footer`;
CREATE TABLE `footer` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`content` text,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for friendlink
-- ----------------------------
DROP TABLE IF EXISTS `friendlink`;
CREATE TABLE `friendlink` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`logo` varchar(255) DEFAULT NULL,
	`name` varchar(255) NOT NULL,
	`orderList` int(11) NOT NULL,
	`url` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`actionClassName` varchar(255) NOT NULL,
	`actionMethodName` varchar(255) NOT NULL,
	`info` text,
	`ip` varchar(255) NOT NULL,
	`operationName` varchar(255) NOT NULL,
	`operator` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for logconfig
-- ----------------------------
DROP TABLE IF EXISTS `logconfig`;
CREATE TABLE `logconfig` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`actionClassName` varchar(255) NOT NULL COMMENT '需要进行日志记录的Action名称',
	`actionMethodName` varchar(255) NOT NULL COMMENT '需要进行日志记录的方法名称',
	`description` text,
	`operationName` varchar(255) NOT NULL COMMENT '操作名称',
	PRIMARY KEY (`id`),
	UNIQUE KEY `operationName` (`operationName`),
	UNIQUE KEY `actionClassName` (`actionClassName`,`actionMethodName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`deposit` decimal(15,5) NOT NULL,
	`email` varchar(255) NOT NULL,
	`isAccountEnabled` bit(1) NOT NULL,
	`isAccountLocked` bit(1) NOT NULL,
	`lockedDate` datetime DEFAULT NULL,
	`loginDate` datetime DEFAULT NULL,
	`loginFailureCount` int(11) NOT NULL,
	`loginIp` varchar(255) DEFAULT NULL,
	`password` varchar(255) NOT NULL,
	`passwordRecoverKey` varchar(255) DEFAULT NULL,
	`point` int(11) NOT NULL,
	`registerIp` varchar(255) NOT NULL,
	`safeAnswer` varchar(255) DEFAULT NULL,
	`safeQuestion` varchar(255) DEFAULT NULL,
	`username` varchar(255) NOT NULL,
	`memberRank_id` varchar(32) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `username` (`username`),
	KEY `FK892776BA60FA1EDE` (`memberRank_id`),
	CONSTRAINT `FK892776BA60FA1EDE` FOREIGN KEY (`memberRank_id`) REFERENCES `memberrank` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for memberattribute
-- ----------------------------
DROP TABLE IF EXISTS `memberattribute`;
CREATE TABLE `memberattribute` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`attributeOptionStore` varchar(255) DEFAULT NULL,
	`attributeType` int(11) NOT NULL,
	`isEnabled` bit(1) NOT NULL,
	`isRequired` bit(1) NOT NULL,
	`name` varchar(255) NOT NULL,
	`orderList` int(11) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for memberrank
-- ----------------------------
DROP TABLE IF EXISTS `memberrank`;
CREATE TABLE `memberrank` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`isDefault` bit(1) NOT NULL,
	`name` varchar(255) NOT NULL,
	`point` int(11) NOT NULL,
	`preferentialScale` double NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `name` (`name`),
	UNIQUE KEY `point` (`point`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for member_memberattributemapstore
-- ----------------------------
DROP TABLE IF EXISTS `member_memberattributemapstore`;
CREATE TABLE `member_memberattributemapstore` (
	`member_id` varchar(32) NOT NULL,
	`element` varchar(255) DEFAULT NULL,
	`mapkey_id` varchar(32) NOT NULL,
	PRIMARY KEY (`member_id`,`mapkey_id`),
	KEY `FK854979A267DDC435` (`mapkey_id`),
	KEY `FK854979A2CA10C3E` (`member_id`),
	CONSTRAINT `FK854979A267DDC435` FOREIGN KEY (`mapkey_id`) REFERENCES `memberattribute` (`id`),
	CONSTRAINT `FK854979A2CA10C3E` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for member_product
-- ----------------------------
DROP TABLE IF EXISTS `member_product`;
CREATE TABLE `member_product` (
	`favoriteMemberSet_id` varchar(32) NOT NULL,
	`favoriteProductSet_id` varchar(32) NOT NULL,
	PRIMARY KEY (`favoriteMemberSet_id`,`favoriteProductSet_id`),
	KEY `FK9460284A15D7A056` (`favoriteProductSet_id`),
	KEY `FK9460284A686A142C` (`favoriteMemberSet_id`),
	CONSTRAINT `FK9460284A15D7A056` FOREIGN KEY (`favoriteProductSet_id`) REFERENCES `product` (`id`),
	CONSTRAINT `FK9460284A686A142C` FOREIGN KEY (`favoriteMemberSet_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
	`id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
	`name` varchar(255) NOT NULL COMMENT '名称',
	`url` varchar(255) DEFAULT NULL COMMENT '访问URL',
	`icon` varchar(255) DEFAULT NULL COMMENT '图标',
	`isEnabled` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否启用： 0=禁用(false)，1=启用(true)',
	`orderList` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
	`parent_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '菜单父ID',
	`createDate` datetime DEFAULT NULL COMMENT '创建日期',
	`modifyDate` datetime DEFAULT NULL COMMENT '最后修改日期',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8 COMMENT='菜单';

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`content` text NOT NULL,
	`deleteStatus` int(11) NOT NULL,
	`isRead` bit(1) NOT NULL,
	`isSaveDraftbox` bit(1) NOT NULL,
	`title` varchar(255) NOT NULL,
	`fromMember_id` varchar(32) DEFAULT NULL,
	`toMember_id` varchar(32) DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `FK9C2397E7145FF3D4` (`fromMember_id`),
	KEY `FK9C2397E7701A1823` (`toMember_id`),
	CONSTRAINT `FK9C2397E7145FF3D4` FOREIGN KEY (`fromMember_id`) REFERENCES `member` (`id`),
	CONSTRAINT `FK9C2397E7701A1823` FOREIGN KEY (`toMember_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for navigation
-- ----------------------------
DROP TABLE IF EXISTS `navigation`;
CREATE TABLE `navigation` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`isBlankTarget` bit(1) NOT NULL,
	`isVisible` bit(1) NOT NULL,
	`name` varchar(255) NOT NULL,
	`orderList` int(11) NOT NULL,
	`position` int(11) NOT NULL,
	`url` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for orderitem
-- ----------------------------
DROP TABLE IF EXISTS `orderitem`;
CREATE TABLE `orderitem` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`deliveryQuantity` int(11) NOT NULL,
	`productHtmlFilePath` varchar(255) NOT NULL,
	`productName` varchar(255) NOT NULL,
	`productPrice` decimal(15,5) NOT NULL,
	`productQuantity` int(11) NOT NULL,
	`productSn` varchar(255) NOT NULL,
	`totalDeliveryQuantity` int(11) NOT NULL,
	`order_id` varchar(32) NOT NULL,
	`product_id` varchar(32) DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `FK60163F613F4585B6` (`order_id`),
	KEY `FK60163F61F4E7D716` (`product_id`),
	CONSTRAINT `FK60163F613F4585B6` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
	CONSTRAINT `FK60163F61F4E7D716` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for orderlog
-- ----------------------------
DROP TABLE IF EXISTS `orderlog`;
CREATE TABLE `orderlog` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`info` text,
	`operator` varchar(255) DEFAULT NULL,
	`orderLogType` int(11) NOT NULL,
	`orderSn` varchar(255) NOT NULL,
	`order_id` varchar(32) NOT NULL,
	PRIMARY KEY (`id`),
	KEY `FK4D6C1D363F4585B6` (`order_id`),
	CONSTRAINT `FK4D6C1D363F4585B6` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`deliveryFee` decimal(15,5) NOT NULL,
	`deliveryTypeName` varchar(255) NOT NULL,
	`memo` text,
	`orderSn` varchar(255) NOT NULL,
	`orderStatus` int(11) NOT NULL,
	`paidAmount` decimal(15,5) NOT NULL,
	`paymentConfigName` varchar(255) NOT NULL,
	`paymentFee` decimal(15,5) NOT NULL,
	`paymentStatus` int(11) NOT NULL,
	`productTotalPrice` decimal(15,5) NOT NULL,
	`productTotalQuantity` int(11) NOT NULL,
	`productWeight` double NOT NULL,
	`productWeightUnit` int(11) NOT NULL,
	`shipAddress` varchar(255) NOT NULL,
	`shipArea` varchar(255) NOT NULL,
	`shipAreaPath` varchar(255) DEFAULT NULL,
	`shipMobile` varchar(255) DEFAULT NULL,
	`shipName` varchar(255) NOT NULL,
	`shipPhone` varchar(255) DEFAULT NULL,
	`shipZipCode` varchar(255) NOT NULL,
	`shippingStatus` int(11) NOT NULL,
	`totalAmount` decimal(15,5) NOT NULL,
	`member_id` varchar(32) DEFAULT NULL,
	`deliveryType_id` varchar(32) DEFAULT NULL,
	`paymentConfig_id` varchar(32) DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `orderSn` (`orderSn`),
	KEY `FKC3DF62E5CA10C3E` (`member_id`),
	KEY `FKC3DF62E590BFCB96` (`paymentConfig_id`),
	KEY `FKC3DF62E5FAD364DE` (`deliveryType_id`),
	CONSTRAINT `FKC3DF62E590BFCB96` FOREIGN KEY (`paymentConfig_id`) REFERENCES `paymentconfig` (`id`),
	CONSTRAINT `FKC3DF62E5CA10C3E` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
	CONSTRAINT `FKC3DF62E5FAD364DE` FOREIGN KEY (`deliveryType_id`) REFERENCES `deliverytype` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for packet
-- ----------------------------
DROP TABLE IF EXISTS `packet`;
CREATE TABLE `packet` (
	`id` varchar(32) NOT NULL COMMENT '编号',
	`createDate` datetime DEFAULT NULL COMMENT '创建时间',
	`modifyDate` datetime DEFAULT NULL COMMENT '更新时间',
	`name` varchar(128) DEFAULT NULL COMMENT '名称',
	`description` varchar(255) DEFAULT NULL COMMENT '描述',
	`img` text COMMENT '图片',
	`state` int(11) DEFAULT '0' COMMENT '状态',
	`maxBuy` int(11) DEFAULT NULL COMMENT '最大购买量',
	`seq` int(10) DEFAULT NULL COMMENT '排序',
	`operator` varchar(255) DEFAULT NULL COMMENT '操作者',
	`isDelete` bit(1) DEFAULT b'0' COMMENT '是否删除：1=删除',
	`disPercent` int(10) DEFAULT NULL COMMENT '折扣百分比',
	`disAmount` int(10) DEFAULT NULL COMMENT '折扣金额',
	`shelf_id` varchar(32) DEFAULT NULL COMMENT '货架ID',
	`productCategory_id` varchar(32) DEFAULT NULL COMMENT '商品分类ID',
	`imageText` text COMMENT '图文信息',
	`price` decimal(15,5) DEFAULT NULL COMMENT '价格',
	`isMultiple` bit(1) DEFAULT b'0' COMMENT '是否有多个商品',
	PRIMARY KEY (`id`),
	KEY `FK_SHELF_PACKET` (`shelf_id`),
	CONSTRAINT `FK_SHELF_PACKET` FOREIGN KEY (`shelf_id`) REFERENCES `shelf` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for packetproductmap
-- ----------------------------
DROP TABLE IF EXISTS `packetproductmap`;
CREATE TABLE `packetproductmap` (
	`id` varchar(32) NOT NULL COMMENT '编号',
	`createDate` datetime DEFAULT NULL COMMENT '创建时间',
	`modifyDate` datetime DEFAULT NULL COMMENT '更新时间',
	`productName` varchar(512) DEFAULT NULL COMMENT '商品名称',
	`productDesc` varchar(512) DEFAULT NULL COMMENT '商品描述',
	`price` decimal(10,5) DEFAULT NULL COMMENT '价格',
	`promotionPrice` decimal(10,5) DEFAULT NULL COMMENT '推广价',
	`num` int(11) DEFAULT NULL COMMENT '数量',
	`seq` int(10) DEFAULT NULL COMMENT '排序',
	`operator` varchar(255) DEFAULT NULL COMMENT '操作者',
	`isDelete` bit(1) DEFAULT b'0' COMMENT '是否删除',
	`packet_id` varchar(32) NOT NULL COMMENT '商品包ID',
	`product_id` varchar(32) NOT NULL COMMENT '商品ID',
	PRIMARY KEY (`id`),
	KEY `FK_PACKET_PRODUCT_MAP` (`packet_id`),
	KEY `FK_PRODUCT_PACKET_MAP` (`product_id`),
	CONSTRAINT `FK_PACKET_PRODUCT_MAP` FOREIGN KEY (`packet_id`) REFERENCES `packet` (`id`),
	CONSTRAINT `FK_PRODUCT_PACKET_MAP` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`bankAccount` varchar(255) DEFAULT NULL,
	`bankName` varchar(255) DEFAULT NULL,
	`memo` text,
	`operator` varchar(255) DEFAULT NULL,
	`payer` varchar(255) NOT NULL,
	`paymentConfigName` varchar(255) NOT NULL,
	`paymentFee` decimal(15,5) NOT NULL,
	`paymentSn` varchar(255) NOT NULL,
	`paymentStatus` int(11) NOT NULL,
	`paymentType` int(11) NOT NULL,
	`totalAmount` decimal(15,5) NOT NULL,
	`deposit_id` varchar(32) DEFAULT NULL,
	`order_id` varchar(32) DEFAULT NULL,
	`paymentConfig_id` varchar(32) DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `paymentSn` (`paymentSn`),
	KEY `FK3454C9E613C6C4B6` (`deposit_id`),
	KEY `FK3454C9E690BFCB96` (`paymentConfig_id`),
	KEY `FK3454C9E63F4585B6` (`order_id`),
	CONSTRAINT `FK3454C9E613C6C4B6` FOREIGN KEY (`deposit_id`) REFERENCES `deposit` (`id`),
	CONSTRAINT `FK3454C9E63F4585B6` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
	CONSTRAINT `FK3454C9E690BFCB96` FOREIGN KEY (`paymentConfig_id`) REFERENCES `paymentconfig` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for paymentconfig
-- ----------------------------
DROP TABLE IF EXISTS `paymentconfig`;
CREATE TABLE `paymentconfig` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`configObjectStore` varchar(255) DEFAULT NULL,
	`description` text,
	`name` varchar(255) NOT NULL,
	`orderList` int(11) NOT NULL,
	`paymentConfigType` int(11) NOT NULL,
	`paymentFee` decimal(15,5) DEFAULT NULL,
	`paymentFeeType` int(11) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
	`id` varchar(32) NOT NULL COMMENT '编号',
	`createDate` datetime DEFAULT NULL COMMENT '创建时间',
	`modifyDate` datetime DEFAULT NULL COMMENT '更新时间',
	`description` text COMMENT '描述',
	`freezeStore` int(11) NOT NULL  COMMENT '冻结库存',
	`htmlFilePath` varchar(255) NOT NULL COMMENT 'HTML页面路径',
	`isBest` bit(1) NOT NULL COMMENT '是否精品:false=否，true=是',
	`isHot` bit(1) NOT NULL COMMENT '是否热销:false=否，true=是',
	`isMarketable` bit(1) NOT NULL COMMENT '是否上架:false=下架，true=上架',
	`isNew` bit(1) NOT NULL COMMENT '是否新品:false=否，true=是',
	`marketPrice` decimal(15,5) NOT NULL COMMENT '市场价',
	`metaDescription` text COMMENT '页面描述',
	`metaKeywords` text COMMENT '关键字',
	`name` varchar(255) NOT NULL COMMENT '名称',
	`point` int(11) NOT NULL COMMENT '积分',
	`price` decimal(15,5) NOT NULL COMMENT '价格',
	`productImageListStore` text COMMENT '图片列表',
	`productSn` varchar(255) NOT NULL COMMENT '商品编码',
	`store` int(11) DEFAULT NULL COMMENT '库存',
	`weight` double NOT NULL COMMENT '重量',
	`weightUnit` int(11) NOT NULL COMMENT '重量单位',
	`brand_id` varchar(32) DEFAULT NULL COMMENT '品牌ID',
	`productCategory_id` varchar(32) NOT NULL COMMENT '商品分类ID',
	`productType_id` varchar(32) DEFAULT NULL COMMENT '商品类型ID',
	`isDelete` bit(1) DEFAULT b'0' COMMENT '是否删除',
	PRIMARY KEY (`id`),
	UNIQUE KEY `productSn` (`productSn`),
	KEY `FK50C664CF738B3AF6` (`productType_id`),
	KEY `FK50C664CF59CF1676` (`productCategory_id`),
	KEY `FK50C664CFF378EF16` (`brand_id`),
	CONSTRAINT `FK50C664CF59CF1676` FOREIGN KEY (`productCategory_id`) REFERENCES `productcategory` (`id`),
	CONSTRAINT `FK50C664CF738B3AF6` FOREIGN KEY (`productType_id`) REFERENCES `producttype` (`id`),
	CONSTRAINT `FK50C664CFF378EF16` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for productattribute
-- ----------------------------
DROP TABLE IF EXISTS `productattribute`;
CREATE TABLE `productattribute` (
	`id` varchar(32) NOT NULL COMMENT '编号',
	`createDate` datetime DEFAULT NULL COMMENT '创建时间',
	`modifyDate` datetime DEFAULT NULL COMMENT '更新时间',
	`attributeOptionStore` varchar(255) DEFAULT NULL,
	`attributeType` int(11) NOT NULL COMMENT '属性类型',
	`isEnabled` bit(1) NOT NULL COMMENT '是否启用',
	`isRequired` bit(1) NOT NULL COMMENT '是否必须',
	`name` varchar(255) NOT NULL COMMENT '名称',
	`orderList` int(11) NOT NULL COMMENT '排序',
	`productType_id` varchar(32) NOT NULL COMMENT '商品类型ID',
	PRIMARY KEY (`id`),
	UNIQUE KEY `name` (`name`,`productType_id`),
	KEY `FKDDC65E8D738B3AF6` (`productType_id`),
	CONSTRAINT `FKDDC65E8D738B3AF6` FOREIGN KEY (`productType_id`) REFERENCES `producttype` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for productcategory
-- ----------------------------
DROP TABLE IF EXISTS `productcategory`;
CREATE TABLE `productcategory` (
	`id` varchar(32) NOT NULL COMMENT '编号',
	`createDate` datetime DEFAULT NULL COMMENT '创建时间',
	`modifyDate` datetime DEFAULT NULL COMMENT '更新时间',
	`metaDescription` text COMMENT '页面描述',
	`metaKeywords` text COMMENT '关键字',
	`name` varchar(255) NOT NULL COMMENT '名称',
	`orderList` int(11) NOT NULL COMMENT '排序',
	`path` text COMMENT '根到子的路径',
	`parent_id` varchar(32) DEFAULT NULL COMMENT '父亲ID',
	PRIMARY KEY (`id`),
	KEY `FKD05546EDB2990399` (`parent_id`),
	CONSTRAINT `FKD05546EDB2990399` FOREIGN KEY (`parent_id`) REFERENCES `productcategory` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for producttype
-- ----------------------------
DROP TABLE IF EXISTS `producttype`;
CREATE TABLE `producttype` (
	`id` varchar(32) NOT NULL COMMENT '编号',
	`createDate` datetime DEFAULT NULL COMMENT '创建时间',
	`modifyDate` datetime DEFAULT NULL COMMENT '更新时间',
	`name` varchar(255) NOT NULL  COMMENT '名称',
	PRIMARY KEY (`id`),
	UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for product_productattributemapstore
-- ----------------------------
DROP TABLE IF EXISTS `product_productattributemapstore`;
CREATE TABLE `product_productattributemapstore` (
	`product_id` varchar(32) NOT NULL COMMENT '商品ID',
	`element` varchar(255) DEFAULT NULL COMMENT '元素',
	`mapkey_id` varchar(32) NOT NULL COMMENT '属性ID',
	PRIMARY KEY (`product_id`,`mapkey_id`),
	KEY `FK7B6203E2B1184188` (`mapkey_id`),
	KEY `FK7B6203E2F4E7D716` (`product_id`),
	CONSTRAINT `FK7B6203E2F4E7D716` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for receiver
-- ----------------------------
DROP TABLE IF EXISTS `receiver`;
CREATE TABLE `receiver` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`address` text NOT NULL,
	`areaPath` text NOT NULL,
	`isDefault` bit(1) NOT NULL,
	`mobile` varchar(255) DEFAULT NULL,
	`name` varchar(255) NOT NULL,
	`phone` varchar(255) DEFAULT NULL,
	`zipCode` varchar(255) NOT NULL,
	`member_id` varchar(32) NOT NULL,
	PRIMARY KEY (`id`),
	KEY `FKD3A64E0FCA10C3E` (`member_id`),
	CONSTRAINT `FKD3A64E0FCA10C3E` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for refund
-- ----------------------------
DROP TABLE IF EXISTS `refund`;
CREATE TABLE `refund` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`bankAccount` varchar(255) DEFAULT NULL,
	`bankName` varchar(255) DEFAULT NULL,
	`memo` text,
	`operator` varchar(255) DEFAULT NULL,
	`payee` varchar(255) NOT NULL,
	`paymentConfigName` varchar(255) NOT NULL,
	`refundSn` varchar(255) NOT NULL,
	`refundType` int(11) NOT NULL,
	`totalAmount` decimal(15,5) NOT NULL,
	`deposit_id` varchar(32) DEFAULT NULL,
	`order_id` varchar(32) DEFAULT NULL,
	`paymentConfig_id` varchar(32) DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `refundSn` (`refundSn`),
	KEY `FK91ACCB9813C6C4B6` (`deposit_id`),
	KEY `FK91ACCB9890BFCB96` (`paymentConfig_id`),
	KEY `FK91ACCB983F4585B6` (`order_id`),
	CONSTRAINT `FK91ACCB9813C6C4B6` FOREIGN KEY (`deposit_id`) REFERENCES `deposit` (`id`),
	CONSTRAINT `FK91ACCB983F4585B6` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
	CONSTRAINT `FK91ACCB9890BFCB96` FOREIGN KEY (`paymentConfig_id`) REFERENCES `paymentconfig` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for reship
-- ----------------------------
DROP TABLE IF EXISTS `reship`;
CREATE TABLE `reship` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`deliveryCorpName` varchar(255) NOT NULL,
	`deliveryFee` decimal(19,2) NOT NULL,
	`deliverySn` varchar(255) DEFAULT NULL,
	`deliveryTypeName` varchar(255) NOT NULL,
	`memo` varchar(255) DEFAULT NULL,
	`reshipSn` varchar(255) NOT NULL,
	`shipAddress` varchar(255) NOT NULL,
	`shipArea` varchar(255) NOT NULL,
	`shipAreaPath` varchar(255) DEFAULT NULL,
	`shipMobile` varchar(255) DEFAULT NULL,
	`shipName` varchar(255) NOT NULL,
	`shipPhone` varchar(255) DEFAULT NULL,
	`shipZipCode` varchar(255) NOT NULL,
	`order_id` varchar(32) DEFAULT NULL,
	`deliveryType_id` varchar(32) DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `reshipSn` (`reshipSn`),
	KEY `FK91B2830F3F4585B6` (`order_id`),
	KEY `FK91B2830FFAD364DE` (`deliveryType_id`),
	CONSTRAINT `FK91B2830F3F4585B6` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
	CONSTRAINT `FK91B2830FFAD364DE` FOREIGN KEY (`deliveryType_id`) REFERENCES `deliverytype` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for resource
-- ----------------------------
DROP TABLE IF EXISTS `resource`;
CREATE TABLE `resource` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`description` text,
	`isSystem` bit(1) NOT NULL,
	`name` varchar(255) NOT NULL,
	`orderList` int(11) NOT NULL,
	`value` varchar(255) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `name` (`name`),
	UNIQUE KEY `value` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`description` text,
	`isSystem` bit(1) NOT NULL,
	`name` varchar(255) NOT NULL,
	`value` varchar(255) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `name` (`name`),
	UNIQUE KEY `value` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for role_resource
-- ----------------------------
DROP TABLE IF EXISTS `role_resource`;
CREATE TABLE `role_resource` (
	`roleSet_id` varchar(32) NOT NULL,
	`resourceSet_id` varchar(32) NOT NULL,
	PRIMARY KEY (`roleSet_id`,`resourceSet_id`),
	KEY `FKE25F2DB7C7B24C48` (`roleSet_id`),
	KEY `FKE25F2DB75BD93F78` (`resourceSet_id`),
	CONSTRAINT `FKE25F2DB75BD93F78` FOREIGN KEY (`resourceSet_id`) REFERENCES `resource` (`id`),
	CONSTRAINT `FKE25F2DB7C7B24C48` FOREIGN KEY (`roleSet_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shelf
-- ----------------------------
DROP TABLE IF EXISTS `shelf`;
CREATE TABLE `shelf` (
	`id` varchar(32) NOT NULL COMMENT '编号',
	`createDate` datetime DEFAULT NULL COMMENT '创建时间',
	`modifyDate` datetime DEFAULT NULL COMMENT '更新时间',
	`name` varchar(128) DEFAULT NULL COMMENT '名称',
	`type` varchar(32) DEFAULT NULL COMMENT '类型',
	`channelCode` bigint(20) DEFAULT NULL COMMENT '门店',
	`description` varchar(512) DEFAULT NULL COMMENT '描述',
	`img` varchar(512) DEFAULT NULL COMMENT '图片',
	`startTime` datetime(6) DEFAULT NULL COMMENT '开始时间',
	`endTime` datetime(6) DEFAULT NULL COMMENT '结束时间',
	`state` int(11) DEFAULT '1' COMMENT '状态',
	`isHaveSub` bit(1) DEFAULT NULL COMMENT '是否有子',
	`parentSectionid` bigint(20) DEFAULT NULL COMMENT '父亲ID',
	`maxBuy` int(11) DEFAULT NULL COMMENT '最大购买数量',
	`seq` int(10) DEFAULT NULL COMMENT '排序',
	`operator` varchar(255) DEFAULT NULL COMMENT '操作者',
	`isDelete` bit(1) DEFAULT b'0' COMMENT '是否删除',
	`shelflink` varchar(256) DEFAULT NULL,
	`activity_id` varchar(32) DEFAULT NULL COMMENT '活动ID',
	`imageText` text COMMENT '图文信息',
	`packetNum` int(10) DEFAULT '0' COMMENT '包数量',
	PRIMARY KEY (`id`),
	KEY `FK_ACTIVITY_SHELF` (`activity_id`),
	CONSTRAINT `FK_ACTIVITY_SHELF` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shipping
-- ----------------------------
DROP TABLE IF EXISTS `shipping`;
CREATE TABLE `shipping` (
	`id` varchar(32) NOT NULL,
	`createDate` datetime DEFAULT NULL,
	`modifyDate` datetime DEFAULT NULL,
	`deliveryCorpName` varchar(255) NOT NULL,
	`deliveryFee` decimal(19,2) NOT NULL,
	`deliverySn` varchar(255) DEFAULT NULL,
	`deliveryTypeName` varchar(255) NOT NULL,
	`memo` varchar(255) DEFAULT NULL,
	`shipAddress` varchar(255) NOT NULL,
	`shipArea` varchar(255) NOT NULL,
	`shipAreaPath` varchar(255) DEFAULT NULL,
	`shipMobile` varchar(255) DEFAULT NULL,
	`shipName` varchar(255) NOT NULL,
	`shipPhone` varchar(255) DEFAULT NULL,
	`shipZipCode` varchar(255) NOT NULL,
	`shippingSn` varchar(255) NOT NULL,
	`deliveryType_id` varchar(32) DEFAULT NULL,
	`order_id` varchar(32) DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `shippingSn` (`shippingSn`),
	KEY `FKE51541CE3F4585B6` (`order_id`),
	KEY `FKE51541CEFAD364DE` (`deliveryType_id`),
	CONSTRAINT `FKE51541CE3F4585B6` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
	CONSTRAINT `FKE51541CEFAD364DE` FOREIGN KEY (`deliveryType_id`) REFERENCES `deliverytype` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*数据字典*/
DROP TABLE IF EXISTS `dicts`;
CREATE TABLE IF NOT EXISTS `dicts` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`dict_value` varchar(50) NOT NULL COMMENT '字段值',
	`dict_name` varchar(50) NOT NULL COMMENT '显示名称',
	`model` varchar(50) NOT NULL COMMENT 'model名',
	`field` varchar(50) NOT NULL COMMENT '字段名称',
	`ext` varchar(255) DEFAULT '' COMMENT '扩展Json',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

/*字段映射表*/
DROP TABLE IF EXISTS `displaymapping`;
CREATE TABLE IF NOT EXISTS `displaymapping` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`display` varchar(50) NOT NULL COMMENT '显示名称',
	`model` varchar(50) NOT NULL COMMENT 'model名',
	`field` varchar(50) NOT NULL COMMENT '字段名称',
	`ext` varchar(255) DEFAULT '' COMMENT '扩展Json',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;
-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('8a8a05d94739522101473956e6c90002', '2014-12-29 11:27:01', '2016-02-16 10:08:57', '技术部', 'admin@163.com', '', '\0', '\0', '\0', '2014-12-29 11:35:13', '2016-02-16 10:08:57', '0', '0:0:0:0:0:0:0:1', 'dextrys', 'e10adc3949ba59abbe56e057f20f883e', 'admin');
INSERT INTO `admin` VALUES ('b78fce506d4a430592593bec9a09a813', '2016-01-07 17:39:08', '2016-01-12 17:54:23', '技术部', 'jack.zhou@dextrys.com', '', '\0', '\0', '\0', null, '2016-01-12 17:54:23', '0', '0:0:0:0:0:0:0:1', '周剑', 'fcd89fadf15d68e963404e3c5d2059e3', 'jack');
-- ----------------------------
-- Records of admin_role
-- ----------------------------
INSERT INTO `admin_role` VALUES ('8a8a05d94739522101473956e6c90002', '402881862bec2a21012bec2b70510002');
INSERT INTO `admin_role` VALUES ('b78fce506d4a430592593bec9a09a813', '402881862bec2a21012bec2b70510002');
-- ----------------------------
-- Records of agreement
-- ----------------------------
INSERT INTO `agreement` VALUES ('1', '1899-12-30 01:00:00', '1899-12-30 01:00:00', '<p><strong>注册条款<br /></strong></p>\r\n<p>&nbsp;</p>\r\n<p>尊敬的用户，欢迎您注册成为本网站会员。请用户仔细阅读以下全部内容。如用户不同意本服务条款任意内容，请不要注册或 使用本网站服务。如用户通过进入注册程序并勾选&ldquo;我同意服务条款&rdquo;，即表示用户与本网站已达成协议，自愿接受本 服务条款的所有内容。此后，用户不得以未阅读本服务条款内容作任何形式的抗辩。</p>\r\n<p>&nbsp;</p>\r\n<p>一、&nbsp;本站服务条款的确认和接纳<br />本网站涉及的各项服务的所有权和运作权归本网站所有。本网站所提供的服务必 须按照其发布的服务条款和操作规则严格执行。本服务条款的效力范围及于本网站的一切产品和服务，用户在享受本网站的任何服 务时，应当受本服务条款的约束。</p>\r\n<p>&nbsp;</p>\r\n<p>二、&nbsp;服务简介<br />本网站运用自己的操作系统通过国际互联网络为用户提供各项服务。用户必须：<br />1.&nbsp;提 供设备，如个人电脑、手机或其他上网设备。<br />2.&nbsp;个人上网和支付与此服务有关的费用。</p>\r\n<p>&nbsp;</p>\r\n<p>三、&nbsp;用户在不得在本网站上发布下列违法信息<br />1.&nbsp;反对宪法所确定的基本原则的；<br />2.&nbsp;危害国家 安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；<br />3.&nbsp;损害国家荣誉和利益的；<br />4.&nbsp;煽动民族仇恨、 民族歧视，破坏民族团结的；<br />5.&nbsp;破坏国家宗教政策，宣扬邪教和封建迷信的；<br />6.&nbsp;散布谣言，扰乱社会秩 序，破坏社会稳定的；<br />7.&nbsp;散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的；<br />8.&nbsp;侮辱或者诽谤 他人，侵害他人合法权益的；<br />9.&nbsp;含有法律、行政法规禁止的其他内容的。</p>\r\n<p>&nbsp;</p>\r\n<p>四、&nbsp;有关个人资料<br />用户同意：<br />1.&nbsp;提供及时、详尽及准确的个人资料。<br />2.&nbsp;同意接收来自 本网站的信息。<br />3.&nbsp;不断更新注册资料，符合及时、详尽准确的要求。所有原始键入的资料将引用为注册资料。<br />4.&nbsp;本网站不公开用户的姓名、地址、电子邮箱和笔名。除以下情况外：<br />a)&nbsp;用户授权本站透露这些信息。 <br />b)&nbsp;相应的法律及程序要求本站提供用户的个人资料。</p>\r\n<p>&nbsp;</p>\r\n<p>五、&nbsp;服务条款的修改<br />本网站有权在必要时修改服务条款，一旦条款及服务内容产生变动，本网站将会在重要页面 上提示修改内容。如果不同意所改动的内容，用户可以主动取消获得的本网站信息服务。如果用户继续享用本网站信息服务，则视 为接受服务条款的变动。<br /><br />六、&nbsp;用户隐私制度<br />尊重用户个人隐私是本网站的一项基本政策。所以，本网站 一定不会在未经合法用户授权时公开、编辑或透露其注册资料及保存在本网站中的非公开内容，除非有法律许可要求或本网站在诚 信的基础上认为透露这些信息在以下四种情况是必要的：<br />1.&nbsp;遵守有关法律规定，遵从本网站合法服务程序。<br />2.&nbsp;保持维护本网站的商标所有权。<br />3.&nbsp;在紧急情况下竭力维护用户个人和社会大众的隐私安全。<br />4.&nbsp;符合其他相关的要求。</p>\r\n<p>&nbsp;</p>\r\n<p>七、&nbsp;用户的帐号、密码和安全性<br />用户一旦注册成功，将获得一个密码和用户名。用户需谨慎合理的保存、使用用 户名和密码。如果你不保管好自己的帐号和密码安全，将负全部责任。另外，每个用户都要对其帐户中的所有活动和事件负全责。 你可随时根据指示改变你的密码。用户若发现任何非法使用用户帐号或存在安全漏洞的情况，请立即通告本网站。</p>\r\n<p>&nbsp;</p>\r\n<p>八、&nbsp;拒绝提供担保<br />用户明确同意信息服务的使用由用户个人承担风险。 本网站不担保服务不会受中断，对服务的 及时性，安全性，出错发生都不作担保，但会在能力范围内，避免出错。</p>\r\n<p>&nbsp;</p>\r\n<p>九、&nbsp;有限责任<br />如因不可抗力或其它本站无法控制的原因使本站销售系统崩溃或无法正常使用导致网上交易无法完 成或丢失有关的信息、记录等本站会尽可能合理地协助处理善后事宜，并努力使客户免受经济损失，同时会尽量避免这种损害的发 生。</p>\r\n<p>&nbsp;</p>\r\n<p>十、&nbsp;用户信息的储存和限制<br />本站有判定用户的行为是否符合国家法律法规规定及本站服务条款权利，如果用户违 背本网站服务条款的规定，本网站有权中断对其提供服务的权利。</p>\r\n<p>&nbsp;</p>\r\n<p>十一、&nbsp;用户管理<br />用户单独承担发布内容的责任。用户对服务的使用是根据所有适用于本站的国家法律、地方法律 和国际法律标准的。用户必须遵循：<br />1.&nbsp;使用网络服务不作非法用途。 <br />2.&nbsp;不干扰或混乱网络服务。 <br />3.&nbsp;遵守所有使用网络服务的网络协议、规定、程序和惯例。 <br />用户须承诺不传输任何非法的、骚扰性的、中伤他人 的、辱骂性的、恐性的、伤害性的、庸俗的，淫秽等信息资料。另外，用户也不能传输何教唆他人构成犯罪行为的资料；不能传输 助长国内不利条件和涉及国家安全的资料；不能传输任何不符合当地法规、国家法律和国际法律的资料。未经许可而非法进入其它 电脑系统是禁止的。<br />若用户的行为不符合以上提到的服务条款，本站将作出独立判断立即取消用户服务帐号。用户需对自己 在网上的行为承担法律责任。用户若在本站上散布和传播反动、色情或其它违反国家法律的信息，本站的系统记录有可能作为用户 违反法律的证据。</p>\r\n<p>&nbsp;</p>\r\n<p>十二、&nbsp;通告<br />所有发给用户的通告都可通过重要页面的公告或电子邮件或常规的信件传送。服务条款的修改、服务 变更、或其它重要事件的通告都会以此形式进行。</p>\r\n<p>&nbsp;</p>\r\n<p>十三、&nbsp;信息内容的所有权<br />本网站定义的信息内容包括：文字、软件、声音、相片、录象、图表；在广告中全部内 容；本网站为用户提供的其它信息。所有这些内容受版权、商标、标签和其它财产所有权法律的保护。所以，用户只能在本网站和 广告商授权下才能使用这些内容，而不能擅自复制、再造这些内容、或创造与内容有关的派生产品。本站所有的文章版权归原文作 者和本站共同所有，任何人需要转载本站的文章，必须征得原文作者或本站授权。</p>\r\n<p>&nbsp;</p>\r\n<p>十四、&nbsp;法律<br />本协议的订立、执行和解释及争议的解决均应适用中华人民共和国的法律。用户和本网站一致同意服 从本网站所在地有管辖权的法院管辖。如发生本网站服务条款与中华人民共和国法律相抵触时，则这些条款将完全按法律规定重新 解释，而其它条款则依旧保持对用户的约束力。<br /><br /><strong>说明：本条款为SHOP++体验商城示范性内容，只限于演示使用，不具备任何其它效力。</strong></p>');
-- ----------------------------
-- Records of area
-- ----------------------------
INSERT INTO `area` VALUES ('34e353b3165246dbaa7034c437978737', '2014-11-19 15:35:52', null, 'dfsd', '402881882ba8753a012ba8cd6a230067,402881882ba8753a012ba8cea18a006d,34e353b3165246dbaa7034c437978737', '402881882ba8753a012ba8cea18a006d');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8bf474d001c', '2010-10-14 11:18:49', '2015-01-07 15:10:12', '北京', '402881882ba8753a012ba8bf474d001c', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba8bfacfd001d', '2010-10-14 11:19:15', '2015-01-07 15:10:29', '东城区', '402881882ba8753a012ba8bf474d001c,402881882ba8753a012ba8bfacfd001d', '402881882ba8753a012ba8bf474d001c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8bff6f6001e', '2010-10-14 11:19:34', '2010-10-14 11:19:34', '西城区', '402881882ba8753a012ba8bf474d001c,402881882ba8753a012ba8bff6f6001e', '402881882ba8753a012ba8bf474d001c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c02f9a001f', '2010-10-14 11:19:48', '2010-10-14 11:19:48', '崇文区', '402881882ba8753a012ba8bf474d001c,402881882ba8753a012ba8c02f9a001f', '402881882ba8753a012ba8bf474d001c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c061970020', '2010-10-14 11:20:01', '2010-10-14 11:20:01', '宣武区', '402881882ba8753a012ba8bf474d001c,402881882ba8753a012ba8c061970020', '402881882ba8753a012ba8bf474d001c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c088690021', '2010-10-14 11:20:11', '2010-10-14 11:20:11', '朝阳区', '402881882ba8753a012ba8bf474d001c,402881882ba8753a012ba8c088690021', '402881882ba8753a012ba8bf474d001c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c0ade20022', '2010-10-14 11:20:21', '2010-10-14 11:20:21', '丰台区', '402881882ba8753a012ba8bf474d001c,402881882ba8753a012ba8c0ade20022', '402881882ba8753a012ba8bf474d001c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c0d34c0023', '2010-10-14 11:20:30', '2010-10-14 11:20:30', '石景山区', '402881882ba8753a012ba8bf474d001c,402881882ba8753a012ba8c0d34c0023', '402881882ba8753a012ba8bf474d001c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c0fb850024', '2010-10-14 11:20:41', '2010-10-14 11:20:41', '海淀区', '402881882ba8753a012ba8bf474d001c,402881882ba8753a012ba8c0fb850024', '402881882ba8753a012ba8bf474d001c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c121f90025', '2010-10-14 11:20:50', '2010-10-14 11:20:50', '门头沟区', '402881882ba8753a012ba8bf474d001c,402881882ba8753a012ba8c121f90025', '402881882ba8753a012ba8bf474d001c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c1463a0026', '2010-10-14 11:21:00', '2010-10-14 11:21:00', '房山区', '402881882ba8753a012ba8bf474d001c,402881882ba8753a012ba8c1463a0026', '402881882ba8753a012ba8bf474d001c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c16f8c0027', '2010-10-14 11:21:10', '2010-10-14 11:21:10', '通州区', '402881882ba8753a012ba8bf474d001c,402881882ba8753a012ba8c16f8c0027', '402881882ba8753a012ba8bf474d001c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c19cb70028', '2010-10-14 11:21:22', '2010-10-14 11:21:22', '顺义区', '402881882ba8753a012ba8bf474d001c,402881882ba8753a012ba8c19cb70028', '402881882ba8753a012ba8bf474d001c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c1bf720029', '2010-10-14 11:21:31', '2010-10-14 11:21:31', '昌平区', '402881882ba8753a012ba8bf474d001c,402881882ba8753a012ba8c1bf720029', '402881882ba8753a012ba8bf474d001c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c1dec1002a', '2010-10-14 11:21:39', '2010-10-14 11:21:39', '大兴区', '402881882ba8753a012ba8bf474d001c,402881882ba8753a012ba8c1dec1002a', '402881882ba8753a012ba8bf474d001c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c200e0002b', '2010-10-14 11:21:48', '2010-10-14 11:21:48', '怀柔区', '402881882ba8753a012ba8bf474d001c,402881882ba8753a012ba8c200e0002b', '402881882ba8753a012ba8bf474d001c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c2164c002c', '2010-10-14 11:21:53', '2010-10-14 11:21:53', '平谷区', '402881882ba8753a012ba8bf474d001c,402881882ba8753a012ba8c2164c002c', '402881882ba8753a012ba8bf474d001c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c27285002d', '2010-10-14 11:22:17', '2010-10-14 11:22:17', '密云县', '402881882ba8753a012ba8bf474d001c,402881882ba8753a012ba8c27285002d', '402881882ba8753a012ba8bf474d001c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c28be9002e', '2010-10-14 11:22:23', '2010-10-14 11:22:23', '延庆县', '402881882ba8753a012ba8bf474d001c,402881882ba8753a012ba8c28be9002e', '402881882ba8753a012ba8bf474d001c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c389a2002f', '2010-10-14 11:23:28', '2010-10-14 11:23:28', '天津', '402881882ba8753a012ba8c389a2002f', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c3bcc80030', '2010-10-14 11:23:41', '2010-10-14 11:23:41', '和平区', '402881882ba8753a012ba8c389a2002f,402881882ba8753a012ba8c3bcc80030', '402881882ba8753a012ba8c389a2002f');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c3e4460031', '2010-10-14 11:23:51', '2010-10-14 11:23:51', '河东区', '402881882ba8753a012ba8c389a2002f,402881882ba8753a012ba8c3e4460031', '402881882ba8753a012ba8c389a2002f');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c409df0032', '2010-10-14 11:24:01', '2010-10-14 11:24:01', '河西区', '402881882ba8753a012ba8c389a2002f,402881882ba8753a012ba8c409df0032', '402881882ba8753a012ba8c389a2002f');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c42e5e0033', '2010-10-14 11:24:10', '2010-10-14 11:24:10', '南开区', '402881882ba8753a012ba8c389a2002f,402881882ba8753a012ba8c42e5e0033', '402881882ba8753a012ba8c389a2002f');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c454450034', '2010-10-14 11:24:20', '2010-10-14 11:24:20', '河北区', '402881882ba8753a012ba8c389a2002f,402881882ba8753a012ba8c454450034', '402881882ba8753a012ba8c389a2002f');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c479040035', '2010-10-14 11:24:29', '2010-10-14 11:24:29', '红桥区', '402881882ba8753a012ba8c389a2002f,402881882ba8753a012ba8c479040035', '402881882ba8753a012ba8c389a2002f');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c49db20036', '2010-10-14 11:24:39', '2010-10-14 11:24:39', '塘沽区', '402881882ba8753a012ba8c389a2002f,402881882ba8753a012ba8c49db20036', '402881882ba8753a012ba8c389a2002f');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c4c2610037', '2010-10-14 11:24:48', '2010-10-14 11:24:48', '汉沽区', '402881882ba8753a012ba8c389a2002f,402881882ba8753a012ba8c4c2610037', '402881882ba8753a012ba8c389a2002f');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c4e5790038', '2010-10-14 11:24:57', '2010-10-14 11:24:57', '大港区', '402881882ba8753a012ba8c389a2002f,402881882ba8753a012ba8c4e5790038', '402881882ba8753a012ba8c389a2002f');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c50c890039', '2010-10-14 11:25:07', '2010-10-14 11:25:07', '东丽区', '402881882ba8753a012ba8c389a2002f,402881882ba8753a012ba8c50c890039', '402881882ba8753a012ba8c389a2002f');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c53109003a', '2010-10-14 11:25:16', '2010-10-14 11:25:16', '西青区', '402881882ba8753a012ba8c389a2002f,402881882ba8753a012ba8c53109003a', '402881882ba8753a012ba8c389a2002f');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c55838003b', '2010-10-14 11:25:26', '2010-10-14 11:25:26', '津南区', '402881882ba8753a012ba8c389a2002f,402881882ba8753a012ba8c55838003b', '402881882ba8753a012ba8c389a2002f');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c57e00003c', '2010-10-14 11:25:36', '2010-10-14 11:25:36', '北辰区', '402881882ba8753a012ba8c389a2002f,402881882ba8753a012ba8c57e00003c', '402881882ba8753a012ba8c389a2002f');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c5a2de003d', '2010-10-14 11:25:46', '2010-10-14 11:25:46', '武清区', '402881882ba8753a012ba8c389a2002f,402881882ba8753a012ba8c5a2de003d', '402881882ba8753a012ba8c389a2002f');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c5c829003e', '2010-10-14 11:25:55', '2010-10-14 11:25:55', '宝坻区', '402881882ba8753a012ba8c389a2002f,402881882ba8753a012ba8c5c829003e', '402881882ba8753a012ba8c389a2002f');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c5eac4003f', '2010-10-14 11:26:04', '2010-10-14 11:26:04', '宁河县', '402881882ba8753a012ba8c389a2002f,402881882ba8753a012ba8c5eac4003f', '402881882ba8753a012ba8c389a2002f');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c60e980040', '2010-10-14 11:26:13', '2010-10-14 11:26:13', '静海县', '402881882ba8753a012ba8c389a2002f,402881882ba8753a012ba8c60e980040', '402881882ba8753a012ba8c389a2002f');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c626270041', '2010-10-14 11:26:19', '2010-10-14 11:26:19', '蓟县', '402881882ba8753a012ba8c389a2002f,402881882ba8753a012ba8c626270041', '402881882ba8753a012ba8c389a2002f');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c689d30042', '2010-10-14 11:26:45', '2010-10-14 11:26:45', '河北省', '402881882ba8753a012ba8c689d30042', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c6da830043', '2010-10-14 11:27:05', '2010-10-14 11:27:05', '石家庄市', '402881882ba8753a012ba8c689d30042,402881882ba8753a012ba8c6da830043', '402881882ba8753a012ba8c689d30042');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c7122d0044', '2010-10-14 11:27:20', '2010-10-14 11:27:20', '唐山市', '402881882ba8753a012ba8c689d30042,402881882ba8753a012ba8c7122d0044', '402881882ba8753a012ba8c689d30042');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c73d920045', '2010-10-14 11:27:31', '2010-10-14 11:27:31', '秦皇岛市', '402881882ba8753a012ba8c689d30042,402881882ba8753a012ba8c73d920045', '402881882ba8753a012ba8c689d30042');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c7656d0046', '2010-10-14 11:27:41', '2010-10-14 11:27:41', '邯郸市', '402881882ba8753a012ba8c689d30042,402881882ba8753a012ba8c7656d0046', '402881882ba8753a012ba8c689d30042');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c78fc90047', '2010-10-14 11:27:52', '2010-10-14 11:27:52', '邢台市', '402881882ba8753a012ba8c689d30042,402881882ba8753a012ba8c78fc90047', '402881882ba8753a012ba8c689d30042');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c7bb5d0048', '2010-10-14 11:28:03', '2010-10-14 11:28:03', '保定市', '402881882ba8753a012ba8c689d30042,402881882ba8753a012ba8c7bb5d0048', '402881882ba8753a012ba8c689d30042');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c7e50d0049', '2010-10-14 11:28:14', '2010-10-14 11:28:14', '张家口市', '402881882ba8753a012ba8c689d30042,402881882ba8753a012ba8c7e50d0049', '402881882ba8753a012ba8c689d30042');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c80c4c004a', '2010-10-14 11:28:24', '2010-10-14 11:28:24', '承德市', '402881882ba8753a012ba8c689d30042,402881882ba8753a012ba8c80c4c004a', '402881882ba8753a012ba8c689d30042');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c8404d004b', '2010-10-14 11:28:37', '2010-10-14 11:28:37', '沧州市', '402881882ba8753a012ba8c689d30042,402881882ba8753a012ba8c8404d004b', '402881882ba8753a012ba8c689d30042');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c898fc004c', '2010-10-14 11:29:00', '2010-10-14 11:29:00', '廊坊市', '402881882ba8753a012ba8c689d30042,402881882ba8753a012ba8c898fc004c', '402881882ba8753a012ba8c689d30042');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c8bc62004d', '2010-10-14 11:29:09', '2010-10-14 11:29:09', '衡水市', '402881882ba8753a012ba8c689d30042,402881882ba8753a012ba8c8bc62004d', '402881882ba8753a012ba8c689d30042');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c8f0b1004e', '2010-10-14 11:29:22', '2010-10-14 11:29:22', '山西省', '402881882ba8753a012ba8c8f0b1004e', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c93924004f', '2010-10-14 11:29:41', '2010-10-14 11:29:41', '太原市', '402881882ba8753a012ba8c8f0b1004e,402881882ba8753a012ba8c93924004f', '402881882ba8753a012ba8c8f0b1004e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c963fd0050', '2010-10-14 11:29:52', '2010-10-14 11:29:52', '大同市', '402881882ba8753a012ba8c8f0b1004e,402881882ba8753a012ba8c963fd0050', '402881882ba8753a012ba8c8f0b1004e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c98d3f0051', '2010-10-14 11:30:02', '2010-10-14 11:30:02', '阳泉市', '402881882ba8753a012ba8c8f0b1004e,402881882ba8753a012ba8c98d3f0051', '402881882ba8753a012ba8c8f0b1004e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c9b72d0052', '2010-10-14 11:30:13', '2010-10-14 11:30:13', '长治市', '402881882ba8753a012ba8c8f0b1004e,402881882ba8753a012ba8c9b72d0052', '402881882ba8753a012ba8c8f0b1004e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8c9e15a0053', '2010-10-14 11:30:24', '2010-10-14 11:30:24', '晋城市', '402881882ba8753a012ba8c8f0b1004e,402881882ba8753a012ba8c9e15a0053', '402881882ba8753a012ba8c8f0b1004e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8ca0e460054', '2010-10-14 11:30:35', '2010-10-14 11:30:35', '朔州市', '402881882ba8753a012ba8c8f0b1004e,402881882ba8753a012ba8ca0e460054', '402881882ba8753a012ba8c8f0b1004e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8ca392f0055', '2010-10-14 11:30:46', '2010-10-14 11:30:46', '晋中市', '402881882ba8753a012ba8c8f0b1004e,402881882ba8753a012ba8ca392f0055', '402881882ba8753a012ba8c8f0b1004e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8ca67240056', '2010-10-14 11:30:58', '2010-10-14 11:30:58', '运城市', '402881882ba8753a012ba8c8f0b1004e,402881882ba8753a012ba8ca67240056', '402881882ba8753a012ba8c8f0b1004e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8ca91ed0057', '2010-10-14 11:31:09', '2010-10-14 11:31:09', '忻州市', '402881882ba8753a012ba8c8f0b1004e,402881882ba8753a012ba8ca91ed0057', '402881882ba8753a012ba8c8f0b1004e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cabae20058', '2010-10-14 11:31:19', '2010-10-14 11:31:19', '临汾市', '402881882ba8753a012ba8c8f0b1004e,402881882ba8753a012ba8cabae20058', '402881882ba8753a012ba8c8f0b1004e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cae26f0059', '2010-10-14 11:31:30', '2010-10-14 11:31:30', '吕梁市', '402881882ba8753a012ba8c8f0b1004e,402881882ba8753a012ba8cae26f0059', '402881882ba8753a012ba8c8f0b1004e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cb1bbf005a', '2010-10-14 11:31:44', '2010-10-14 11:31:44', '内蒙古自治区', '402881882ba8753a012ba8cb1bbf005a', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cb58c8005b', '2010-10-14 11:32:00', '2010-10-14 11:32:00', '呼和浩特市', '402881882ba8753a012ba8cb1bbf005a,402881882ba8753a012ba8cb58c8005b', '402881882ba8753a012ba8cb1bbf005a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cb84c9005c', '2010-10-14 11:32:11', '2010-10-14 11:32:11', '包头市', '402881882ba8753a012ba8cb1bbf005a,402881882ba8753a012ba8cb84c9005c', '402881882ba8753a012ba8cb1bbf005a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cbb7a1005d', '2010-10-14 11:32:24', '2010-10-14 11:32:24', '乌海市', '402881882ba8753a012ba8cb1bbf005a,402881882ba8753a012ba8cbb7a1005d', '402881882ba8753a012ba8cb1bbf005a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cbdf3e005e', '2010-10-14 11:32:34', '2010-10-14 11:32:34', '赤峰市', '402881882ba8753a012ba8cb1bbf005a,402881882ba8753a012ba8cbdf3e005e', '402881882ba8753a012ba8cb1bbf005a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cc0ad2005f', '2010-10-14 11:32:45', '2010-10-14 11:32:45', '通辽市', '402881882ba8753a012ba8cb1bbf005a,402881882ba8753a012ba8cc0ad2005f', '402881882ba8753a012ba8cb1bbf005a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cc3a1f0060', '2010-10-14 11:32:58', '2010-10-14 11:32:58', '鄂尔多斯市', '402881882ba8753a012ba8cb1bbf005a,402881882ba8753a012ba8cc3a1f0060', '402881882ba8753a012ba8cb1bbf005a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cc62870061', '2010-10-14 11:33:08', '2010-10-14 11:33:08', '呼伦贝尔市', '402881882ba8753a012ba8cb1bbf005a,402881882ba8753a012ba8cc62870061', '402881882ba8753a012ba8cb1bbf005a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cc90ea0062', '2010-10-14 11:33:20', '2010-10-14 11:33:20', '巴彦淖尔市', '402881882ba8753a012ba8cb1bbf005a,402881882ba8753a012ba8cc90ea0062', '402881882ba8753a012ba8cb1bbf005a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8ccb71f0063', '2010-10-14 11:33:30', '2010-10-14 11:33:30', '乌兰察布市', '402881882ba8753a012ba8cb1bbf005a,402881882ba8753a012ba8ccb71f0063', '402881882ba8753a012ba8cb1bbf005a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cce2c30064', '2010-10-14 11:33:41', '2010-10-14 11:33:41', '兴安盟', '402881882ba8753a012ba8cb1bbf005a,402881882ba8753a012ba8cce2c30064', '402881882ba8753a012ba8cb1bbf005a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cd105b0065', '2010-10-14 11:33:52', '2010-10-14 11:33:52', '锡林郭勒盟', '402881882ba8753a012ba8cb1bbf005a,402881882ba8753a012ba8cd105b0065', '402881882ba8753a012ba8cb1bbf005a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cd35d50066', '2010-10-14 11:34:02', '2010-10-14 11:34:02', '阿拉善盟', '402881882ba8753a012ba8cb1bbf005a,402881882ba8753a012ba8cd35d50066', '402881882ba8753a012ba8cb1bbf005a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cd6a230067', '2010-10-14 11:34:15', '2010-10-14 11:34:15', '辽宁省', '402881882ba8753a012ba8cd6a230067', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cde3890068', '2010-10-14 11:34:46', '2010-10-14 11:34:46', '沈阳市', '402881882ba8753a012ba8cd6a230067,402881882ba8753a012ba8cde3890068', '402881882ba8753a012ba8cd6a230067');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8ce0ceb0069', '2010-10-14 11:34:57', '2010-10-14 11:34:57', '大连市', '402881882ba8753a012ba8cd6a230067,402881882ba8753a012ba8ce0ceb0069', '402881882ba8753a012ba8cd6a230067');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8ce32a3006a', '2010-10-14 11:35:07', '2010-10-14 11:35:07', '鞍山市', '402881882ba8753a012ba8cd6a230067,402881882ba8753a012ba8ce32a3006a', '402881882ba8753a012ba8cd6a230067');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8ce5b2a006b', '2010-10-14 11:35:17', '2010-10-14 11:35:17', '抚顺市', '402881882ba8753a012ba8cd6a230067,402881882ba8753a012ba8ce5b2a006b', '402881882ba8753a012ba8cd6a230067');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8ce7c10006c', '2010-10-14 11:35:25', '2010-10-14 11:35:25', '本溪市', '402881882ba8753a012ba8cd6a230067,402881882ba8753a012ba8ce7c10006c', '402881882ba8753a012ba8cd6a230067');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cea18a006d', '2010-10-14 11:35:35', '2010-10-14 11:35:35', '丹东市', '402881882ba8753a012ba8cd6a230067,402881882ba8753a012ba8cea18a006d', '402881882ba8753a012ba8cd6a230067');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cec85c006e', '2010-10-14 11:35:45', '2010-10-14 11:35:45', '锦州市', '402881882ba8753a012ba8cd6a230067,402881882ba8753a012ba8cec85c006e', '402881882ba8753a012ba8cd6a230067');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cef5b5006f', '2010-10-14 11:35:57', '2010-10-14 11:35:57', '营口市', '402881882ba8753a012ba8cd6a230067,402881882ba8753a012ba8cef5b5006f', '402881882ba8753a012ba8cd6a230067');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cf1cc50070', '2010-10-14 11:36:07', '2010-10-14 11:36:07', '阜新市', '402881882ba8753a012ba8cd6a230067,402881882ba8753a012ba8cf1cc50070', '402881882ba8753a012ba8cd6a230067');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cf427d0071', '2010-10-14 11:36:16', '2010-10-14 11:36:16', '辽阳市', '402881882ba8753a012ba8cd6a230067,402881882ba8753a012ba8cf427d0071', '402881882ba8753a012ba8cd6a230067');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cf6ae50072', '2010-10-14 11:36:27', '2010-10-14 11:36:27', '盘锦市', '402881882ba8753a012ba8cd6a230067,402881882ba8753a012ba8cf6ae50072', '402881882ba8753a012ba8cd6a230067');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cf90dc0073', '2010-10-14 11:36:36', '2010-10-14 11:36:36', '铁岭市', '402881882ba8753a012ba8cd6a230067,402881882ba8753a012ba8cf90dc0073', '402881882ba8753a012ba8cd6a230067');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cfb6750074', '2010-10-14 11:36:46', '2010-10-14 11:36:46', '朝阳市', '402881882ba8753a012ba8cd6a230067,402881882ba8753a012ba8cfb6750074', '402881882ba8753a012ba8cd6a230067');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8cfdb710075', '2010-10-14 11:36:55', '2010-10-14 11:36:55', '葫芦岛市', '402881882ba8753a012ba8cd6a230067,402881882ba8753a012ba8cfdb710075', '402881882ba8753a012ba8cd6a230067');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d010f90076', '2010-10-14 11:37:09', '2010-10-14 11:37:09', '吉林省', '402881882ba8753a012ba8d010f90076', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d03d870077', '2010-10-14 11:37:21', '2010-10-14 11:37:21', '长春市', '402881882ba8753a012ba8d010f90076,402881882ba8753a012ba8d03d870077', '402881882ba8753a012ba8d010f90076');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d065c00078', '2010-10-14 11:37:31', '2010-10-14 11:37:31', '吉林市', '402881882ba8753a012ba8d010f90076,402881882ba8753a012ba8d065c00078', '402881882ba8753a012ba8d010f90076');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d08acc0079', '2010-10-14 11:37:40', '2010-10-14 11:37:40', '四平市', '402881882ba8753a012ba8d010f90076,402881882ba8753a012ba8d08acc0079', '402881882ba8753a012ba8d010f90076');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d0b046007a', '2010-10-14 11:37:50', '2010-10-14 11:37:50', '辽源市', '402881882ba8753a012ba8d010f90076,402881882ba8753a012ba8d0b046007a', '402881882ba8753a012ba8d010f90076');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d0d7a4007b', '2010-10-14 11:38:00', '2010-10-14 11:38:00', '通化市', '402881882ba8753a012ba8d010f90076,402881882ba8753a012ba8d0d7a4007b', '402881882ba8753a012ba8d010f90076');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d0fe95007c', '2010-10-14 11:38:10', '2010-10-14 11:38:10', '白山市', '402881882ba8753a012ba8d010f90076,402881882ba8753a012ba8d0fe95007c', '402881882ba8753a012ba8d010f90076');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d120b3007d', '2010-10-14 11:38:19', '2010-10-14 11:38:19', '松原市', '402881882ba8753a012ba8d010f90076,402881882ba8753a012ba8d120b3007d', '402881882ba8753a012ba8d010f90076');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d14d8f007e', '2010-10-14 11:38:30', '2010-10-14 11:38:30', '白城市', '402881882ba8753a012ba8d010f90076,402881882ba8753a012ba8d14d8f007e', '402881882ba8753a012ba8d010f90076');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d17a4d007f', '2010-10-14 11:38:42', '2010-10-14 11:38:42', '延边朝鲜族自治州', '402881882ba8753a012ba8d010f90076,402881882ba8753a012ba8d17a4d007f', '402881882ba8753a012ba8d010f90076');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d1b0310080', '2010-10-14 11:38:55', '2010-10-14 11:38:55', '黑龙江省', '402881882ba8753a012ba8d1b0310080', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d1e4320081', '2010-10-14 11:39:09', '2010-10-14 11:39:09', '哈尔滨市', '402881882ba8753a012ba8d1b0310080,402881882ba8753a012ba8d1e4320081', '402881882ba8753a012ba8d1b0310080');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d212850082', '2010-10-14 11:39:21', '2010-10-14 11:39:21', '齐齐哈尔市', '402881882ba8753a012ba8d1b0310080,402881882ba8753a012ba8d212850082', '402881882ba8753a012ba8d1b0310080');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d239090083', '2010-10-14 11:39:30', '2010-10-14 11:39:30', '鸡西市', '402881882ba8753a012ba8d1b0310080,402881882ba8753a012ba8d239090083', '402881882ba8753a012ba8d1b0310080');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d264db0084', '2010-10-14 11:39:42', '2010-10-14 11:39:42', '鹤岗市', '402881882ba8753a012ba8d1b0310080,402881882ba8753a012ba8d264db0084', '402881882ba8753a012ba8d1b0310080');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d28a360085', '2010-10-14 11:39:51', '2010-10-14 11:39:51', '双鸭山市', '402881882ba8753a012ba8d1b0310080,402881882ba8753a012ba8d28a360085', '402881882ba8753a012ba8d1b0310080');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d2b2cd0086', '2010-10-14 11:40:02', '2010-10-14 11:40:02', '大庆市', '402881882ba8753a012ba8d1b0310080,402881882ba8753a012ba8d2b2cd0086', '402881882ba8753a012ba8d1b0310080');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d2daa80087', '2010-10-14 11:40:12', '2010-10-14 11:40:12', '伊春市', '402881882ba8753a012ba8d1b0310080,402881882ba8753a012ba8d2daa80087', '402881882ba8753a012ba8d1b0310080');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d300cd0088', '2010-10-14 11:40:22', '2010-10-14 11:40:22', '佳木斯市', '402881882ba8753a012ba8d1b0310080,402881882ba8753a012ba8d300cd0088', '402881882ba8753a012ba8d1b0310080');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d327be0089', '2010-10-14 11:40:32', '2010-10-14 11:40:32', '七台河市', '402881882ba8753a012ba8d1b0310080,402881882ba8753a012ba8d327be0089', '402881882ba8753a012ba8d1b0310080');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d34d47008a', '2010-10-14 11:40:41', '2010-10-14 11:40:41', '牡丹江市', '402881882ba8753a012ba8d1b0310080,402881882ba8753a012ba8d34d47008a', '402881882ba8753a012ba8d1b0310080');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d372c1008b', '2010-10-14 11:40:51', '2010-10-14 11:40:51', '黑河市', '402881882ba8753a012ba8d1b0310080,402881882ba8753a012ba8d372c1008b', '402881882ba8753a012ba8d1b0310080');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d398c8008c', '2010-10-14 11:41:01', '2010-10-14 11:41:01', '绥化市', '402881882ba8753a012ba8d1b0310080,402881882ba8753a012ba8d398c8008c', '402881882ba8753a012ba8d1b0310080');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d3c97c008d', '2010-10-14 11:41:13', '2010-10-14 11:41:13', '大兴安岭地区', '402881882ba8753a012ba8d1b0310080,402881882ba8753a012ba8d3c97c008d', '402881882ba8753a012ba8d1b0310080');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d3f4f1008e', '2010-10-14 11:41:24', '2010-10-14 11:41:24', '上海市', '402881882ba8753a012ba8d3f4f1008e', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d45968008f', '2010-10-14 11:41:50', '2010-10-14 11:41:50', '黄浦区', '402881882ba8753a012ba8d3f4f1008e,402881882ba8753a012ba8d45968008f', '402881882ba8753a012ba8d3f4f1008e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d47e550090', '2010-10-14 11:41:59', '2010-10-14 11:41:59', '卢湾区', '402881882ba8753a012ba8d3f4f1008e,402881882ba8753a012ba8d47e550090', '402881882ba8753a012ba8d3f4f1008e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d4a0f10091', '2010-10-14 11:42:08', '2010-10-14 11:42:08', '徐汇区', '402881882ba8753a012ba8d3f4f1008e,402881882ba8753a012ba8d4a0f10091', '402881882ba8753a012ba8d3f4f1008e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d4c63b0092', '2010-10-14 11:42:18', '2010-10-14 11:42:18', '长宁区', '402881882ba8753a012ba8d3f4f1008e,402881882ba8753a012ba8d4c63b0092', '402881882ba8753a012ba8d3f4f1008e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d4ee260093', '2010-10-14 11:42:28', '2010-10-14 11:42:28', '静安区', '402881882ba8753a012ba8d3f4f1008e,402881882ba8753a012ba8d4ee260093', '402881882ba8753a012ba8d3f4f1008e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d50f5a0094', '2010-10-14 11:42:36', '2010-10-14 11:42:36', '普陀区', '402881882ba8753a012ba8d3f4f1008e,402881882ba8753a012ba8d50f5a0094', '402881882ba8753a012ba8d3f4f1008e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d5366a0095', '2010-10-14 11:42:46', '2010-10-14 11:42:46', '闸北区', '402881882ba8753a012ba8d3f4f1008e,402881882ba8753a012ba8d5366a0095', '402881882ba8753a012ba8d3f4f1008e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d55b190096', '2010-10-14 11:42:56', '2010-10-14 11:42:56', '虹口区', '402881882ba8753a012ba8d3f4f1008e,402881882ba8753a012ba8d55b190096', '402881882ba8753a012ba8d3f4f1008e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d57b430097', '2010-10-14 11:43:04', '2010-10-14 11:43:04', '杨浦区', '402881882ba8753a012ba8d3f4f1008e,402881882ba8753a012ba8d57b430097', '402881882ba8753a012ba8d3f4f1008e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d59fb30098', '2010-10-14 11:43:13', '2010-10-14 11:43:13', '闵行区', '402881882ba8753a012ba8d3f4f1008e,402881882ba8753a012ba8d59fb30098', '402881882ba8753a012ba8d3f4f1008e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d5c54c0099', '2010-10-14 11:43:23', '2010-10-14 11:43:23', '宝山区', '402881882ba8753a012ba8d3f4f1008e,402881882ba8753a012ba8d5c54c0099', '402881882ba8753a012ba8d3f4f1008e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d5ea2a009a', '2010-10-14 11:43:32', '2010-10-14 11:43:32', '嘉定区', '402881882ba8753a012ba8d3f4f1008e,402881882ba8753a012ba8d5ea2a009a', '402881882ba8753a012ba8d3f4f1008e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d61a04009b', '2010-10-14 11:43:45', '2010-10-14 11:43:45', '浦东新区', '402881882ba8753a012ba8d3f4f1008e,402881882ba8753a012ba8d61a04009b', '402881882ba8753a012ba8d3f4f1008e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d6420e009c', '2010-10-14 11:43:55', '2010-10-14 11:43:55', '金山区', '402881882ba8753a012ba8d3f4f1008e,402881882ba8753a012ba8d6420e009c', '402881882ba8753a012ba8d3f4f1008e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d6bcdb009d', '2010-10-14 11:44:26', '2010-10-14 11:44:26', '松江区', '402881882ba8753a012ba8d3f4f1008e,402881882ba8753a012ba8d6bcdb009d', '402881882ba8753a012ba8d3f4f1008e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d6e330009e', '2010-10-14 11:44:36', '2010-10-14 11:44:36', '青浦区', '402881882ba8753a012ba8d3f4f1008e,402881882ba8753a012ba8d6e330009e', '402881882ba8753a012ba8d3f4f1008e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d70abd009f', '2010-10-14 11:44:46', '2010-10-14 11:44:46', '南汇区', '402881882ba8753a012ba8d3f4f1008e,402881882ba8753a012ba8d70abd009f', '402881882ba8753a012ba8d3f4f1008e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d72b2600a0', '2010-10-14 11:44:55', '2010-10-14 11:44:55', '奉贤区', '402881882ba8753a012ba8d3f4f1008e,402881882ba8753a012ba8d72b2600a0', '402881882ba8753a012ba8d3f4f1008e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d745d200a1', '2010-10-14 11:45:01', '2010-10-14 11:45:01', '崇明县', '402881882ba8753a012ba8d3f4f1008e,402881882ba8753a012ba8d745d200a1', '402881882ba8753a012ba8d3f4f1008e');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d780a800a2', '2010-10-14 11:45:16', '2010-10-14 11:45:16', '江苏省', '402881882ba8753a012ba8d780a800a2', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d82d2500a3', '2010-10-14 11:46:01', '2010-10-14 11:46:01', '南京市', '402881882ba8753a012ba8d780a800a2,402881882ba8753a012ba8d82d2500a3', '402881882ba8753a012ba8d780a800a2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d8605a00a4', '2010-10-14 11:46:14', '2010-10-14 11:46:14', '无锡市', '402881882ba8753a012ba8d780a800a2,402881882ba8753a012ba8d8605a00a4', '402881882ba8753a012ba8d780a800a2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d88b1300a5', '2010-10-14 11:46:25', '2010-10-14 11:46:25', '徐州市', '402881882ba8753a012ba8d780a800a2,402881882ba8753a012ba8d88b1300a5', '402881882ba8753a012ba8d780a800a2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d8b1e500a6', '2010-10-14 11:46:35', '2010-10-14 11:46:35', '常州市', '402881882ba8753a012ba8d780a800a2,402881882ba8753a012ba8d8b1e500a6', '402881882ba8753a012ba8d780a800a2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d8e08600a7', '2010-10-14 11:46:47', '2010-10-14 11:46:47', '苏州市', '402881882ba8753a012ba8d780a800a2,402881882ba8753a012ba8d8e08600a7', '402881882ba8753a012ba8d780a800a2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d907b600a8', '2010-10-14 11:46:57', '2010-10-14 11:46:57', '南通市', '402881882ba8753a012ba8d780a800a2,402881882ba8753a012ba8d907b600a8', '402881882ba8753a012ba8d780a800a2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d9317500a9', '2010-10-14 11:47:07', '2010-10-14 11:47:07', '连云港市', '402881882ba8753a012ba8d780a800a2,402881882ba8753a012ba8d9317500a9', '402881882ba8753a012ba8d780a800a2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d956df00aa', '2010-10-14 11:47:17', '2010-10-14 11:47:17', '淮安市', '402881882ba8753a012ba8d780a800a2,402881882ba8753a012ba8d956df00aa', '402881882ba8753a012ba8d780a800a2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d97d6300ab', '2010-10-14 11:47:27', '2010-10-14 11:47:27', '盐城市', '402881882ba8753a012ba8d780a800a2,402881882ba8753a012ba8d97d6300ab', '402881882ba8753a012ba8d780a800a2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d9a2fc00ac', '2010-10-14 11:47:36', '2010-10-14 11:47:36', '扬州市', '402881882ba8753a012ba8d780a800a2,402881882ba8753a012ba8d9a2fc00ac', '402881882ba8753a012ba8d780a800a2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d9ca4a00ad', '2010-10-14 11:47:46', '2010-10-14 11:47:46', '镇江市', '402881882ba8753a012ba8d780a800a2,402881882ba8753a012ba8d9ca4a00ad', '402881882ba8753a012ba8d780a800a2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8d9eef900ae', '2010-10-14 11:47:56', '2010-10-14 11:47:56', '泰州市', '402881882ba8753a012ba8d780a800a2,402881882ba8753a012ba8d9eef900ae', '402881882ba8753a012ba8d780a800a2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8da172200af', '2010-10-14 11:48:06', '2010-10-14 11:48:06', '宿迁市', '402881882ba8753a012ba8d780a800a2,402881882ba8753a012ba8da172200af', '402881882ba8753a012ba8d780a800a2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8da48e000b0', '2010-10-14 11:48:19', '2010-10-14 11:48:19', '浙江省', '402881882ba8753a012ba8da48e000b0', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba8da7d2f00b1', '2010-10-14 11:48:32', '2010-10-14 11:48:32', '杭州市', '402881882ba8753a012ba8da48e000b0,402881882ba8753a012ba8da7d2f00b1', '402881882ba8753a012ba8da48e000b0');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8daa35500b2', '2010-10-14 11:48:42', '2010-10-14 11:48:42', '宁波市', '402881882ba8753a012ba8da48e000b0,402881882ba8753a012ba8daa35500b2', '402881882ba8753a012ba8da48e000b0');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8dacb3000b3', '2010-10-14 11:48:52', '2010-10-14 11:48:52', '温州市', '402881882ba8753a012ba8da48e000b0,402881882ba8753a012ba8dacb3000b3', '402881882ba8753a012ba8da48e000b0');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8daf15500b4', '2010-10-14 11:49:02', '2010-10-14 11:49:02', '嘉兴市', '402881882ba8753a012ba8da48e000b0,402881882ba8753a012ba8daf15500b4', '402881882ba8753a012ba8da48e000b0');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8db14db00b5', '2010-10-14 11:49:11', '2010-10-14 11:49:11', '湖州市', '402881882ba8753a012ba8da48e000b0,402881882ba8753a012ba8db14db00b5', '402881882ba8753a012ba8da48e000b0');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8db3e9b00b6', '2010-10-14 11:49:22', '2010-10-14 11:49:22', '绍兴市', '402881882ba8753a012ba8da48e000b0,402881882ba8753a012ba8db3e9b00b6', '402881882ba8753a012ba8da48e000b0');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8db6a8d00b7', '2010-10-14 11:49:33', '2010-10-14 11:49:33', '金华市', '402881882ba8753a012ba8da48e000b0,402881882ba8753a012ba8db6a8d00b7', '402881882ba8753a012ba8da48e000b0');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8db978800b8', '2010-10-14 11:49:44', '2010-10-14 11:49:44', '衢州市', '402881882ba8753a012ba8da48e000b0,402881882ba8753a012ba8db978800b8', '402881882ba8753a012ba8da48e000b0');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8dbcc7300b9', '2010-10-14 11:49:58', '2010-10-14 11:49:58', '舟山市', '402881882ba8753a012ba8da48e000b0,402881882ba8753a012ba8dbcc7300b9', '402881882ba8753a012ba8da48e000b0');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8dbf33500ba', '2010-10-14 11:50:08', '2010-10-14 11:50:08', '台州市', '402881882ba8753a012ba8da48e000b0,402881882ba8753a012ba8dbf33500ba', '402881882ba8753a012ba8da48e000b0');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8dc1c9700bb', '2010-10-14 11:50:19', '2010-10-14 11:50:19', '丽水市', '402881882ba8753a012ba8da48e000b0,402881882ba8753a012ba8dc1c9700bb', '402881882ba8753a012ba8da48e000b0');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8dc469500bc', '2010-10-14 11:50:29', '2010-10-14 11:50:29', '安徽省', '402881882ba8753a012ba8dc469500bc', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba8dc8c3900bd', '2010-10-14 11:50:47', '2010-10-14 11:50:47', '合肥市', '402881882ba8753a012ba8dc469500bc,402881882ba8753a012ba8dc8c3900bd', '402881882ba8753a012ba8dc469500bc');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8dcb25f00be', '2010-10-14 11:50:57', '2010-10-14 11:50:57', '芜湖市', '402881882ba8753a012ba8dc469500bc,402881882ba8753a012ba8dcb25f00be', '402881882ba8753a012ba8dc469500bc');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8dd667c00bf', '2010-10-14 11:51:43', '2010-10-14 11:51:43', '蚌埠市', '402881882ba8753a012ba8dc469500bc,402881882ba8753a012ba8dd667c00bf', '402881882ba8753a012ba8dc469500bc');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8dd925e00c0', '2010-10-14 11:51:54', '2010-10-14 11:51:54', '淮南市', '402881882ba8753a012ba8dc469500bc,402881882ba8753a012ba8dd925e00c0', '402881882ba8753a012ba8dc469500bc');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8ddb58600c1', '2010-10-14 11:52:03', '2010-10-14 11:52:03', '马鞍山市', '402881882ba8753a012ba8dc469500bc,402881882ba8753a012ba8ddb58600c1', '402881882ba8753a012ba8dc469500bc');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8ddd98900c2', '2010-10-14 11:52:12', '2010-10-14 11:52:12', '淮北市', '402881882ba8753a012ba8dc469500bc,402881882ba8753a012ba8ddd98900c2', '402881882ba8753a012ba8dc469500bc');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8ddfa9e00c3', '2010-10-14 11:52:21', '2010-10-14 11:52:21', '铜陵市', '402881882ba8753a012ba8dc469500bc,402881882ba8753a012ba8ddfa9e00c3', '402881882ba8753a012ba8dc469500bc');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8de1e8100c4', '2010-10-14 11:52:30', '2010-10-14 11:52:30', '安庆市', '402881882ba8753a012ba8dc469500bc,402881882ba8753a012ba8de1e8100c4', '402881882ba8753a012ba8dc469500bc');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8de4dde00c5', '2010-10-14 11:52:42', '2010-10-14 11:52:42', '黄山市', '402881882ba8753a012ba8dc469500bc,402881882ba8753a012ba8de4dde00c5', '402881882ba8753a012ba8dc469500bc');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8de730a00c6', '2010-10-14 11:52:52', '2010-10-14 11:52:52', '滁州市', '402881882ba8753a012ba8dc469500bc,402881882ba8753a012ba8de730a00c6', '402881882ba8753a012ba8dc469500bc');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8de9ad500c7', '2010-10-14 11:53:02', '2010-10-14 11:53:02', '阜阳市', '402881882ba8753a012ba8dc469500bc,402881882ba8753a012ba8de9ad500c7', '402881882ba8753a012ba8dc469500bc');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8df216b00c8', '2010-10-14 11:53:36', '2010-10-14 11:53:36', '宿州市', '402881882ba8753a012ba8dc469500bc,402881882ba8753a012ba8df216b00c8', '402881882ba8753a012ba8dc469500bc');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8df585900c9', '2010-10-14 11:53:50', '2010-10-14 11:53:50', '巢湖市', '402881882ba8753a012ba8dc469500bc,402881882ba8753a012ba8df585900c9', '402881882ba8753a012ba8dc469500bc');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8df7d5600ca', '2010-10-14 11:54:00', '2010-10-14 11:54:00', '六安市', '402881882ba8753a012ba8dc469500bc,402881882ba8753a012ba8df7d5600ca', '402881882ba8753a012ba8dc469500bc');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8dfa8cb00cb', '2010-10-14 11:54:11', '2010-10-14 11:54:11', '亳州市', '402881882ba8753a012ba8dc469500bc,402881882ba8753a012ba8dfa8cb00cb', '402881882ba8753a012ba8dc469500bc');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8dfcf1f00cc', '2010-10-14 11:54:21', '2010-10-14 11:54:21', '池州市', '402881882ba8753a012ba8dc469500bc,402881882ba8753a012ba8dfcf1f00cc', '402881882ba8753a012ba8dc469500bc');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8dff4f700cd', '2010-10-14 11:54:31', '2010-10-14 11:54:31', '宣城市', '402881882ba8753a012ba8dc469500bc,402881882ba8753a012ba8dff4f700cd', '402881882ba8753a012ba8dc469500bc');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e0243500ce', '2010-10-14 11:54:43', '2010-10-14 11:54:43', '福建省', '402881882ba8753a012ba8e0243500ce', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e1b06200cf', '2010-10-14 11:56:24', '2010-10-14 11:56:24', '福州市', '402881882ba8753a012ba8e0243500ce,402881882ba8753a012ba8e1b06200cf', '402881882ba8753a012ba8e0243500ce');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e1f17300d0', '2010-10-14 11:56:41', '2010-10-14 11:56:41', '厦门市', '402881882ba8753a012ba8e0243500ce,402881882ba8753a012ba8e1f17300d0', '402881882ba8753a012ba8e0243500ce');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e21c5b00d1', '2010-10-14 11:56:52', '2010-10-14 11:56:52', '莆田市', '402881882ba8753a012ba8e0243500ce,402881882ba8753a012ba8e21c5b00d1', '402881882ba8753a012ba8e0243500ce');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e2480f00d2', '2010-10-14 11:57:03', '2010-10-14 11:57:03', '三明市', '402881882ba8753a012ba8e0243500ce,402881882ba8753a012ba8e2480f00d2', '402881882ba8753a012ba8e0243500ce');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e26c9e00d3', '2010-10-14 11:57:12', '2010-10-14 11:57:12', '泉州市', '402881882ba8753a012ba8e0243500ce,402881882ba8753a012ba8e26c9e00d3', '402881882ba8753a012ba8e0243500ce');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e29b4f00d4', '2010-10-14 11:57:24', '2010-10-14 11:57:24', '漳州市', '402881882ba8753a012ba8e0243500ce,402881882ba8753a012ba8e29b4f00d4', '402881882ba8753a012ba8e0243500ce');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e2c9b200d5', '2010-10-14 11:57:36', '2010-10-14 11:57:36', '南平市', '402881882ba8753a012ba8e0243500ce,402881882ba8753a012ba8e2c9b200d5', '402881882ba8753a012ba8e0243500ce');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e2f48b00d6', '2010-10-14 11:57:47', '2010-10-14 11:57:47', '龙岩市', '402881882ba8753a012ba8e0243500ce,402881882ba8753a012ba8e2f48b00d6', '402881882ba8753a012ba8e0243500ce');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e31be900d7', '2010-10-14 11:57:57', '2010-10-14 11:57:57', '宁德市', '402881882ba8753a012ba8e0243500ce,402881882ba8753a012ba8e31be900d7', '402881882ba8753a012ba8e0243500ce');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e362b600d8', '2010-10-14 11:58:15', '2010-10-14 11:58:15', '江西省', '402881882ba8753a012ba8e362b600d8', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e3b49f00d9', '2010-10-14 11:58:36', '2010-10-14 11:58:36', '南昌市', '402881882ba8753a012ba8e362b600d8,402881882ba8753a012ba8e3b49f00d9', '402881882ba8753a012ba8e362b600d8');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e433f000da', '2010-10-14 11:59:09', '2010-10-14 11:59:09', '景德镇市', '402881882ba8753a012ba8e362b600d8,402881882ba8753a012ba8e433f000da', '402881882ba8753a012ba8e362b600d8');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e45ca600db', '2010-10-14 11:59:19', '2010-10-14 11:59:19', '萍乡市', '402881882ba8753a012ba8e362b600d8,402881882ba8753a012ba8e45ca600db', '402881882ba8753a012ba8e362b600d8');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e4808a00dc', '2010-10-14 11:59:28', '2010-10-14 11:59:28', '九江市', '402881882ba8753a012ba8e362b600d8,402881882ba8753a012ba8e4808a00dc', '402881882ba8753a012ba8e362b600d8');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e4a74c00dd', '2010-10-14 11:59:38', '2010-10-14 11:59:38', '新余市', '402881882ba8753a012ba8e362b600d8,402881882ba8753a012ba8e4a74c00dd', '402881882ba8753a012ba8e362b600d8');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e4cdb000de', '2010-10-14 11:59:48', '2010-10-14 11:59:48', '鹰潭市', '402881882ba8753a012ba8e362b600d8,402881882ba8753a012ba8e4cdb000de', '402881882ba8753a012ba8e362b600d8');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e4ef4200df', '2010-10-14 11:59:57', '2010-10-14 11:59:57', '赣州市', '402881882ba8753a012ba8e362b600d8,402881882ba8753a012ba8e4ef4200df', '402881882ba8753a012ba8e362b600d8');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e53fb300e0', '2010-10-14 12:00:17', '2010-10-14 12:00:17', '吉安市', '402881882ba8753a012ba8e362b600d8,402881882ba8753a012ba8e53fb300e0', '402881882ba8753a012ba8e362b600d8');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e56d0d00e1', '2010-10-14 12:00:29', '2010-10-14 12:00:29', '宜春市', '402881882ba8753a012ba8e362b600d8,402881882ba8753a012ba8e56d0d00e1', '402881882ba8753a012ba8e362b600d8');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e5921900e2', '2010-10-14 12:00:38', '2010-10-14 12:00:38', '抚州市', '402881882ba8753a012ba8e362b600d8,402881882ba8753a012ba8e5921900e2', '402881882ba8753a012ba8e362b600d8');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e5c22200e3', '2010-10-14 12:00:51', '2010-10-14 12:00:51', '上饶市', '402881882ba8753a012ba8e362b600d8,402881882ba8753a012ba8e5c22200e3', '402881882ba8753a012ba8e362b600d8');
INSERT INTO `area` VALUES ('402881882ba8753a012ba8e5f7d800e4', '2010-10-14 12:01:04', '2010-10-14 12:01:04', '山东省', '402881882ba8753a012ba8e5f7d800e4', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba928e9c800e5', '2010-10-14 13:14:12', '2010-10-14 13:14:12', '济南市', '402881882ba8753a012ba8e5f7d800e4,402881882ba8753a012ba928e9c800e5', '402881882ba8753a012ba8e5f7d800e4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba929137800e6', '2010-10-14 13:14:22', '2010-10-14 13:14:22', '青岛市', '402881882ba8753a012ba8e5f7d800e4,402881882ba8753a012ba929137800e6', '402881882ba8753a012ba8e5f7d800e4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba929374c00e7', '2010-10-14 13:14:32', '2010-10-14 13:14:32', '淄博市', '402881882ba8753a012ba8e5f7d800e4,402881882ba8753a012ba929374c00e7', '402881882ba8753a012ba8e5f7d800e4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9295d4300e8', '2010-10-14 13:14:41', '2010-10-14 13:14:41', '枣庄市', '402881882ba8753a012ba8e5f7d800e4,402881882ba8753a012ba9295d4300e8', '402881882ba8753a012ba8e5f7d800e4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba929884b00e9', '2010-10-14 13:14:52', '2010-10-14 13:14:52', '东营市', '402881882ba8753a012ba8e5f7d800e4,402881882ba8753a012ba929884b00e9', '402881882ba8753a012ba8e5f7d800e4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba929ac2e00ea', '2010-10-14 13:15:02', '2010-10-14 13:15:02', '烟台市', '402881882ba8753a012ba8e5f7d800e4,402881882ba8753a012ba929ac2e00ea', '402881882ba8753a012ba8e5f7d800e4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba929cfe300eb', '2010-10-14 13:15:11', '2010-10-14 13:15:11', '潍坊市', '402881882ba8753a012ba8e5f7d800e4,402881882ba8753a012ba929cfe300eb', '402881882ba8753a012ba8e5f7d800e4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba929f68500ec', '2010-10-14 13:15:21', '2010-10-14 13:15:21', '济宁市', '402881882ba8753a012ba8e5f7d800e4,402881882ba8753a012ba929f68500ec', '402881882ba8753a012ba8e5f7d800e4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92a1a4a00ed', '2010-10-14 13:15:30', '2010-10-14 13:15:30', '泰安市', '402881882ba8753a012ba8e5f7d800e4,402881882ba8753a012ba92a1a4a00ed', '402881882ba8753a012ba8e5f7d800e4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92a5f0300ee', '2010-10-14 13:15:47', '2010-10-14 13:15:47', '威海市', '402881882ba8753a012ba8e5f7d800e4,402881882ba8753a012ba92a5f0300ee', '402881882ba8753a012ba8e5f7d800e4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92a825a00ef', '2010-10-14 13:15:56', '2010-10-14 13:15:56', '日照市', '402881882ba8753a012ba8e5f7d800e4,402881882ba8753a012ba92a825a00ef', '402881882ba8753a012ba8e5f7d800e4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92aa99900f0', '2010-10-14 13:16:06', '2010-10-14 13:16:06', '莱芜市', '402881882ba8753a012ba8e5f7d800e4,402881882ba8753a012ba92aa99900f0', '402881882ba8753a012ba8e5f7d800e4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92acd4e00f1', '2010-10-14 13:16:16', '2010-10-14 13:16:16', '临沂市', '402881882ba8753a012ba8e5f7d800e4,402881882ba8753a012ba92acd4e00f1', '402881882ba8753a012ba8e5f7d800e4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92af27900f2', '2010-10-14 13:16:25', '2010-10-14 13:16:25', '德州市', '402881882ba8753a012ba8e5f7d800e4,402881882ba8753a012ba92af27900f2', '402881882ba8753a012ba8e5f7d800e4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92b154400f3', '2010-10-14 13:16:34', '2010-10-14 13:16:34', '聊城市', '402881882ba8753a012ba8e5f7d800e4,402881882ba8753a012ba92b154400f3', '402881882ba8753a012ba8e5f7d800e4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92b3a6000f4', '2010-10-14 13:16:44', '2010-10-14 13:16:44', '滨州市', '402881882ba8753a012ba8e5f7d800e4,402881882ba8753a012ba92b3a6000f4', '402881882ba8753a012ba8e5f7d800e4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92b688400f5', '2010-10-14 13:16:55', '2010-10-14 13:16:55', '荷泽市', '402881882ba8753a012ba8e5f7d800e4,402881882ba8753a012ba92b688400f5', '402881882ba8753a012ba8e5f7d800e4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92ba9c300f6', '2010-10-14 13:17:12', '2010-10-14 13:17:12', '河南省', '402881882ba8753a012ba92ba9c300f6', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba92bd8a300f7', '2010-10-14 13:17:24', '2010-10-14 13:17:24', '郑州市', '402881882ba8753a012ba92ba9c300f6,402881882ba8753a012ba92bd8a300f7', '402881882ba8753a012ba92ba9c300f6');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92bfab200f8', '2010-10-14 13:17:33', '2010-10-14 13:17:33', '开封市', '402881882ba8753a012ba92ba9c300f6,402881882ba8753a012ba92bfab200f8', '402881882ba8753a012ba92ba9c300f6');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92c1afc00f9', '2010-10-14 13:17:41', '2010-10-14 13:17:41', '洛阳市', '402881882ba8753a012ba92ba9c300f6,402881882ba8753a012ba92c1afc00f9', '402881882ba8753a012ba92ba9c300f6');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92c42c700fa', '2010-10-14 13:17:51', '2010-10-14 13:17:51', '平顶山市', '402881882ba8753a012ba92ba9c300f6,402881882ba8753a012ba92c42c700fa', '402881882ba8753a012ba92ba9c300f6');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92c66f900fb', '2010-10-14 13:18:00', '2010-10-14 13:18:00', '安阳市', '402881882ba8753a012ba92ba9c300f6,402881882ba8753a012ba92c66f900fb', '402881882ba8753a012ba92ba9c300f6');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92c898400fc', '2010-10-14 13:18:09', '2010-10-14 13:18:09', '鹤壁市', '402881882ba8753a012ba92ba9c300f6,402881882ba8753a012ba92c898400fc', '402881882ba8753a012ba92ba9c300f6');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92cac2f00fd', '2010-10-14 13:18:18', '2010-10-14 13:18:18', '新乡市', '402881882ba8753a012ba92ba9c300f6,402881882ba8753a012ba92cac2f00fd', '402881882ba8753a012ba92ba9c300f6');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92ccce600fe', '2010-10-14 13:18:27', '2010-10-14 13:18:27', '焦作市', '402881882ba8753a012ba92ba9c300f6,402881882ba8753a012ba92ccce600fe', '402881882ba8753a012ba92ba9c300f6');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92cef0500ff', '2010-10-14 13:18:35', '2010-10-14 13:18:35', '濮阳市', '402881882ba8753a012ba92ba9c300f6,402881882ba8753a012ba92cef0500ff', '402881882ba8753a012ba92ba9c300f6');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92d13f20100', '2010-10-14 13:18:45', '2010-10-14 13:18:45', '许昌市', '402881882ba8753a012ba92ba9c300f6,402881882ba8753a012ba92d13f20100', '402881882ba8753a012ba92ba9c300f6');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92d35360101', '2010-10-14 13:18:53', '2010-10-14 13:18:53', '漯河市', '402881882ba8753a012ba92ba9c300f6,402881882ba8753a012ba92d35360101', '402881882ba8753a012ba92ba9c300f6');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92d57d10102', '2010-10-14 13:19:02', '2010-10-14 13:19:02', '三门峡市', '402881882ba8753a012ba92ba9c300f6,402881882ba8753a012ba92d57d10102', '402881882ba8753a012ba92ba9c300f6');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92d7ba50103', '2010-10-14 13:19:11', '2010-10-14 13:19:11', '南阳市', '402881882ba8753a012ba92ba9c300f6,402881882ba8753a012ba92d7ba50103', '402881882ba8753a012ba92ba9c300f6');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92da1ab0104', '2010-10-14 13:19:21', '2010-10-14 13:19:21', '商丘市', '402881882ba8753a012ba92ba9c300f6,402881882ba8753a012ba92da1ab0104', '402881882ba8753a012ba92ba9c300f6');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92dc7b20105', '2010-10-14 13:19:31', '2010-10-14 13:19:31', '信阳市', '402881882ba8753a012ba92ba9c300f6,402881882ba8753a012ba92dc7b20105', '402881882ba8753a012ba92ba9c300f6');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92de8780106', '2010-10-14 13:19:39', '2010-10-14 13:19:39', '周口市', '402881882ba8753a012ba92ba9c300f6,402881882ba8753a012ba92de8780106', '402881882ba8753a012ba92ba9c300f6');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92e0bee0107', '2010-10-14 13:19:48', '2010-10-14 13:19:48', '驻马店市', '402881882ba8753a012ba92ba9c300f6,402881882ba8753a012ba92e0bee0107', '402881882ba8753a012ba92ba9c300f6');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92e37a20108', '2010-10-14 13:19:59', '2010-10-14 13:19:59', '湖北省', '402881882ba8753a012ba92e37a20108', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba92e68660109', '2010-10-14 13:20:12', '2010-10-14 13:20:12', '武汉市', '402881882ba8753a012ba92e37a20108,402881882ba8753a012ba92e68660109', '402881882ba8753a012ba92e37a20108');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92e94d5010a', '2010-10-14 13:20:23', '2010-10-14 13:20:23', '黄石市', '402881882ba8753a012ba92e37a20108,402881882ba8753a012ba92e94d5010a', '402881882ba8753a012ba92e37a20108');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92eb82c010b', '2010-10-14 13:20:32', '2010-10-14 13:20:32', '十堰市', '402881882ba8753a012ba92e37a20108,402881882ba8753a012ba92eb82c010b', '402881882ba8753a012ba92e37a20108');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92edfe8010c', '2010-10-14 13:20:42', '2010-10-14 13:20:42', '宜昌市', '402881882ba8753a012ba92e37a20108,402881882ba8753a012ba92edfe8010c', '402881882ba8753a012ba92e37a20108');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92f21a4010d', '2010-10-14 13:20:59', '2010-10-14 13:20:59', '襄樊市', '402881882ba8753a012ba92e37a20108,402881882ba8753a012ba92f21a4010d', '402881882ba8753a012ba92e37a20108');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92f4ab8010e', '2010-10-14 13:21:10', '2010-10-14 13:21:10', '鄂州市', '402881882ba8753a012ba92e37a20108,402881882ba8753a012ba92f4ab8010e', '402881882ba8753a012ba92e37a20108');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92f6ca7010f', '2010-10-14 13:21:19', '2010-10-14 13:21:19', '荆门市', '402881882ba8753a012ba92e37a20108,402881882ba8753a012ba92f6ca7010f', '402881882ba8753a012ba92e37a20108');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92f8dfa0110', '2010-10-14 13:21:27', '2010-10-14 13:21:27', '孝感市', '402881882ba8753a012ba92e37a20108,402881882ba8753a012ba92f8dfa0110', '402881882ba8753a012ba92e37a20108');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92fb0480111', '2010-10-14 13:21:36', '2010-10-14 13:21:36', '荆州市', '402881882ba8753a012ba92e37a20108,402881882ba8753a012ba92fb0480111', '402881882ba8753a012ba92e37a20108');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92fd6bb0112', '2010-10-14 13:21:46', '2010-10-14 13:21:46', '黄冈市', '402881882ba8753a012ba92e37a20108,402881882ba8753a012ba92fd6bb0112', '402881882ba8753a012ba92e37a20108');
INSERT INTO `area` VALUES ('402881882ba8753a012ba92ff9280113', '2010-10-14 13:21:54', '2010-10-14 13:21:55', '咸宁市', '402881882ba8753a012ba92e37a20108,402881882ba8753a012ba92ff9280113', '402881882ba8753a012ba92e37a20108');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9301be30114', '2010-10-14 13:22:03', '2010-10-14 13:22:03', '随州市', '402881882ba8753a012ba92e37a20108,402881882ba8753a012ba9301be30114', '402881882ba8753a012ba92e37a20108');
INSERT INTO `area` VALUES ('402881882ba8753a012ba930d6690115', '2010-10-14 13:22:51', '2010-10-14 13:22:51', '湖南省', '402881882ba8753a012ba930d6690115', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba93101120116', '2010-10-14 13:23:02', '2010-10-14 13:23:02', '长沙市', '402881882ba8753a012ba930d6690115,402881882ba8753a012ba93101120116', '402881882ba8753a012ba930d6690115');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93125f00117', '2010-10-14 13:23:11', '2010-10-14 13:23:11', '株洲市', '402881882ba8753a012ba930d6690115,402881882ba8753a012ba93125f00117', '402881882ba8753a012ba930d6690115');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93147a10118', '2010-10-14 13:23:20', '2010-10-14 13:23:20', '湘潭市', '402881882ba8753a012ba930d6690115,402881882ba8753a012ba93147a10118', '402881882ba8753a012ba930d6690115');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9316a7b0119', '2010-10-14 13:23:29', '2010-10-14 13:23:29', '衡阳市', '402881882ba8753a012ba930d6690115,402881882ba8753a012ba9316a7b0119', '402881882ba8753a012ba930d6690115');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9318e2f011a', '2010-10-14 13:23:38', '2010-10-14 13:23:38', '邵阳市', '402881882ba8753a012ba930d6690115,402881882ba8753a012ba9318e2f011a', '402881882ba8753a012ba930d6690115');
INSERT INTO `area` VALUES ('402881882ba8753a012ba931b5ad011b', '2010-10-14 13:23:48', '2010-10-14 13:23:48', '岳阳市', '402881882ba8753a012ba930d6690115,402881882ba8753a012ba931b5ad011b', '402881882ba8753a012ba930d6690115');
INSERT INTO `area` VALUES ('402881882ba8753a012ba931dac9011c', '2010-10-14 13:23:58', '2010-10-14 13:23:58', '常德市', '402881882ba8753a012ba930d6690115,402881882ba8753a012ba931dac9011c', '402881882ba8753a012ba930d6690115');
INSERT INTO `area` VALUES ('402881882ba8753a012ba931fe6e011d', '2010-10-14 13:24:07', '2010-10-14 13:24:07', '张家界市', '402881882ba8753a012ba930d6690115,402881882ba8753a012ba931fe6e011d', '402881882ba8753a012ba930d6690115');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93222ce011e', '2010-10-14 13:24:16', '2010-10-14 13:24:16', '益阳市', '402881882ba8753a012ba930d6690115,402881882ba8753a012ba93222ce011e', '402881882ba8753a012ba930d6690115');
INSERT INTO `area` VALUES ('402881882ba8753a012ba932fe59011f', '2010-10-14 13:25:12', '2010-10-14 13:25:12', '郴州市', '402881882ba8753a012ba930d6690115,402881882ba8753a012ba932fe59011f', '402881882ba8753a012ba930d6690115');
INSERT INTO `area` VALUES ('402881882ba8753a012ba933275d0120', '2010-10-14 13:25:23', '2010-10-14 13:25:23', '永州市', '402881882ba8753a012ba930d6690115,402881882ba8753a012ba933275d0120', '402881882ba8753a012ba930d6690115');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9334cd70121', '2010-10-14 13:25:33', '2010-10-14 13:25:33', '怀化市', '402881882ba8753a012ba930d6690115,402881882ba8753a012ba9334cd70121', '402881882ba8753a012ba930d6690115');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9337b880122', '2010-10-14 13:25:44', '2010-10-14 13:25:44', '娄底市', '402881882ba8753a012ba930d6690115,402881882ba8753a012ba9337b880122', '402881882ba8753a012ba930d6690115');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93401620123', '2010-10-14 13:26:19', '2010-10-14 13:26:19', '湘西土家族苗族自治州', '402881882ba8753a012ba930d6690115,402881882ba8753a012ba93401620123', '402881882ba8753a012ba930d6690115');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9342b210124', '2010-10-14 13:26:29', '2010-10-14 13:26:29', '广东省', '402881882ba8753a012ba9342b210124', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba9345e950125', '2010-10-14 13:26:43', '2010-10-14 13:26:43', '广州市', '402881882ba8753a012ba9342b210124,402881882ba8753a012ba9345e950125', '402881882ba8753a012ba9342b210124');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93483e00126', '2010-10-14 13:26:52', '2010-10-14 13:26:52', '韶关市', '402881882ba8753a012ba9342b210124,402881882ba8753a012ba93483e00126', '402881882ba8753a012ba9342b210124');
INSERT INTO `area` VALUES ('402881882ba8753a012ba934ac770127', '2010-10-14 13:27:03', '2010-10-14 13:27:03', '深圳市', '402881882ba8753a012ba9342b210124,402881882ba8753a012ba934ac770127', '402881882ba8753a012ba9342b210124');
INSERT INTO `area` VALUES ('402881882ba8753a012ba934d02b0128', '2010-10-14 13:27:12', '2010-10-14 13:27:12', '珠海市', '402881882ba8753a012ba9342b210124,402881882ba8753a012ba934d02b0128', '402881882ba8753a012ba9342b210124');
INSERT INTO `area` VALUES ('402881882ba8753a012ba934eeb00129', '2010-10-14 13:27:19', '2010-10-14 13:27:19', '汕头市', '402881882ba8753a012ba9342b210124,402881882ba8753a012ba934eeb00129', '402881882ba8753a012ba9342b210124');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9351207012a', '2010-10-14 13:27:29', '2010-10-14 13:27:29', '佛山市', '402881882ba8753a012ba9342b210124,402881882ba8753a012ba9351207012a', '402881882ba8753a012ba9342b210124');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9353406012b', '2010-10-14 13:27:37', '2010-10-14 13:27:37', '江门市', '402881882ba8753a012ba9342b210124,402881882ba8753a012ba9353406012b', '402881882ba8753a012ba9342b210124');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9355672012c', '2010-10-14 13:27:46', '2010-10-14 13:27:46', '湛江市', '402881882ba8753a012ba9342b210124,402881882ba8753a012ba9355672012c', '402881882ba8753a012ba9342b210124');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9357843012d', '2010-10-14 13:27:55', '2010-10-14 13:27:55', '茂名市', '402881882ba8753a012ba9342b210124,402881882ba8753a012ba9357843012d', '402881882ba8753a012ba9342b210124');
INSERT INTO `area` VALUES ('402881882ba8753a012ba935980f012e', '2010-10-14 13:28:03', '2010-10-14 13:28:03', '肇庆市', '402881882ba8753a012ba9342b210124,402881882ba8753a012ba935980f012e', '402881882ba8753a012ba9342b210124');
INSERT INTO `area` VALUES ('402881882ba8753a012ba935c26b012f', '2010-10-14 13:28:14', '2010-10-14 13:28:14', '惠州市', '402881882ba8753a012ba9342b210124,402881882ba8753a012ba935c26b012f', '402881882ba8753a012ba9342b210124');
INSERT INTO `area` VALUES ('402881882ba8753a012ba935e5e10130', '2010-10-14 13:28:23', '2010-10-14 13:28:23', '梅州市', '402881882ba8753a012ba9342b210124,402881882ba8753a012ba935e5e10130', '402881882ba8753a012ba9342b210124');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93609960131', '2010-10-14 13:28:32', '2010-10-14 13:28:32', '汕尾市', '402881882ba8753a012ba9342b210124,402881882ba8753a012ba93609960131', '402881882ba8753a012ba9342b210124');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93638c40132', '2010-10-14 13:28:44', '2010-10-14 13:28:44', '河源市', '402881882ba8753a012ba9342b210124,402881882ba8753a012ba93638c40132', '402881882ba8753a012ba9342b210124');
INSERT INTO `area` VALUES ('402881882ba8753a012ba936593c0133', '2010-10-14 13:28:52', '2010-10-14 13:28:52', '阳江市', '402881882ba8753a012ba9342b210124,402881882ba8753a012ba936593c0133', '402881882ba8753a012ba9342b210124');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9367d9d0134', '2010-10-14 13:29:02', '2010-10-14 13:29:02', '清远市', '402881882ba8753a012ba9342b210124,402881882ba8753a012ba9367d9d0134', '402881882ba8753a012ba9342b210124');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9369b760135', '2010-10-14 13:29:09', '2010-10-14 13:29:09', '东莞市', '402881882ba8753a012ba9342b210124,402881882ba8753a012ba9369b760135', '402881882ba8753a012ba9342b210124');
INSERT INTO `area` VALUES ('402881882ba8753a012ba936c5350136', '2010-10-14 13:29:20', '2010-10-14 13:29:20', '中山市', '402881882ba8753a012ba9342b210124,402881882ba8753a012ba936c5350136', '402881882ba8753a012ba9342b210124');
INSERT INTO `area` VALUES ('402881882ba8753a012ba936eb0d0137', '2010-10-14 13:29:30', '2010-10-14 13:29:30', '潮州市', '402881882ba8753a012ba9342b210124,402881882ba8753a012ba936eb0d0137', '402881882ba8753a012ba9342b210124');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93716720138', '2010-10-14 13:29:41', '2010-10-14 13:29:41', '揭阳市', '402881882ba8753a012ba9342b210124,402881882ba8753a012ba93716720138', '402881882ba8753a012ba9342b210124');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93738ee0139', '2010-10-14 13:29:50', '2010-10-14 13:29:50', '云浮市', '402881882ba8753a012ba9342b210124,402881882ba8753a012ba93738ee0139', '402881882ba8753a012ba9342b210124');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9376770013a', '2010-10-14 13:30:01', '2010-10-14 13:30:01', '广西壮族自治区', '402881882ba8753a012ba9376770013a', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba9379c4c013b', '2010-10-14 13:30:15', '2010-10-14 13:30:15', '南宁市', '402881882ba8753a012ba9376770013a,402881882ba8753a012ba9379c4c013b', '402881882ba8753a012ba9376770013a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba937bf06013c', '2010-10-14 13:30:24', '2010-10-14 13:30:24', '柳州市', '402881882ba8753a012ba9376770013a,402881882ba8753a012ba937bf06013c', '402881882ba8753a012ba9376770013a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba937e192013d', '2010-10-14 13:30:33', '2010-10-14 13:30:33', '桂林市', '402881882ba8753a012ba9376770013a,402881882ba8753a012ba937e192013d', '402881882ba8753a012ba9376770013a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9380789013e', '2010-10-14 13:30:42', '2010-10-14 13:30:42', '梧州市', '402881882ba8753a012ba9376770013a,402881882ba8753a012ba9380789013e', '402881882ba8753a012ba9376770013a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93827f2013f', '2010-10-14 13:30:51', '2010-10-14 13:30:51', '北海市', '402881882ba8753a012ba9376770013a,402881882ba8753a012ba93827f2013f', '402881882ba8753a012ba9376770013a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93851150140', '2010-10-14 13:31:01', '2010-10-14 13:31:01', '防城港市', '402881882ba8753a012ba9376770013a,402881882ba8753a012ba93851150140', '402881882ba8753a012ba9376770013a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93872490141', '2010-10-14 13:31:10', '2010-10-14 13:31:10', '钦州市', '402881882ba8753a012ba9376770013a,402881882ba8753a012ba93872490141', '402881882ba8753a012ba9376770013a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93899780142', '2010-10-14 13:31:20', '2010-10-14 13:31:20', '贵港市', '402881882ba8753a012ba9376770013a,402881882ba8753a012ba93899780142', '402881882ba8753a012ba9376770013a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba938badb0143', '2010-10-14 13:31:28', '2010-10-14 13:31:28', '玉林市', '402881882ba8753a012ba9376770013a,402881882ba8753a012ba938badb0143', '402881882ba8753a012ba9376770013a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba938db820144', '2010-10-14 13:31:37', '2010-10-14 13:31:37', '百色市', '402881882ba8753a012ba9376770013a,402881882ba8753a012ba938db820144', '402881882ba8753a012ba9376770013a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba938fd530145', '2010-10-14 13:31:45', '2010-10-14 13:31:45', '贺州市', '402881882ba8753a012ba9376770013a,402881882ba8753a012ba938fd530145', '402881882ba8753a012ba9376770013a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93921360146', '2010-10-14 13:31:55', '2010-10-14 13:31:55', '河池市', '402881882ba8753a012ba9376770013a,402881882ba8753a012ba93921360146', '402881882ba8753a012ba9376770013a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93943d10147', '2010-10-14 13:32:03', '2010-10-14 13:32:03', '来宾市', '402881882ba8753a012ba9376770013a,402881882ba8753a012ba93943d10147', '402881882ba8753a012ba9376770013a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93965c10148', '2010-10-14 13:32:12', '2010-10-14 13:32:12', '崇左市', '402881882ba8753a012ba9376770013a,402881882ba8753a012ba93965c10148', '402881882ba8753a012ba9376770013a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba939ac010149', '2010-10-14 13:32:30', '2010-10-14 13:32:30', '海南省', '402881882ba8753a012ba939ac010149', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba939da07014a', '2010-10-14 13:32:42', '2010-10-14 13:32:42', '海口市', '402881882ba8753a012ba939ac010149,402881882ba8753a012ba939da07014a', '402881882ba8753a012ba939ac010149');
INSERT INTO `area` VALUES ('402881882ba8753a012ba939f8ca014b', '2010-10-14 13:32:50', '2010-10-14 13:32:50', '三亚市', '402881882ba8753a012ba939ac010149,402881882ba8753a012ba939f8ca014b', '402881882ba8753a012ba939ac010149');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93a6743014c', '2010-10-14 13:33:18', '2010-10-14 13:33:18', '重庆市', '402881882ba8753a012ba93a6743014c', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba93b13fe014d', '2010-10-14 13:34:02', '2010-10-14 13:34:02', '万州区', '402881882ba8753a012ba93a6743014c,402881882ba8753a012ba93b13fe014d', '402881882ba8753a012ba93a6743014c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93b34d4014e', '2010-10-14 13:34:11', '2010-10-14 13:34:11', '涪陵区', '402881882ba8753a012ba93a6743014c,402881882ba8753a012ba93b34d4014e', '402881882ba8753a012ba93a6743014c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93b5898014f', '2010-10-14 13:34:20', '2010-10-14 13:34:20', '渝中区', '402881882ba8753a012ba93a6743014c,402881882ba8753a012ba93b5898014f', '402881882ba8753a012ba93a6743014c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93b7a970150', '2010-10-14 13:34:29', '2010-10-14 13:34:29', '大渡口区', '402881882ba8753a012ba93a6743014c,402881882ba8753a012ba93b7a970150', '402881882ba8753a012ba93a6743014c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93b9a930151', '2010-10-14 13:34:37', '2010-10-14 13:34:37', '江北区', '402881882ba8753a012ba93a6743014c,402881882ba8753a012ba93b9a930151', '402881882ba8753a012ba93a6743014c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93bbb980152', '2010-10-14 13:34:45', '2010-10-14 13:34:45', '沙坪坝区', '402881882ba8753a012ba93a6743014c,402881882ba8753a012ba93bbb980152', '402881882ba8753a012ba93a6743014c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93bdab90153', '2010-10-14 13:34:53', '2010-10-14 13:34:53', '九龙坡区', '402881882ba8753a012ba93a6743014c,402881882ba8753a012ba93bdab90153', '402881882ba8753a012ba93a6743014c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93bfd150154', '2010-10-14 13:35:02', '2010-10-14 13:35:02', '南岸区', '402881882ba8753a012ba93a6743014c,402881882ba8753a012ba93bfd150154', '402881882ba8753a012ba93a6743014c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93c1b4c0155', '2010-10-14 13:35:10', '2010-10-14 13:35:10', '北碚区', '402881882ba8753a012ba93a6743014c,402881882ba8753a012ba93c1b4c0155', '402881882ba8753a012ba93a6743014c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93c3c800156', '2010-10-14 13:35:18', '2010-10-14 13:35:18', '万盛区', '402881882ba8753a012ba93a6743014c,402881882ba8753a012ba93c3c800156', '402881882ba8753a012ba93a6743014c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93c5a970157', '2010-10-14 13:35:26', '2010-10-14 13:35:26', '双桥区', '402881882ba8753a012ba93a6743014c,402881882ba8753a012ba93c5a970157', '402881882ba8753a012ba93a6743014c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93c793b0158', '2010-10-14 13:35:34', '2010-10-14 13:35:34', '渝北区', '402881882ba8753a012ba93a6743014c,402881882ba8753a012ba93c793b0158', '402881882ba8753a012ba93a6743014c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93c93790159', '2010-10-14 13:35:40', '2010-10-14 13:35:40', '巴南区', '402881882ba8753a012ba93a6743014c,402881882ba8753a012ba93c93790159', '402881882ba8753a012ba93a6743014c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93cacaf015a', '2010-10-14 13:35:47', '2010-10-14 13:35:47', '黔江区', '402881882ba8753a012ba93a6743014c,402881882ba8753a012ba93cacaf015a', '402881882ba8753a012ba93a6743014c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93cbc7d015b', '2010-10-14 13:35:51', '2010-10-14 13:35:51', '长寿区', '402881882ba8753a012ba93a6743014c,402881882ba8753a012ba93cbc7d015b', '402881882ba8753a012ba93a6743014c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93d1d3b015c', '2010-10-14 13:36:16', '2010-10-14 13:36:16', '江津市', '402881882ba8753a012ba93a6743014c,402881882ba8753a012ba93d1d3b015c', '402881882ba8753a012ba93a6743014c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93d3a0a015d', '2010-10-14 13:36:23', '2010-10-14 13:36:23', '合川市', '402881882ba8753a012ba93a6743014c,402881882ba8753a012ba93d3a0a015d', '402881882ba8753a012ba93a6743014c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93d53ad015e', '2010-10-14 13:36:30', '2010-10-14 13:36:30', '永川市', '402881882ba8753a012ba93a6743014c,402881882ba8753a012ba93d53ad015e', '402881882ba8753a012ba93a6743014c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93d6689015f', '2010-10-14 13:36:34', '2010-10-14 13:36:34', '南川市', '402881882ba8753a012ba93a6743014c,402881882ba8753a012ba93d6689015f', '402881882ba8753a012ba93a6743014c');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93d95780160', '2010-10-14 13:36:46', '2010-10-14 13:36:46', '四川省', '402881882ba8753a012ba93d95780160', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba93dc8110161', '2010-10-14 13:36:59', '2010-10-14 13:36:59', '成都市', '402881882ba8753a012ba93d95780160,402881882ba8753a012ba93dc8110161', '402881882ba8753a012ba93d95780160');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93df0d70162', '2010-10-14 13:37:10', '2010-10-14 13:37:10', '自贡市', '402881882ba8753a012ba93d95780160,402881882ba8753a012ba93df0d70162', '402881882ba8753a012ba93d95780160');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93e12980163', '2010-10-14 13:37:19', '2010-10-14 13:37:19', '攀枝花市', '402881882ba8753a012ba93d95780160,402881882ba8753a012ba93e12980163', '402881882ba8753a012ba93d95780160');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93e30ce0164', '2010-10-14 13:37:26', '2010-10-14 13:37:26', '泸州市', '402881882ba8753a012ba93d95780160,402881882ba8753a012ba93e30ce0164', '402881882ba8753a012ba93d95780160');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93e54a20165', '2010-10-14 13:37:35', '2010-10-14 13:37:35', '德阳市', '402881882ba8753a012ba93d95780160,402881882ba8753a012ba93e54a20165', '402881882ba8753a012ba93d95780160');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93e83820166', '2010-10-14 13:37:47', '2010-10-14 13:37:47', '绵阳市', '402881882ba8753a012ba93d95780160,402881882ba8753a012ba93e83820166', '402881882ba8753a012ba93d95780160');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93ea6d90167', '2010-10-14 13:37:56', '2010-10-14 13:37:56', '广元市', '402881882ba8753a012ba93d95780160,402881882ba8753a012ba93ea6d90167', '402881882ba8753a012ba93d95780160');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93ecaad0168', '2010-10-14 13:38:06', '2010-10-14 13:38:06', '遂宁市', '402881882ba8753a012ba93d95780160,402881882ba8753a012ba93ecaad0168', '402881882ba8753a012ba93d95780160');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93eeab80169', '2010-10-14 13:38:14', '2010-10-14 13:38:14', '内江市', '402881882ba8753a012ba93d95780160,402881882ba8753a012ba93eeab80169', '402881882ba8753a012ba93d95780160');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93f0c69016a', '2010-10-14 13:38:22', '2010-10-14 13:38:22', '乐山市', '402881882ba8753a012ba93d95780160,402881882ba8753a012ba93f0c69016a', '402881882ba8753a012ba93d95780160');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93f2d6e016b', '2010-10-14 13:38:31', '2010-10-14 13:38:31', '南充市', '402881882ba8753a012ba93d95780160,402881882ba8753a012ba93f2d6e016b', '402881882ba8753a012ba93d95780160');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93f551a016c', '2010-10-14 13:38:41', '2010-10-14 13:38:41', '眉山市', '402881882ba8753a012ba93d95780160,402881882ba8753a012ba93f551a016c', '402881882ba8753a012ba93d95780160');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93f7cf5016d', '2010-10-14 13:38:51', '2010-10-14 13:38:51', '宜宾市', '402881882ba8753a012ba93d95780160,402881882ba8753a012ba93f7cf5016d', '402881882ba8753a012ba93d95780160');
INSERT INTO `area` VALUES ('402881882ba8753a012ba93fec3a016e', '2010-10-14 13:39:20', '2010-10-14 13:39:20', '广安市', '402881882ba8753a012ba93d95780160,402881882ba8753a012ba93fec3a016e', '402881882ba8753a012ba93d95780160');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94017ed016f', '2010-10-14 13:39:31', '2010-10-14 13:39:31', '达州市', '402881882ba8753a012ba93d95780160,402881882ba8753a012ba94017ed016f', '402881882ba8753a012ba93d95780160');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94044e90170', '2010-10-14 13:39:42', '2010-10-14 13:39:42', '雅安市', '402881882ba8753a012ba93d95780160,402881882ba8753a012ba94044e90170', '402881882ba8753a012ba93d95780160');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94072810171', '2010-10-14 13:39:54', '2010-10-14 13:39:54', '巴中市', '402881882ba8753a012ba93d95780160,402881882ba8753a012ba94072810171', '402881882ba8753a012ba93d95780160');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94098d50172', '2010-10-14 13:40:04', '2010-10-14 13:40:04', '资阳市', '402881882ba8753a012ba93d95780160,402881882ba8753a012ba94098d50172', '402881882ba8753a012ba93d95780160');
INSERT INTO `area` VALUES ('402881882ba8753a012ba940dad00173', '2010-10-14 13:40:21', '2010-10-14 13:40:21', '贵州省', '402881882ba8753a012ba940dad00173', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba9410a9a0174', '2010-10-14 13:40:33', '2010-10-14 13:40:33', '贵阳市', '402881882ba8753a012ba940dad00173,402881882ba8753a012ba9410a9a0174', '402881882ba8753a012ba940dad00173');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94135f00175', '2010-10-14 13:40:44', '2010-10-14 13:40:44', '六盘水市', '402881882ba8753a012ba940dad00173,402881882ba8753a012ba94135f00175', '402881882ba8753a012ba940dad00173');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94157240176', '2010-10-14 13:40:53', '2010-10-14 13:40:53', '遵义市', '402881882ba8753a012ba940dad00173,402881882ba8753a012ba94157240176', '402881882ba8753a012ba940dad00173');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9418ece0177', '2010-10-14 13:41:07', '2010-10-14 13:41:07', '安顺市', '402881882ba8753a012ba940dad00173,402881882ba8753a012ba9418ece0177', '402881882ba8753a012ba940dad00173');
INSERT INTO `area` VALUES ('402881882ba8753a012ba941c0ea0178', '2010-10-14 13:41:20', '2010-10-14 13:41:20', '铜仁地区', '402881882ba8753a012ba940dad00173,402881882ba8753a012ba941c0ea0178', '402881882ba8753a012ba940dad00173');
INSERT INTO `area` VALUES ('402881882ba8753a012ba942a5200179', '2010-10-14 13:42:18', '2010-10-14 13:42:18', '毕节地区', '402881882ba8753a012ba940dad00173,402881882ba8753a012ba942a5200179', '402881882ba8753a012ba940dad00173');
INSERT INTO `area` VALUES ('402881882ba8753a012ba942d1dd017a', '2010-10-14 13:42:30', '2010-10-14 13:42:30', '云南省', '402881882ba8753a012ba942d1dd017a', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba9430c46017b', '2010-10-14 13:42:45', '2010-10-14 13:42:45', '昆明市', '402881882ba8753a012ba942d1dd017a,402881882ba8753a012ba9430c46017b', '402881882ba8753a012ba942d1dd017a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba943446d017c', '2010-10-14 13:42:59', '2010-10-14 13:42:59', '曲靖市', '402881882ba8753a012ba942d1dd017a,402881882ba8753a012ba943446d017c', '402881882ba8753a012ba942d1dd017a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9435797017d', '2010-10-14 13:43:04', '2010-10-14 13:43:04', '玉溪市', '402881882ba8753a012ba942d1dd017a,402881882ba8753a012ba9435797017d', '402881882ba8753a012ba942d1dd017a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9438109017e', '2010-10-14 13:43:14', '2010-10-14 13:43:14', '保山市', '402881882ba8753a012ba942d1dd017a,402881882ba8753a012ba9438109017e', '402881882ba8753a012ba942d1dd017a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba943a0b6017f', '2010-10-14 13:43:23', '2010-10-14 13:43:23', '昭通市', '402881882ba8753a012ba942d1dd017a,402881882ba8753a012ba943a0b6017f', '402881882ba8753a012ba942d1dd017a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba943c5070180', '2010-10-14 13:43:32', '2010-10-14 13:43:32', '丽江市', '402881882ba8753a012ba942d1dd017a,402881882ba8753a012ba943c5070180', '402881882ba8753a012ba942d1dd017a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba943e39b0181', '2010-10-14 13:43:40', '2010-10-14 13:43:40', '思茅市', '402881882ba8753a012ba942d1dd017a,402881882ba8753a012ba943e39b0181', '402881882ba8753a012ba942d1dd017a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94406360182', '2010-10-14 13:43:49', '2010-10-14 13:43:49', '临沧市', '402881882ba8753a012ba942d1dd017a,402881882ba8753a012ba94406360182', '402881882ba8753a012ba942d1dd017a');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94474040183', '2010-10-14 13:44:17', '2010-10-14 13:44:17', '西藏自治区', '402881882ba8753a012ba94474040183', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba9449a490184', '2010-10-14 13:44:26', '2010-10-14 13:44:26', '拉萨市', '402881882ba8753a012ba94474040183,402881882ba8753a012ba9449a490184', '402881882ba8753a012ba94474040183');
INSERT INTO `area` VALUES ('402881882ba8753a012ba944b7180185', '2010-10-14 13:44:34', '2010-10-14 13:44:34', '昌都地区', '402881882ba8753a012ba94474040183,402881882ba8753a012ba944b7180185', '402881882ba8753a012ba94474040183');
INSERT INTO `area` VALUES ('402881882ba8753a012ba944ea9b0186', '2010-10-14 13:44:47', '2010-10-14 13:44:47', '山南地区', '402881882ba8753a012ba94474040183,402881882ba8753a012ba944ea9b0186', '402881882ba8753a012ba94474040183');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94510440187', '2010-10-14 13:44:57', '2010-10-14 13:44:57', '日喀则地区', '402881882ba8753a012ba94474040183,402881882ba8753a012ba94510440187', '402881882ba8753a012ba94474040183');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94535210188', '2010-10-14 13:45:06', '2010-10-14 13:45:06', '那曲地区', '402881882ba8753a012ba94474040183,402881882ba8753a012ba94535210188', '402881882ba8753a012ba94474040183');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94554130189', '2010-10-14 13:45:14', '2010-10-14 13:45:14', '阿里地区', '402881882ba8753a012ba94474040183,402881882ba8753a012ba94554130189', '402881882ba8753a012ba94474040183');
INSERT INTO `area` VALUES ('402881882ba8753a012ba945741e018a', '2010-10-14 13:45:22', '2010-10-14 13:45:22', '林芝地区', '402881882ba8753a012ba94474040183,402881882ba8753a012ba945741e018a', '402881882ba8753a012ba94474040183');
INSERT INTO `area` VALUES ('402881882ba8753a012ba945a63a018b', '2010-10-14 13:45:35', '2010-10-14 13:45:35', '陕西省', '402881882ba8753a012ba945a63a018b', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba945dc2f018c', '2010-10-14 13:45:49', '2010-10-14 13:45:49', '西安市', '402881882ba8753a012ba945a63a018b,402881882ba8753a012ba945dc2f018c', '402881882ba8753a012ba945a63a018b');
INSERT INTO `area` VALUES ('402881882ba8753a012ba945fb7f018d', '2010-10-14 13:45:57', '2010-10-14 13:45:57', '铜川市', '402881882ba8753a012ba945a63a018b,402881882ba8753a012ba945fb7f018d', '402881882ba8753a012ba945a63a018b');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9461a80018e', '2010-10-14 13:46:05', '2010-10-14 13:46:05', '宝鸡市', '402881882ba8753a012ba945a63a018b,402881882ba8753a012ba9461a80018e', '402881882ba8753a012ba945a63a018b');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9463674018f', '2010-10-14 13:46:12', '2010-10-14 13:46:12', '咸阳市', '402881882ba8753a012ba945a63a018b,402881882ba8753a012ba9463674018f', '402881882ba8753a012ba945a63a018b');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94653240190', '2010-10-14 13:46:19', '2010-10-14 13:46:19', '渭南市', '402881882ba8753a012ba945a63a018b,402881882ba8753a012ba94653240190', '402881882ba8753a012ba945a63a018b');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9466f760191', '2010-10-14 13:46:27', '2010-10-14 13:46:27', '延安市', '402881882ba8753a012ba945a63a018b,402881882ba8753a012ba9466f760191', '402881882ba8753a012ba945a63a018b');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9468dbc0192', '2010-10-14 13:46:34', '2010-10-14 13:46:34', '汉中市', '402881882ba8753a012ba945a63a018b,402881882ba8753a012ba9468dbc0192', '402881882ba8753a012ba945a63a018b');
INSERT INTO `area` VALUES ('402881882ba8753a012ba946a6f10193', '2010-10-14 13:46:41', '2010-10-14 13:46:41', '榆林市', '402881882ba8753a012ba945a63a018b,402881882ba8753a012ba946a6f10193', '402881882ba8753a012ba945a63a018b');
INSERT INTO `area` VALUES ('402881882ba8753a012ba946c48b0194', '2010-10-14 13:46:48', '2010-10-14 13:46:48', '安康市', '402881882ba8753a012ba945a63a018b,402881882ba8753a012ba946c48b0194', '402881882ba8753a012ba945a63a018b');
INSERT INTO `area` VALUES ('402881882ba8753a012ba946de8c0195', '2010-10-14 13:46:55', '2010-10-14 13:46:55', '商洛市', '402881882ba8753a012ba945a63a018b,402881882ba8753a012ba946de8c0195', '402881882ba8753a012ba945a63a018b');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94704c10196', '2010-10-14 13:47:05', '2010-10-14 13:47:05', '甘肃省', '402881882ba8753a012ba94704c10196', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba94731dc0197', '2010-10-14 13:47:16', '2010-10-14 13:47:16', '兰州市', '402881882ba8753a012ba94704c10196,402881882ba8753a012ba94731dc0197', '402881882ba8753a012ba94704c10196');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9475b2e0198', '2010-10-14 13:47:27', '2010-10-14 13:47:27', '嘉峪关市', '402881882ba8753a012ba94704c10196,402881882ba8753a012ba9475b2e0198', '402881882ba8753a012ba94704c10196');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94777fd0199', '2010-10-14 13:47:34', '2010-10-14 13:47:34', '金昌市', '402881882ba8753a012ba94704c10196,402881882ba8753a012ba94777fd0199', '402881882ba8753a012ba94704c10196');
INSERT INTO `area` VALUES ('402881882ba8753a012ba947b94c019a', '2010-10-14 13:47:51', '2010-10-14 13:47:51', '白银市', '402881882ba8753a012ba94704c10196,402881882ba8753a012ba947b94c019a', '402881882ba8753a012ba94704c10196');
INSERT INTO `area` VALUES ('402881882ba8753a012ba947deb6019b', '2010-10-14 13:48:01', '2010-10-14 13:48:01', '天水市', '402881882ba8753a012ba94704c10196,402881882ba8753a012ba947deb6019b', '402881882ba8753a012ba94704c10196');
INSERT INTO `area` VALUES ('402881882ba8753a012ba947fc8e019c', '2010-10-14 13:48:08', '2010-10-14 13:48:08', '武威市', '402881882ba8753a012ba94704c10196,402881882ba8753a012ba947fc8e019c', '402881882ba8753a012ba94704c10196');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9481825019d', '2010-10-14 13:48:15', '2010-10-14 13:48:15', '张掖市', '402881882ba8753a012ba94704c10196,402881882ba8753a012ba9481825019d', '402881882ba8753a012ba94704c10196');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9483726019e', '2010-10-14 13:48:23', '2010-10-14 13:48:23', '平凉市', '402881882ba8753a012ba94704c10196,402881882ba8753a012ba9483726019e', '402881882ba8753a012ba94704c10196');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94852ad019f', '2010-10-14 13:48:30', '2010-10-14 13:48:30', '酒泉市', '402881882ba8753a012ba94704c10196,402881882ba8753a012ba94852ad019f', '402881882ba8753a012ba94704c10196');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94872c801a0', '2010-10-14 13:48:38', '2010-10-14 13:48:38', '庆阳市', '402881882ba8753a012ba94704c10196,402881882ba8753a012ba94872c801a0', '402881882ba8753a012ba94704c10196');
INSERT INTO `area` VALUES ('402881882ba8753a012ba9488fc601a1', '2010-10-14 13:48:46', '2010-10-14 13:48:46', '定西市', '402881882ba8753a012ba94704c10196,402881882ba8753a012ba9488fc601a1', '402881882ba8753a012ba94704c10196');
INSERT INTO `area` VALUES ('402881882ba8753a012ba948ba7f01a2', '2010-10-14 13:48:57', '2010-10-14 13:48:57', '陇南市', '402881882ba8753a012ba94704c10196,402881882ba8753a012ba948ba7f01a2', '402881882ba8753a012ba94704c10196');
INSERT INTO `area` VALUES ('402881882ba8753a012ba948f8ff01a3', '2010-10-14 13:49:13', '2010-10-14 13:49:13', '临夏回族自治州', '402881882ba8753a012ba94704c10196,402881882ba8753a012ba948f8ff01a3', '402881882ba8753a012ba94704c10196');
INSERT INTO `area` VALUES ('402881882ba8753a012ba949336801a4', '2010-10-14 13:49:28', '2010-10-14 13:49:28', '青海省', '402881882ba8753a012ba949336801a4', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba9495b0501a5', '2010-10-14 13:49:38', '2010-10-14 13:49:38', '西宁市', '402881882ba8753a012ba949336801a4,402881882ba8753a012ba9495b0501a5', '402881882ba8753a012ba949336801a4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94980ae01a6', '2010-10-14 13:49:48', '2010-10-14 13:49:48', '海东地区', '402881882ba8753a012ba949336801a4,402881882ba8753a012ba94980ae01a6', '402881882ba8753a012ba949336801a4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba949c59601a7', '2010-10-14 13:50:05', '2010-10-14 13:50:05', '海北藏族自治州', '402881882ba8753a012ba949336801a4,402881882ba8753a012ba949c59601a7', '402881882ba8753a012ba949336801a4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba949e5c101a8', '2010-10-14 13:50:13', '2010-10-14 13:50:13', '黄南藏族自治州', '402881882ba8753a012ba949336801a4,402881882ba8753a012ba949e5c101a8', '402881882ba8753a012ba949336801a4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94a097501a9', '2010-10-14 13:50:23', '2010-10-14 13:50:23', '海南藏族自治州', '402881882ba8753a012ba949336801a4,402881882ba8753a012ba94a097501a9', '402881882ba8753a012ba949336801a4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94a2df501aa', '2010-10-14 13:50:32', '2010-10-14 13:50:32', '果洛藏族自治州', '402881882ba8753a012ba949336801a4,402881882ba8753a012ba94a2df501aa', '402881882ba8753a012ba949336801a4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94a52b301ab', '2010-10-14 13:50:41', '2010-10-14 13:50:41', '玉树藏族自治州', '402881882ba8753a012ba949336801a4,402881882ba8753a012ba94a52b301ab', '402881882ba8753a012ba949336801a4');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94a847201ac', '2010-10-14 13:50:54', '2010-10-14 13:50:54', '宁夏回族自治区', '402881882ba8753a012ba94a847201ac', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba94aaf2b01ad', '2010-10-14 13:51:05', '2010-10-14 13:51:05', '银川市', '402881882ba8753a012ba94a847201ac,402881882ba8753a012ba94aaf2b01ad', '402881882ba8753a012ba94a847201ac');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94ad22401ae', '2010-10-14 13:51:14', '2010-10-14 13:51:14', '石嘴山市', '402881882ba8753a012ba94a847201ac,402881882ba8753a012ba94ad22401ae', '402881882ba8753a012ba94a847201ac');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94af62701af', '2010-10-14 13:51:23', '2010-10-14 13:51:23', '吴忠市', '402881882ba8753a012ba94a847201ac,402881882ba8753a012ba94af62701af', '402881882ba8753a012ba94a847201ac');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94b13c101b0', '2010-10-14 13:51:31', '2010-10-14 13:51:31', '固原市', '402881882ba8753a012ba94a847201ac,402881882ba8753a012ba94b13c101b0', '402881882ba8753a012ba94a847201ac');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94b2f4801b1', '2010-10-14 13:51:38', '2010-10-14 13:51:38', '中卫市', '402881882ba8753a012ba94a847201ac,402881882ba8753a012ba94b2f4801b1', '402881882ba8753a012ba94a847201ac');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94b61c201b2', '2010-10-14 13:51:51', '2010-10-14 13:51:51', '新疆维吾尔自治区', '402881882ba8753a012ba94b61c201b2', null);
INSERT INTO `area` VALUES ('402881882ba8753a012ba94b8e5001b3', '2010-10-14 13:52:02', '2010-10-14 13:52:02', '乌鲁木齐市', '402881882ba8753a012ba94b61c201b2,402881882ba8753a012ba94b8e5001b3', '402881882ba8753a012ba94b61c201b2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94bafb301b4', '2010-10-14 13:52:11', '2010-10-14 13:52:11', '克拉玛依市', '402881882ba8753a012ba94b61c201b2,402881882ba8753a012ba94bafb301b4', '402881882ba8753a012ba94b61c201b2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94bced401b5', '2010-10-14 13:52:19', '2010-10-14 13:52:19', '吐鲁番地区', '402881882ba8753a012ba94b61c201b2,402881882ba8753a012ba94bced401b5', '402881882ba8753a012ba94b61c201b2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94bf62201b6', '2010-10-14 13:52:29', '2010-10-14 13:52:29', '哈密地区', '402881882ba8753a012ba94b61c201b2,402881882ba8753a012ba94bf62201b6', '402881882ba8753a012ba94b61c201b2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94c14b601b7', '2010-10-14 13:52:37', '2010-10-14 13:52:37', '昌吉回族自治州', '402881882ba8753a012ba94b61c201b2,402881882ba8753a012ba94c14b601b7', '402881882ba8753a012ba94b61c201b2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94c3ffd01b8', '2010-10-14 13:52:48', '2010-10-14 13:52:48', '博尔塔拉蒙古自治州', '402881882ba8753a012ba94b61c201b2,402881882ba8753a012ba94c3ffd01b8', '402881882ba8753a012ba94b61c201b2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94cfd4201b9', '2010-10-14 13:53:36', '2010-10-14 13:53:36', '喀什地区', '402881882ba8753a012ba94b61c201b2,402881882ba8753a012ba94cfd4201b9', '402881882ba8753a012ba94b61c201b2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94d207901ba', '2010-10-14 13:53:45', '2010-10-14 13:53:45', '和田地区', '402881882ba8753a012ba94b61c201b2,402881882ba8753a012ba94d207901ba', '402881882ba8753a012ba94b61c201b2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94d427801bb', '2010-10-14 13:53:54', '2010-10-14 13:53:54', '伊犁哈萨克自治州', '402881882ba8753a012ba94b61c201b2,402881882ba8753a012ba94d427801bb', '402881882ba8753a012ba94b61c201b2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94d76b701bc', '2010-10-14 13:54:07', '2010-10-14 13:54:07', '克孜勒苏柯尔克孜自治州', '402881882ba8753a012ba94b61c201b2,402881882ba8753a012ba94d76b701bc', '402881882ba8753a012ba94b61c201b2');
INSERT INTO `area` VALUES ('402881882ba8753a012ba94dc00501bd', '2010-10-14 13:54:26', '2010-10-14 13:54:26', '台湾省', '402881882ba8753a012ba94dc00501bd', null);
INSERT INTO `area` VALUES ('7972fe1570e84415ae26f503242cc2a3', '2014-11-19 15:30:16', '2014-11-19 15:42:47', '中办', '402881882ba8753a012ba8bf474d001c,7972fe1570e84415ae26f503242cc2a3', '402881882ba8753a012ba8bf474d001c');
INSERT INTO `area` VALUES ('a5d950887793427ebfdea939362b837d', '2015-01-10 09:17:12', '2015-01-10 09:17:12', 'sfdsa', 'a5d950887793427ebfdea939362b837d', null);
INSERT INTO `area` VALUES ('ac0158aefab841618da0162f3d915530', '2015-01-10 09:16:10', '2015-01-10 09:16:10', 'fsdaf', 'ac0158aefab841618da0162f3d915530', null);
-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('402881862bee2228012bee26bc6b0001', '2010-10-27 22:45:37', '2015-01-04 14:26:17', 'admin', '<p>邮局汇款<br />工行<br />账号：xxxxxxxx <br />收&nbsp; 款&nbsp; 人：xxxxxxxxxxxx有限公司 <br />农行 <br />账号：xxxxxxxx<br />收&nbsp; 款&nbsp; 人：xxxxxxxxxxxx有限公司 <br />支付宝<br />账号：xxxxxxxx <br />收&nbsp; 款&nbsp; 人：xxxxxxxxxxxx有限公司 <br />财付通<br />账号：xxxxxxxx <br />收&nbsp; 款&nbsp; 人：xxxxxxxxxxxxx有限公司</p>\r\n<p>邮局汇款说明：<br />1、邮局汇款是客户将订单金额通过邮局汇到商城的一种结算支付方式。<br />2、选择此方式支付货款的客户，请您在下单后尽快到邮局进行汇款，汇款完毕后，请务必进入订单信息页面填写汇款确认（3日内未填写付款确认的订单会被系统自动移除）。<br />3、货款到账时间一般为款汇出后的1-3个工作日内，收到货款后我司会尽快为您发货。 <br />汇款单填写范例：</p>\r\n<p>&nbsp;<br />注意事项：<br />(1)请在汇款种类选择：商务汇款，并填写相应的商务账号； <br />(2)请在汇款单的&ldquo;附言&rdquo;处注明订单号和收货人姓名，以加快订单汇款确认速度； <br />(3)付款后请务必进入&ldquo;订单中心&rdquo;填写付款确认。</p>', '7', '/html/article_content/201010/9028537042de4f8da39bf312ac43ba3b.html', '', '', '', null, null, '1', '邮局汇款', '402881882ba8455f012ba86aa5c60002');
INSERT INTO `article` VALUES ('402881862bee2228012bee29789d0002', '2010-10-27 22:48:36', '2015-01-04 14:26:26', 'admin', '<p>网上支付<br />小贴示：您付款成功后务必及时通知我们，以便我们能及时为您发货。</p>\r\n<p>&nbsp;</p>\r\n<p>网上支付应注意如下事项：</p>\r\n<p>尽量避免在网吧等公共场所的计算机上使用网上支付。如必须在公共场所的计算机上使用，注意对输入的卡号、密码等信息的保护，支付完毕请及时清空浏览器及电脑上的记录。</p>\r\n<p>在使用图形密码键盘输入密码时，请注意周围环境，谨防被旁人窥视。</p>\r\n<p>在支付页面上，请注意核对地址栏中的交行域名和在激活时预留的核验信息，以防误入假冒网站。</p>\r\n<p>在激活网上支付时，推荐选用支付卡号。使用个性化的支付卡号，可有效避免网上支付过程中银行卡号的泄露。</p>\r\n<p>为信用卡开通网上支付功能时，请注意不要设置过于简单、易猜测的网上支付密码。</p>', '21', '/html/article_content/201010/fd97e448663c4f5a8f033743328a8038.html', '', '', '', '网上支付', '网上支付', '1', '网上支付', '402881882ba8455f012ba86aa5c60002');
INSERT INTO `article` VALUES ('402881882ba8753a012ba883e8b20002', '2010-10-14 10:13:58', '2015-01-04 14:21:24', 'admin', '<div>\r\n<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"700\">\r\n<tbody>\r\n<tr>\r\n<td>\r\n<p>&nbsp;</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td>\r\n<div>\r\n<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"680\">\r\n<tbody>\r\n<tr>\r\n<td>\r\n<p>&nbsp;</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td>\r\n<p>&nbsp;</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td>\r\n<p><strong>一、挑选商品</strong><br /><br /><strong>二、放入购物车（立即购买）</strong><br /><br /><strong>三、提交订单（进入结算中心）</strong></p>\r\n<p>1、用户登录、注册<br />如果您未在商城注册登录过，可选择&ldquo;注册&rdquo;；<br />如果您已是商城注册会员，直接&ldquo;登录&rdquo;即可。<br />小贴士：注册只需花费您一分钟时间，并且注册用户享受更多优惠。</p>\r\n<p>2、填写收货人信息<br />为了保证您的商品顺利送达目的地，请准确填写收货人的姓名、地址、邮编、电话等有效信息；<br />需要发票的用户，请在备注里注明发票台头，商城所开发票均为正规发票，所开金额均为订单的实际金额（不包括运费），当月订单请在当月补开发票，过期不受理，如有退换货需将发票一起寄回。</p>\r\n<p>3、选择送货方式<br />根据您所在的地区填写送货方式。运费价格及范围请参见&ldquo;配送费用收取标准&rdquo;。</p>\r\n<p>4、选择支付方式<br />我们提供的支付方式有：支付宝、财付通、货到付款，网上银行支付，邮局汇款和邮局网汇通汇款等。</p>\r\n<p>5、确认订单，并提交<br />完成上述所有流程后，您可以点击&ldquo;确认无误 提交订单&rdquo;按钮，订单提交后页面会提示订单号，进入&ldquo;个人中心&rdquo;即可查询订单状态。</p>\r\n<p>&nbsp;</p>\r\n<p><strong>四、立即付款<br /></strong>订单提交成功后，请按照您所选择的付款方式立即支付；下单后，订单将保留三天，三天后若仍未付款将自动取消。</p>\r\n<p>&nbsp;</p>\r\n<p><strong>五、收货和评价<br /></strong>正常情况下，到货时间一般3-5天不等（除天气灾害等延误）。<br />收到货后，请对我们的商品进行评价哦！</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</div>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</div>', '14', '/html/article_content/201010/9102600e47b7401b843ad3722e1e9b70.html', '', '', '\0', '新手购物流程', '购物,流程', '1', '购物流程', '402881882ba8455f012ba86db8560006');
INSERT INTO `article` VALUES ('402881882ba8753a012ba88eb79a0003', '2010-10-14 10:25:46', '2015-01-04 14:21:32', 'admin', '<p>会员定期巡检制度</p>\r\n<p>一、目的 <br />为确保网站注册会员资料和会员发布信息的真实可靠性，特制定本制度。</p>\r\n<p>二、人员安排及巡检职责&nbsp;&nbsp; <br />1. 内容主管对整个平台负全责，巡检人员负责整个网站注册会员资料和会员发布信息的检查、审核、激活。网络信息安全管理小组负责管理各信息审核员，并对经信息审核员审核通过的内容进行监管。<br />2. 如巡检人员缺勤，则部门主管须及时安排其他人员巡检。节假日，须安排值班人员巡检会员信息。&nbsp; <br />3. 巡检周期为：当天全面检查，一周抽查一次，一月普查一次。</p>\r\n<p>三、巡检细则&nbsp;&nbsp; <br />1. 会员注册资料检查&nbsp; <br />1.1. 每天下班前全面检查当天注册的会员资料，如果发现注册资料中包含有害、虚假、诽谤或中伤他人的信息，马上予以删除。<br />1.2. 每周五对一周的注册信息进行抽查，每个月底对一个月的注册信息抽查一次，主要以搜索特定关键字为主。</p>\r\n<p>2. 会员在网站上发布的信息检查&nbsp; <br />2.1. 会员发布的企业和产品信息：<br />2.1.1. 巡检人员当天检查，审核通过后才在网站前台显示。<br />2.1.2. 审核没有通过，如果原因是不够完善，及时告知会员补充完整；如果信息本身包含有害、虚假、诽谤或中伤他人的内容，直接予以删除。<br />2.2. 会员发布的供求等商业信息：<br />2.2.1. 巡检人员根据信息发布的频率，定期检查，一般15分钟检查一次。&nbsp; <br />2.3. 检查到会员发布的信息本身包含有害、虚假、诽谤或中伤他人等内容，直接予以删除。</p>\r\n<p>3. 纠错举报处理&nbsp; <br />网站上设置纠错举报用联系方式，该联系人每天查收相关邮件或接听相关电话，及时处理用户反映的会员信息问题，仔细求证，及时回复。</p>\r\n<p>四、巡检要点 <br />1. 关键时段检查：每日上午开始上班30分钟内完成会员注册资料和会员发布信息的第一遍检查。下午离下班前30分钟左右开始最后一遍检查。</p>\r\n<p>2. 按频率检查：部门主管根据需要，设置巡检频率。巡检人员根据巡检频率对会员发布的信息进行检查与维护。</p>\r\n<p>3. 巡检内容：包括所有注册会员资料和会员在网站上发布的各种信息。删除有害信息、虚假、重发、滥发等信息。<br />3.1. 有害信息：网站发布的各类信息必须严格遵守《中华人民共和国计算机信息网络国际联网管理暂行规定》、《互联网信息服务管理办法》等有关国家政策、法规规定。会员不得编辑和传播下列信息：</p>\r\n<p>（一）反对宪法所确定的基本原则的；</p>\r\n<p>（二）危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；</p>\r\n<p>（三）损害国家荣誉和利益的；</p>\r\n<p>（四）煽动民族仇恨、民族歧视，破坏民族团结的；</p>\r\n<p>（五）破坏国家宗教政策，宣扬邪教和封建迷信的；</p>\r\n<p>（六）散布谣言，扰乱社会秩序，破坏社会稳定的；</p>\r\n<p>（七）散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的；</p>\r\n<p>（八）侮辱或者诽谤他人，侵害他人合法权益的；</p>\r\n<p>（九）含有法律、行政法规禁止的其他内容的。</p>\r\n<p><br />巡检人员可用关键字检索（必要时请用模糊检索方法检索栏目信息）。发现有害信息，请快速作好信息备份（保留原始记录：所发内容、用户IP、登陆时间、注册时间、最后访问时间），并且对该ID所有帖子进行逐个审核，然后立即删除有害信息，并上报部门主管。部门主管须通过技术手段：黑名单控制+定期的数据库检查（一周）, 处理此类信息。如情节严重者，部门主管须通过信息网络安全管理小组上报管理机关！</p>\r\n<p>3.2. 虚假信息：发布内容明显与事实不符的信息；&nbsp;</p>\r\n<p>3.3. 诽谤、中伤他人的信息：信息中出现恶意辱骂某公司或个人的字眼，此类信息常出现在论坛和专家等交互式栏目中。如有此类信息，巡检人员在活跃人气的同时须正确引导，若情节严重则立即删除；</p>\r\n<p>3.4. 与栏目不符的信息：信息内容与栏目主旨（即栏目名称或子栏目名称）不符或欠符合的信息。&nbsp;</p>\r\n<p>3.5. 重发、滥发的信息：同条信息一个栏目中只准发布一次，并且只准被发布到一个栏目或子栏目下，否则都视为重发；屡次重发且每次每一条被重发的信息数量都在5条以上的，或屡次长时间重发，每次一发就是5分钟以上的，都视为滥发。巡检人员只需保留最新一条，其余删除。必要时，加入黑名单屏蔽其发布功能；</p>\r\n<p>3.6 乱码信息：在页面上呈现为乱码的信息。在排除网站自身技术问题后，应立即删除或修正此类信息。&nbsp;</p>\r\n<p>本制度解释权归xxxx有限公司所有</p>\r\n<p>&nbsp;</p>\r\n<p>网上隐私保护制度</p>\r\n<p>第一条 为促进电子商务健康发展，加强信息共建共享，推进网上隐私权保护制度化、规范化，切实维护网民的权利，根据相关规定，制定本制度。</p>\r\n<p>第二条 鉴于网络的特性，为了使用户正确有效地使用网站的功能与服务，并便于向用户提供优质高效的服务，网站会提示用户进行注册、填写表单等方式提交其个人资料。<br />公司服务部门根据栏目要求，对信息进行审核。如发现用户提交的资料存在虚假、违法内容，相关工作人员可删除该资料并终止该用户的服务。<br />公司技术部须使用相应技术，对用户所提供的资料进行严格的管理和保护，防止个人资料丢失、被盗用或遭窜改。</p>\r\n<p>第三条 公司服务部门可通过技术手段实现用户自行阅览、补充、修改、删除其资料的功能，或根据用户要求，提供相关服务。</p>\r\n<p>第四条 在未经用户同意及确认之前，公司不得将用户所提供的个人资料提供给第三方。除非当政府机关依照法定程序要求本网站披露个人资料时，本网站将根据执法单位之要求或为公共安全之目的提供个人资料。</p>\r\n<p>第五条 公司服务部须在网站页面提示&ldquo;隐私权保护声明&rdquo;（如附件），说明网站对用户个人信息所采取的收集、使用和保护政策。</p>\r\n<p>本制度最终解释权属xxxx有限公司所有。</p>\r\n<p>&nbsp;</p>\r\n<p>附：xxx私权保护声明</p>\r\n<p>xxx隐私权保护声明</p>\r\n<p>xxx（以下称&ldquo;本网站&rdquo;）隐私权保护声明系本网站保护用户个人隐私的承诺。鉴于网络的特性，本网站将无可避免地与您产生直接或间接的互动关系，故特此说明本网站对用户个人信息所采取的收集、使用和保护政策，请您务必仔细阅读：</p>\r\n<p>一、搜集、分拣信息<br />当您浏览、阅读或下载本网站的信息时，网站会自动搜集和分拣到您的信息（互联网域名、用户使用的浏览器和操作系统类型、访问时间、访问页面），这些信息不会被用来确定您的身份。</p>\r\n<p>二、个人资料及披露 <br />当您在本网站进行用户注册登记、参加有关活动时，在您的同意并确认下，本网站会通过注册表格、订单等形式要求您提供一些个人资料。<br />个人资料包括但不限于姓名、性别、年龄、地址、邮编、电话、传真、电子邮件。您必须保证提供资料的准确、真实、有效和完整。我们保留随时删除虚假个人资料并终止服务的权利 。<br />收集个人资料是为了使您正确的使用xxx的功能与服务，并便于我们向您提供优质高效的服务。</p>\r\n<p>在未经您同意及确认之前，本网站不会将您所提供的个人资料利用于上述外的其它目的。除非当政府机关依照法定程序要求本网站披露个人资料时，本网站将根据执法单位之要求或为公共安全之目的提供个人资料。在此情况下之任何披露，本网站均得免责。</p>\r\n<p>三、信息安全&nbsp; <br />本网站将使用相应的技术，对您所提供的个人资料进行严格的管理和保护，防止个人资料丢失、被盗用或遭窜改。为保护个人信息，必要时本网站会委托专业技术人员对所述资料进行相应处理，并将处理安排及时通知您，若您未在通知规定的时间内主动明示反对，本网站将推定您已同意。但处理过后，您仍然有权请求停止电脑处理。</p>\r\n<p>四、用户权利<br />在本网站上，您对自己拥有的个人资料享有以下权利：<br />（一）随时查询及请求阅览；<br />（二）随时请求补充或更正；<br />（三）随时请求删除； <br />（四）请求停止电脑处理及利用。&nbsp; <br />您可通过联系电话（8888- 88888888）提出请求，本网站会为您提供相关服务。</p>\r\n<p>五、限制利用原则&nbsp; <br />本网站惟在符合下列条件之一，方对收集之个人资料进行必要范围以外之利用： <br />（一）已取得您的书面同意；<br />（二）为免除您在生命、身体或财产方面之急迫危险； <br />（三）为防止他人权益之重大危害； <br />（四）为增进公共利益，且无损于您的重大利益。</p>\r\n<p>六、披露个人资料&nbsp; <br />当政府机关依照法定程序要求本网站披露个人资料时，本网站将根据其要求或为了公共安全的目的提供个人资料；这种情况下的任何披露，本网站均得免责。</p>\r\n<p>七、公共论坛&nbsp; <br />本网站为您提论坛、咨询等服务。在这些区域内，您公布的任何信息都会成为公开的信息。因此，我们提醒并请您慎重考虑是否有必要在这些区域公开您的个人信息。</p>\r\n<p>八、Cookies使用原则 <br />Cookies是指一种技术，当使用者访问设有Cookies装置的本网站时，本网站之服务器会自动发送Cookies至阁下浏览器内，并储存到您的电脑硬盘内，此Cookies便负责记录日后您到访本网站的种种活动、个人资料、浏览习惯、消费习惯甚至信用记录。运用Cookies技术，本网站能够为您提供更加周到的个性化服务。本网站将会运用Cookies储存密码，以便您造访本网站时不必每次重复输入密码。</p>\r\n<p>九、免责 <br />除上述有关免责规定外，下列情况时本网站亦无需承担任何责任： <br />（一）由于您将用户密码告知他人或与他人共享注册帐户，由此导致的任何个人信息的泄露。<br />（二）任何由于黑客政击、计算机病毒侵入或发作、因政府管制而造成的暂时性关闭等影响网络正常经营之不可抗力而造成的个人信息泄露、丢失、被盗用或被窜改等。&nbsp; <br />（三）由于本网站不拥有或不控制的公司以及我们不雇佣或不管理的人员所造成的个人信息的泄露及由此而导致的任何法律争议和后果。<br />（四）由于与本网站链接的其它网站所造成之个人资料泄露及由此而导致的任何法律争议和后果。</p>\r\n<p>本网站隐私权保护申明的修改及更新权均属于xxx。</p>\r\n<p>&nbsp;</p>\r\n<p>网站投诉兴报咨询处制度</p>\r\n<p>第一条 为促进电子商务健康发展，加强信息共建共享，推进网上投诉举报制度化、规范化，切实维护网民的知情权、参与权、表达权，根据相关规定，制定本制度。</p>\r\n<p>第二条 网上投诉举报受理职能由嘉兴市麦包包皮具有限公司服务部承担，行政部门主管。<br />技术部负责网上投诉举报系统维护、更新和升级。</p>\r\n<p>第三条 各网站设客服人员负责投诉举报咨询受理工作，部门主管为监督员，并指定专人具体负责办理。</p>\r\n<p>第四条 对投诉举报信息的处理，坚持实事求是、公正公开和廉洁高效原则。</p>\r\n<p>第五条 处理咨询信息的时限为1个工作日，投诉举报信息时限为2个工作日。情况复杂的，经本部门负责人同意，可适当延长处理时限，但最多不超过5个工作日。</p>\r\n<p>第六条 受理人在对投诉举报信息汇总分类后，按照职责分工，及时分送相关负责人。 <br />对非本网站的投诉举报信息，受理人应转送相关部门，或退回投诉举报人并说明理由。</p>\r\n<p>第七条 相关责任人收到分送的投诉举报信息后，应及时组织核查。</p>\r\n<p>第八条 各部门或相关人员应当积极支持和配合核查工作，并如实提供相关材料。</p>\r\n<p>第九条 责任人根据核查情况，提出答复意见，并登记备案，同时通过电话、信函或电子邮件方式回复投诉举报人。</p>\r\n<p>第十条 客服人员定期将投诉举报咨询处理情况汇总上报部门领导，并通报有关部门及人员。</p>\r\n<p>本制度最终解释权属xxxx有限公司所有。</p>', '66', '/html/article_content/201010/90eb7634990341909027a5e20245b3e1.html', '', '', '\0', '会员应遵守的网站制度', '制度', '3', '网站制度', '402881882ba8455f012ba86db8560006');
INSERT INTO `article` VALUES ('402881882ba8753a012ba891884e0004', '2010-10-14 10:28:51', '2015-01-04 14:21:39', 'admin', '<p>登陆后，进入&ldquo;个人中心&rdquo;可查询到订单状态。</p>\r\n<p>1、未确认/未付款：订单尚未获得确认，正常工作时间内，最迟2小时可以获得确认，如非正常工作时间，需要等到上班时间确认。</p>\r\n<p><br />2、已确认/未付款：订单已获得确认，请按照确认后的总金额付款，付款完毕后可返回&ldquo;个人中心&rdquo;查看订单状态，银行汇款的用户需要提交汇款信息，内容为：交易流水号、汇款时间、 汇入行、汇入卡号、汇款金额共５项。系统自动保留订单期限为3天，超过3天未付款的订单，系统会自动将订单取消。</p>\r\n<p>&nbsp;<br />3、已付款/待发货：这时订单已在我们工作人员的处理流程中。</p>\r\n<p><br />4、已发货/待收货：您的货物已经发出，请您稍后注意查收，订单详细中可查到快递公司和快递单号。</p>\r\n<p>&nbsp;<br />5、交易成功：订单已成功完成交易，请对我们的商品进行评论，如收到产品有质量问题，请直接与售后部门联系。</p>', '16', '/html/article_content/201010/50588403d9dd494c9035fa763e49e112.html', '', '', '\0', '订单的状态', '订单', '1', '订单查询', '402881882ba8455f012ba86db8560006');
INSERT INTO `article` VALUES ('402881882ba8753a012ba892f6160005', '2010-10-14 10:30:25', '2015-01-04 14:21:49', 'admin', '<p>问：<strong>商城所售商品都是正品行货吗？有售后保修吗？</strong></p>\r\n<p>答：商城所售商品都是正品行货，均自带机打发票。凭商城发票，所有商品都可以享受生产厂家的全国联保服务。商城将严格按照国家三包政策，针对所售商品履行保修、换货和退货的义务。您也可以到商城任一分公司售后部享受售后服务。</p>\r\n<p>问：<strong>购买的商品能开发票？如果是公司购买，可以开增值税发票吗？</strong></p>\r\n<p>答：商城所售商品都是正品行货，每张订单均自带中文机打的&ldquo;商品专用发票&rdquo;，此发票可用作单位报销凭证。 发票会随包裹一同发出，发票金额含配送费金额。<br />企业客户在提供《一般纳税人证书》、《营业执照》、《税务登记证》、《开户许可证》四类证件复印件后，可向开取增值税发票，开好后，商城会以快递方式为您寄出。</p>\r\n<p>问：<strong>无货商品什么时候能到货？</strong></p>\r\n<p>答：无货商品的到货时间根据配货情况而不同，无法准确估计，但您可以使用&ldquo;到货通知&rdquo;功能，一旦商品有货，我们会通过电子邮件等方式通知您。</p>\r\n<p>问：<strong>下单后何时可以收到货？</strong></p>\r\n<p>答：在商品有现货的情况下，北京、上海、广州客户，下单后一般24小时内可收到货（郊区县配送时间可能会更长一些）；<br />其它地区用户，将根据您的收货地址及所选择的配送方式而不同，一般到货时间在1-7天（极偏远地区配送时间可能会更长一些）；<br />如果商品处于预订或在途状态，那么还应加上调配货时间。</p>\r\n<p>问：<strong>在线支付支持哪些银行卡？支持大额支付吗？</strong></p>\r\n<p>答：我们为您提供几乎全部银行的银行卡及信用卡在线支付，只要您开通了&ldquo;网上支付&rdquo;功能，即可进行在线支付，无需手续费，实时到帐，方便快捷。（如客户原因取消订单退款，则需要客户承担1%平台手续费）如您订单金额较大，可以使用快钱支付中的招行、工行、建行、农行、广发进行一次性大额支付（一万元以下）。</p>\r\n<p>问：<strong>下单时可以指定送货时间吗？</strong></p>\r\n<p>答：可以，您下单时可以选择&ldquo;只工作日送货(双休日、假日不用送)&rdquo;、&ldquo;工作日、双休日与假日均可送货&rdquo;、&ldquo;只双休日、假日送货(工作日不用送)&rdquo;等时间类型，并选择是否提前电话确认。<br />另外，您还可以在订单备注里填写更具体的需求，我们会尽量满足您的要求。</p>\r\n<p>问：<strong>收货时发现问题可以拒收吗？</strong></p>\r\n<p>答：在签收货物时如发现货物有损坏，请直接拒收退回我公司，相关人员将为您重新安排发货。</p>\r\n<p>问：<strong>如果我刚刚下单商品就降价了，能给我补偿吗？</strong></p>\r\n<p>答：商城的商品价格随市场价格的波动每日都会有涨价、降价或者优惠等变化。如果下完订单后价格发生了变化，可到&ldquo;我的商城&rdquo;自主申请价格保护。</p>\r\n<p>问：<strong>下单后，我能做什么？</strong></p>\r\n<p>答：如果是在线支付方式，请您尽快完成付款，待付款被确认后我们会立即为您发货，如果选择自提或货到付款，您可以进入&ldquo;个人中心&rdquo;，在&ldquo;订单列表&rdquo;中找到您的订单，然后可随时查看订单处理状态，做好收货或者上门自提的准备。<br />在您成功购物后，您还可以发表商品评价，向其他用户分享商品使用心得。</p>\r\n<p>问：<strong>为什么我无法登陆商城？</strong></p>\r\n<p>答：首先要检查您的用户名、密码是否正确，确认您的浏览器是否支持COOKIE。</p>\r\n<p>问：<strong>产品如何保修？</strong></p>\r\n<p>答：商城销售的商品都以商品说明中的保修承诺为准。</p>\r\n<p>问：<strong>订单得到确认后我该做什么？</strong></p>\r\n<p>答：按照订单所提示的实际应汇款金额，汇款至该订单所在的公司账号内，汇款交易成功后，登陆&ldquo;个人中心&rdquo;查看您的订单，在订单中的&ldquo;汇款备注&rdquo;中输入您的相关汇款信息(例如：汇入行、汇入我司银行账号的实际金额、汇款日期和汇入账号、订单号等），等待我司财务人员确认汇款。</p>\r\n<p>问：<strong>汇款确认后多久能够将货物发出？</strong></p>\r\n<p>答：正常情况下会在工作时间24-48小时内可以将您的货物发出。</p>\r\n<p>问：<strong>非商品自身质量问题是否可以退货？</strong></p>\r\n<p>答：部分商品在不影响二次销售的情况下，加收一定的退货手续费，是可以办理退货的，详情请查看&ldquo;退换货政策&rdquo;</p>\r\n<p>问：<strong>在哪进行在线支付？</strong></p>\r\n<p>答：在商城首页的&ldquo;会员登录&rdquo;中输入用户名和密码进行登陆，登陆后点击&ldquo;个人中心&rdquo;，进入 &ldquo;在线支付&rdquo;，点击进入后就可以进行在线支付了。</p>\r\n<p>问：<strong>工作时间？</strong></p>\r\n<p>答：客服中心受理热线电话及订单处理时间为周一至周日9：00&mdash;24：00。<br />注：如遇国家法定节假日，则以商城新闻发布放假时间为准，请大家届时关注。</p>\r\n<p>问：<strong>如何将退款打回银行卡？</strong></p>\r\n<p>答：在投诉中心留言相关信息，如银行卡的开户行(详细到支行）、开户姓名、卡号，相关人员会为您处理，退款周期视您的货物是否发出而定，如果货物未出库发出，退款会在三个工作日内完成；如果货物已发出，则需货物返回我司物流中心后为您办理退款。</p>\r\n<p>问：<strong>商品包装问题？</strong></p>\r\n<p>答：我公司所发送商品均由专人进行打包，商品在未签收前都由我公司负责，如在收到商品时发现包装有破损或是其它方面问题，请直接致电我公司客服，客服人员会帮您解决。</p>\r\n<p>问：<strong>订单付款后，如果长时间未收到货，我是否可以申请办理退款？</strong></p>\r\n<p>答：非商城快递覆盖区域内，由第三方快递公司负责直接送达的订单，如圆通快递，自发货时间算起超过10天仍未收到货或收货地址超出第三方快递覆盖的区域，由第三方快递转邮政，如圆通转EMS等，自发货时间算起超过20天仍未收到货，可致电客服中心，由客服人员为您申请办理退款事宜。</p>\r\n<p>问：<strong>如果我有问题或建议是否可以通过邮件向你们反馈？</strong></p>\r\n<p>答：可以。商城受理建议或投诉的邮箱是：*****@***.com。</p>', '11', '/html/article_content/201010/cb4b35cc2fd14ddbb20b49d7637fab2f.html', '', '', '\0', '常见的问题解决方法', '问题', '2', '常见问题', '402881882ba8455f012ba86db8560006');
INSERT INTO `article` VALUES ('402881882ba8753a012ba895ec630006', '2010-10-14 10:33:39', '2015-01-04 14:22:05', 'admin', '<p><span style=\"color: #a604fa;\"><strong>1.</strong><strong>如何获得发票 </strong></span></p>\r\n<p>（1）商城所售商品都是正品行货，每张订单均自带中文机打的&ldquo;商品专用发票&rdquo;，此发票可用作单位报销凭证，下单时可自助开取。</p>\r\n<p>（2）一个包裹对应一张发票，不同的物流中心发出的包裹开具不同的发票，发票会随每次包裹一同发出。</p>\r\n<p>（3）发票金额含配送费金额。</p>\r\n<p><span style=\"color: #a604fa;\"><strong>2.</strong> <strong>设置发票信息 </strong></span></p>\r\n<p>&ldquo;订单确认&rdquo;页面点击发票信息旁边的&ldquo;修改&rdquo;，可以修改发票类型（普通发票、增值税发票）、发票抬头（个人、公司），发票内容（明细、办公用品、电脑配件、耗材），发票抬头内容不能为空，您可选择个人或公司名称。</p>\r\n<p>内容：除数码类、手机及配件、笔记本、台式机、家电类商品以外，发票内容可以选择商品明细、办公用品、电脑配件及耗材。建议您将发票内容开具为产品明细，否则您将无法享受产品厂商的正常质保</p>\r\n<p><span style=\"color: #a604fa;\"><strong>3. </strong><strong>开发票的注意事项 </strong></span></p>\r\n<p>（1）发票金额不能高于订单金额。</p>\r\n<p>（2）如果您购买的是数码类、手机及配件、笔记本、台式机、家电类商品，为了保证您能充分享受生产厂家提供的售后服务（售后服务需根据发票确认您的购买日期），不管您是否需要开具发票，我们都将随单为您开具，发票内容默认为您订购的商品全称，同时不支持修改发票内容。</p>\r\n<p>（3）不同物流中心开具的发票无法合并。</p>\r\n<p>（4）使用优惠券支付的金额不开具发票；订单中使用50元（含50元）以下的余额，不开具发票，积分商品不提供发票。</p>\r\n<p><span style=\"color: #a604fa;\"><strong>4. </strong><strong>换发票 </strong></span></p>\r\n<p>您在收到发票后如果发现因商城原因所致票据抬头、内容或金额错误，您可致电客服，由客服人员为您办理换发票事宜，往返快递费用由商城承担，否则不能办理您因商品保修而要求更换发票的事宜。</p>', '11', '/html/article_content/201010/82c2ffe3f0234a6ba2aed4727a75a19a.html', '', '', '\0', '有关发票', '发票', '1', '发票制度说明', '402881882ba8455f012ba86db8560006');
INSERT INTO `article` VALUES ('402881882ba8753a012ba89858fe0007', '2010-10-14 10:36:18', '2015-01-04 14:22:16', 'admin', '<p>纯属个人爱好,主要为丰富Java开源商城。</p>\r\n<p><span style=\"font-size: medium;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></p>\r\n<p><span style=\"font-size: medium;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></p>', '29', '/html/article_content/201010/070088f2df794b26b03bdf022565f1f2.html', '', '', '', '公司简介', '公司', '1', '关于我们', '402881882ba8455f012ba86db8560006');
INSERT INTO `article` VALUES ('402881882ba8753a012ba89c3fc60008', '2010-10-14 10:40:33', '2015-01-04 14:22:53', 'admin', '<p><strong>退换货说明</strong></p>\r\n<p>(一)&nbsp;商城承诺：自用户收到商品之日起（以快递面单签收时间为准），按以下标准提供退换货服务：<br />&nbsp;&nbsp;1.&nbsp;七天内无理由退换货，运费由商城承担；<br />&nbsp;&nbsp;2.&nbsp;一个月内质量问题退换货，运费由商城承担；<br />&nbsp;&nbsp;3.&nbsp;三个月内免费维修，运费由客户承担。</p>\r\n<p>&nbsp;</p>\r\n<p>(二)&nbsp;退货时务必要把所有相关商品的附件（防尘袋、 包装塑料纸、销售单等等）都寄回，且务必填写退货小帖示，告知用户名（Email）、订单号、退款账号、及退货原因等等。</p>\r\n<p>&nbsp;</p>\r\n<p>(三)&nbsp;换货操作：A商品换B商品时，请将B商品编号及颜色在销售退货单中注明，不必申请退款，最后以B-A差额多退少补。</p>\r\n<p>&nbsp;</p>\r\n<p>(四)&nbsp;注明退换货原因，如果商品存在质量问题，请务必说明；</p>\r\n<p>&nbsp;</p>\r\n<p>(五)&nbsp;符合退换货要求的订单，不要用平邮方式寄回、不支持到付。</p>\r\n<p>&nbsp;</p>\r\n<p>(六)&nbsp;收到用户寄回的商品后，我们将在3个工作日内办理退换货或者退款。</p>\r\n<p>&nbsp;</p>\r\n<p>(七)&nbsp;以下情况不予办理退换货：<br />&nbsp;&nbsp;1.&nbsp;任何非商城官方网站出售的商品；<br />&nbsp;&nbsp;2.&nbsp;因非正常使用或保管不当导致出现质量问题的商品（包括但不限于：用锋利的物品把商品划伤，因放置于高温物体旁引起的变形等。</p>\r\n<p>&nbsp;</p>\r\n<p>(八)&nbsp;促销活动的产品，需按活动规则办理退换货。</p>\r\n<p><br /><strong>注意事项</strong></p>\r\n<p>1.&nbsp;采用用支付宝支付的订单，需要您登录支付宝官网申请退款，我们才能办理退款。<br />2.&nbsp;采用其他方式支付的订单，需要您提供接收退款的银行信息：银行账号、姓名、开户行名称。<br />3.&nbsp;如果所支付的订单中含有非现金部分（如优惠券、积分等），在退款时，非现金部分不能折现。</p>\r\n<p><br /><strong>联系方式</strong><br />售后服务邮箱：<a href=\"mailto:jfinalshop@163.com\">JFinalShop@163.com</a></p>\r\n<p><br /><strong>退货地址</strong><br />退换货地址：XX省XX市<br />收货人：商城售后服务中心</p>', '18', '/html/article_content/201010/ac6f0b7c351c41058dc800ea0091e26c.html', '', '\0', '\0', null, null, '1', '退货政策', '402881882ba8455f012ba86db8560006');
INSERT INTO `article` VALUES ('402881882ba8753a012ba89e2b5a0009', '2010-10-14 10:42:39', '2015-01-04 14:23:27', 'admin', '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 会员等级共分四级，具体为：<span style=\"color: #ff0000;\"><strong>普通会员、高级会员、白金会员、钻石会员</strong></span>等级升降均由系统自动实现，无需申请。<br />&nbsp;<br /><span style=\"color: #ff0000;\">普通会员：</span><br />申请条件：任何愿意到商城购物的用户都可以免费注册。<br />待　　遇：可以享受注册会员所能购买的产品及服务。</p>\r\n<p><span style=\"color: #ff0000;\">高级会员：</span><br />申请条件：一年内消费积分超过5000（含）的会员。<br />待　　遇：可以享受高级会员级别所能购买的产品及服务。</p>\r\n<p><span style=\"color: #ff0000;\">白金会员：</span><br />申请条件：一年内消费积分超过10000（含）的会员。<br />待　　遇：可以享受白金会员级别所能购买的产品及服务。</p>\r\n<p><span style=\"color: #ff0000;\">钻石会员：</span></p>\r\n<p>申请条件：一年内消费积分超过50000（含），需填写本人真实的身份证号码进行升级<br />待　　遇：可以享受钻石会员级别所能购买的产品及服务。</p>\r\n<p>&nbsp;</p>\r\n<p>注：针对各个等级会员特别声明： <br />会员账号禁止转借或转让他人使用，如因转借或转让他人使用所带来的一切后果，商城概不负责，如被商城发现有转借或转让使用情况，商城则有权立即取消此会员账号的相应等级资格。 <br />如商城发现相应的等级中有经销商，则商城有权立即取消此会员帐号的相应等级资格。</p>', '29', '/html/article_content/201010/0340b92488ca464aa8d545fb899dcd25.html', '', '', '\0', '会员等级', '会员等级', '1', '会员等级', '402881882ba8753a012ba87a518e0001');
INSERT INTO `article` VALUES ('402881882ba8753a012ba89f4296000a', '2010-10-14 10:43:51', '2015-01-04 14:23:48', 'admin', '<p>以下是商城为您提供服务的条款。我们希望您遵守以下的规定，加入会员之前请仔细阅读下列条款.，如果您同意请按 \"同意条款\"按钮。本协议详述您使用我们的服务所须遵守的条款和条件。如您有任何疑问，请及时联系我们。<br /><br />一、会员注册：<br />1.费用：在商城注册是完全免费的!<br />2. 资料填写：<br />1）提供准确，真实，有效的个人资料；如果会员提供的资料包含有不正确的信息，本站保留结束会员使用网络服务资格的权利。<br />2）如个人资料有任何变动，必须及时修改会员个人信息。<br />3）允许本网站不定时向您的电子邮箱发送各种信息；<br />3. 会员的帐号，密码和安全性 <br />1）会员将对会员名和密码安全以及用其会员名进行的所有活动和事件负全责。<br />2）会员若发现任何非法盗用会员帐号或存在安全漏洞的情况，请立即通告本站。<br /><br />二、 有以下行为的会员将被取消会员资格<br />（1） 违反注册条款<br />（2） 提供虚假个人资料<br />（3） 会员有损商城利益的行为<br />（4） 违反中国的法律、法规、违反互联网相关规定的行为<br />（5） 将会员帐号用于出售、拍卖等，当作商品进行交易的行为<br />（6） 出借、转让 会员帐号给其他会员等不恰当行使会员权利的行为<br />（7） 通过盗取密码、诈骗等不正当手段获得会员帐号的行为<br />（8） 不遵守商城的货到付款政策<br /><br />三、 会员隐私制度：<br />商城重视对会员隐私保护，尊重会员个人隐私是本站的一项基本政策。您提供的登记资料及本网站保留的有关您的若干其他个人资料将受到中国有关隐私的法律保护<br />（1）为了尊重会员，商城一定不会在未经会员同意授权的情况下公开、编辑及透露会员的个人信息。<br />（2）商城不公开会员个人信息，除以下情况外：<br />l - 会员授权本站透露这些信息。<br />l - 相应法律及程序要求本站提供会员个人资料。<br />l - 在紧急情况下竭力维护会员个人和社会大众隐私安全。<br />l - 符合其他相关要求。 <br /><br />四、交易：<br />会员在商城进行物品购买时必须遵守以下条款：<br />（1） 订单、价格和付款 <br />产品或服务价格、付款条件和配送在订单中以书面形式明确约定为准。<br />（2） 所有权和风险 <br />产品所有权和风险在产品交付买方或其指定收货人时转移给买方。<br />（3）常规保证 <br />a．质量保证<br />我们出售的商品与您亲临商场选购商品时享受同样质量保证。如果发现商品短缺、配送错误、破损等问题，请您当时向配送员指出，并立即与客服中心联系，过后不予受理此类问题。在顾客收到商品3天之内发现质量问题，可以安排退换货服务，如果更换过商品再次出现质量问题，可再提供退换服务。<br />b. 退换货处理<br />详见&ldquo;客服中心&rdquo;退换货政策<br />（4）其他<br />本商城有权在发现了网站上显现的产品及订单的明显错误的情况下，单方面撤回该信息或撤销订单。在下订单的同时，您应该对订单中提供的所有信息的真实性负责。 <br /><br />五、知识产权声明：</p>\r\n<p>商城提供的所有内容，如文字、图片、图像、视频、软件等都是本商城财产。同时，本商城相关著作权、专利权、商标及其它任何所有权或权利，均属本商城所有，受中国《商标法》、《著作权法》和国际版权法等相关法律的保护。除非中国法律另有规定，未经本商城的同意，任何企业或个人均无权复制、下载、传输、再造本网站任何内容，也不得提供给第三者使用，否则应负所有法律责任。违反上述声明而给本公司造成损失的，本公司将依法追究其法律责任。<br /><br />六、免责声明：<br />商城有义务在技术上确保商城的正常运行，尽力避免服务中断或将中断时间限制在最短时间内，保证会员网上交易活动的顺利进行。但以下情况，本商城无需承担任何责任：<br />（1）由于您将会员密码告知他人或与他人共享注册账户，由此导致任何个人资料泄露，本商城不承担责任；&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; （2）任何由于黑客攻击、计算机病毒侵入或发作、因政府管理而造成暂时性关闭等影响网络正常经营之不可抗力而造成本网站崩溃或无法正常使用导致网上交易无法完成或丢失有关的信息、记录等，本商城不承担责任；<br />（3）任何会员向本商城提供错误、不完整、不实信息等造成不能正常使用本网服务或遭受任何其他损失，概与本网无关。</p>', '12', '/html/article_content/201010/c55109104bb241c7a51605602b1531df.html', '', '', '', '会员注册协议', '协议', '2', '会员注册协议', '402881882ba8753a012ba87a518e0001');
INSERT INTO `article` VALUES ('402881882ba8753a012ba8a156a1000b', '2010-10-14 10:46:07', '2010-10-28 09:33:08', '李世民', '<p>会员积分：是凸显会员身份的一种象征，积分越多所体现其会员身份越尊贵，其所享受到的优惠越多。<br />赠送积分类商品：部分商品中标注赠送积分，购买此类商品，可获得相应赠送积分，此类商品为赠送积分类商品。</p>\r\n<p><span style=\"color: #ff0000;\">一、积分的获得：</span></p>\r\n<p><span style=\"color: #33cccc;\">赠送积分：</span><br />在商城中部分商品设有积分项，购买赠送积分的商品后，商城系统会对客户的积分进行增加并逐次累积。</p>\r\n<p><span style=\"color: #33cccc;\">商品评价：</span><br />使用商品评价功能，如有价值我们将给与相应的积分奖励；商城举办的活动也可能会有积分赠送。</p>\r\n<p>1、所有评价一律由系统自动赠送积分，无效评价不给分。只能对在半年内购买的商品进行评价；赠品可以评价但不赠送积分。<br />2、购买时间相差超过15日的不同订单中的相同商品，可以分别评价并获得积分；同一订单或相隔15日内订单中的相同商品，只有一次评价可以获得积分。<br />3、根据不同会员级别和产品价格，商城产品评价积分赠予列表：<br />请您提高评价质量，以下评价一律不再赠送积分：<br />1）拷贝自己或者他人评价内容超过80%以上，以字数为准。<br />2）优点、缺点内容重复超过60%以上的。<br />3）使用标点符号过多的。 <br />4）评价内容没有任何参考价值、被5名以上网友举报或者违反法律、法规的。<br />5）无效评价数量超过5条，则一年内该id号参与的产品评价均不赠送积分，过往的无效评价可以不计！</p>\r\n<p>4、如果您的商品评价是质量较优，经验性或者技术性较强或者是回复最多的热评，系统将推荐到首页，所有被推荐到首页的产品评价，系统会自动额外赠送至少50个积分！字数较多，质量较优，经验性或者技术性的首页热评贴将会获得高达200个积分（额外赠送）！</p>\r\n<p>5、回复问答贴奖励积分，购买过当前商品的会员回复问答贴可获得积分奖励，每次回复可得1个积分，同一问题每人最多可获得1个积分，同一商品每人最多有10个问答贴可以获得积分，每位会员一天最多可获得100积分。另外，每个问题的前20位回复者才有资格获得积分。</p>\r\n<p><span style=\"color: #ff0000;\">二、购买积分：</span><br />会员可以购买积分，即：将商城的余额转换为积分。人民币与积分的对换比例为1：10，即人民币1元可以购买10个积分。积分只可以单向购买，即人民币可以购买积分，但积分不可以兑换现金。</p>\r\n<p><span style=\"color: #ff0000;\">三、运费返还：</span><br />下订单时系统自动计算运费，发货过程中若实际运费低于系统自动计算的运费，我公司会将多出的运费以积分的形式返还到您的商城账户中。（1元人民币＝10个积分，遇&ldquo;分&rdquo;则四舍五入。例如：实际运费多收取了1.58元，则返还积分16分；实际运费多收取了1.32元，则返还积分13分。）</p>\r\n<p><span style=\"color: #ff0000;\">四、积分的使用及规则：</span></p>\r\n<p>您所购商品属于赠送积分类的商品，在办理退、换货时，会根据您购买时赠送的积分进行扣除。如您的积分不足，我们将会在您的退款金额中减去相应的金额，按照1：10的比例进行折算。即1元抵10个积分；</p>\r\n<p>积分查询： 每位客户在您自己账户中的&ldquo;个人中心--我的积分&rdquo;中可查询到您的积分详细情况。</p>\r\n<p>注：积分规则由商城制定并保留所有的解释权和修改权，规则以网站公布为准。</p>', '7', '/html/article_content/201010/390aed8de096473aa3fd928c25bf9fb9.html', '', '', '\0', '会员获得积分', '积分', '1', '积分说明', '402881882ba8753a012ba87a518e0001');
INSERT INTO `article` VALUES ('402881882ba8753a012ba8a62fd7000c', '2010-10-14 10:51:25', '2015-01-04 14:24:00', 'admin', '<p>&nbsp;</p>\r\n<p style=\"color: #f09;\">工行B2C网上支付使用说明</p>\r\n<p style=\"color: #f09;\">什么是工行网上银行在线支付？</p>\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B2C网上支付业务是指企业（卖方）与个人（买方）通过因特网上的电子商务网站进行交易时，工行为商户提供网上资金结算服务的一种业务。目前B2C在线支付系统是专门为拥有工行牡丹信用卡、灵通卡、贷记卡、活折或&ldquo;理财金帐户&rdquo;卡账户，并开通网上银行的个人客户进行网上购物所开发的支付平台，其信誉度较高。</p>\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;客户在工行特约购物网站选定货物后，根据网站提示或链接，去虚拟收银台付款。支付方式选择工行网上银行在线支付，客户将被带到工行网上支付页面，订单信息加密传递到工行网站且不可更改。客户只需根据画面提示，使用U盾或口令卡及相应密码，确认提交即可。</p>\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;网上支付适用于全国范围的工行账户实时支付，不须再到邮局汇款、不须使用现金支付。网上支付也不须要向商户网站提供支付卡号、卡密码与身份证件号等个人信息，最后支付时链接至工行支付页面支付，保证了客户的个人信息不被商户或外界获取，所以更安全、快捷、方便。</p>\r\n<p style=\"color: #f09;\">如何使用工行网上支付？</p>\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当您在商城网站，最后选择工行网上银行在线支付，将直接链入工行网站支付页面，只要输入工行网上银行已注册的任意卡号或&ldquo;e通卡&rdquo;，并输入密码（U盾客户客户，输入U盾密码；口令卡客户输入口令卡坐标和网银登陆密码），提交即可。提交后系统会提示网上支付是否成功，如果失败则提示失败原因。一旦您支付提交后将不能修改，您的帐户立即被扣款。如果您还不是工行网上银行的用户，您可以至工行任一网点办理注册开户。注册成功后，即可使用工行网上支付。</p>\r\n<p><strong>能够使用工行网上支付功能的分以下二种：</strong></p>\r\n<p>1、动态口令卡客户</p>\r\n<p>（1）携带本人有效证件及注册网上银行时使用的牡丹卡前往工商银行任何一个储蓄所，提交网上银行业务申请单（原已在柜台办理过网银业务的客户请填写变更单申领口令卡），并向柜台申明开通&ldquo;电子商务&rdquo;功能。</p>\r\n<p>（2）首次支付前，先登陆工行网上银行&ldquo;个人网上银行登录&rdquo;修改网银登录密码为数字和字母的组合，并激活口令卡(查看电子口令卡使用介绍)</p>\r\n<p>（3）单笔支付限额500元，每日累计支付限额1000元</p>\r\n<p>（4）已开通手机短信认证的的口令卡，单笔支付限额2000元，每日累计支付限额5000元（什么是手机短信认证？）</p>\r\n<p>（5）口令卡可使用1000次，之后需要前往柜台重新申领。</p>\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注意：</p>\r\n<p>1、您领到电子口令卡后，首次进行B2C交易，必须要先登录网银一次，才能正常使用B2C交易。</p>\r\n<p>2、U盾客户</p>\r\n<p>（1）携带本人有效证件及注册网上银行时使用的牡丹卡前往工商银行任何一个储蓄所，提交网上银行业务申请单</p>\r\n<p>（2）首次支付前，先登陆工行网上银行安装驱动、下载证书</p>\r\n<p>（3）U盾客户不受交易限额控制，可享受24小时大额转账汇款等各种服务，只要您是工行个人网上银行客户，携带本人有效证件及注册网上银行时使用的牡丹卡到工行营业网点就可以申请U盾。</p>\r\n<p style=\"color: #39f;\">使用U盾有三个步骤：</p>\r\n<p>第一步：安装驱动程序</p>\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如果您是第一次在电脑上使用个人网上银行，请参照工行个人网上银行系统设置指南首先调整您的计算机设置，然后安装U盾驱动程序，不同品牌U盾的驱动程序只能用于本品牌。如果您希望用光盘安装，请运行U盾光盘，选择安装主页面的&ldquo;系统升级&rdquo;，系统会自动检测并提示您安装补丁。安装补丁后，请选择&ldquo;驱动程序安装&rdquo;，安装U盾驱动程序。</p>\r\n<p>第二步：下载证书信息</p>\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;申请U盾后，您可以委托工行网点柜员协助您下载个人证书信息到U盾体内，也可以登录工行个人网上银行，进入&ldquo;客户服务-个人客户证书自助下载&rdquo;，完成证书信息下载。下载前请确认U盾已连接到电脑USB接口上。如果下载不成功，请到柜面办理。</p>\r\n<p>第三步：开心使用U盾</p>\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;您在登录个人网上银行之后，只要按系统提示将U盾插入电脑的USB接口，输入U盾密码，并经银行系统验证无误，即可完成支付业务。</p>\r\n<p>分步图解：</p>\r\n<p><strong>一、登录工商银行网站www.icbc.com.cn，</strong>点击&ldquo;个人网上银行登录&rdquo;下方的&ldquo;安装&rdquo;。</p>\r\n<p><img src=\"http://localhost/upload/image/201010/442f81d9af8f43a2bb1958a7d970817e.jpg\" alt=\"\" width=\"554\" height=\"256\" /></p>\r\n<p><strong>二、下载安装安全控件、安装工行根证书、安装证书驱动程序、下载个人客户证书</strong></p>\r\n<p><img src=\"http://localhost/upload/image/201010/3ed521007dc945baac2b7ad73a8ebc57.jpg\" alt=\"\" width=\"337\" height=\"518\" /></p>\r\n<p><strong>三、什么是登录密码与U盾密码？</strong></p>\r\n<p>登录密码就是客户在登录个人网上银行时使用的密码。</p>\r\n<p>U盾密码是在您登陆个人网上银行在&ldquo;U盾管理&rdquo;栏下载证书时输入的密码。</p>\r\n<p>为简化操作，客户在柜面注册网上银行时只设置一个初始密码，客户首次登录网上银行，系统会要求客户对登录密码进行修改，这样客户的账户资金将更为安全。</p>\r\n<p>客户登录个人网上银行后，随时可以在&ldquo;客户服务&rdquo;栏目中对登录密码进行修改。客户如果忘了登录密码，可以携带本人的有效身份证件及注册卡，到银行办理重置网上银行密码。</p>\r\n<p><strong>四、在线支付的手续费是如何计算的？ </strong></p>\r\n<p>使用工行网上银行在线支付在商城网站购物的，银行不收取用户任何手续费。</p>\r\n<p><strong>五、安全小锦囊 </strong></p>\r\n<p>1、请谨记工行官方网站地址为www.icbc.com.cn，统一客户服务热线为95588，中国移动统一短信服务号码为95588和106573095588，中国联通统一短信服务号码为95588和1065595588。</p>\r\n<p>2、提高防范意识，注意保管个人资料</p>\r\n<p>（1）保护好自己的银行卡密码、存折密码、电子银行密码（口令）、U盾密码等重要信息，不要在计算机、电话、手机或其他电子设备上记录或保留；在任何情况下，银行工作人员都不会向客户索要密码，请您注意勿向他人（包括银行人员）泄露，不要相信陌生人的短信、电话、邮件等。</p>\r\n<p>（2）各类密码的设置原则是&ldquo;本人易记别人难猜&rdquo;，避免使用与本人明显相关的信息（如姓名、生日、常用电话号码、身份证件号码等）或具有明显规律性的字符（如重复或连续的数字或字母）作为密码；办理电子银行业务的密码应不同于其他用途的密码（如银行卡/存折密码 、其他网站会员密码），并做到经常更换。</p>\r\n<p>（3）妥善保管与办理电子银行业务相关的各项重要资料，如身份证件、银行卡、存折、U盾、电子银行口令卡等，不得交给他人保管。不要在不信任的网站或其他场所留下卡号、存折账号、身份证号、常用电话号码等个人信息，防止被他人利用。</p>\r\n<p>3、充分利用&ldquo;预留验证信息&rdquo;服务，您可在网银或银行网点设置您的预留信息，使用网银时，务必进行核对，只有在页面显示的信息与您预留的信息一致才可进行后续操作。</p>\r\n<p>操作步骤</p>\r\n<p><img src=\"http://localhost/upload/image/201010/fc495574b3564b42b40a44be718f3556.jpg\" alt=\"\" width=\"650\" height=\"190\" /></p>\r\n<p>4、采取有效措施（如安装防病毒软件和网络防火墙）保护用于办理网上银行业务的计算机等电子设备的安全。</p>\r\n<p>5、防范假网站五大招</p>\r\n<p>第一招 做好防病毒工作，经常使用我行提供的&ldquo;小e安全检测&ldquo;进行检查。</p>\r\n<p>第二招 使用U盾，如果您申请使用U盾，每次使用后从计算机上拨掉U盾，做好U盾的保管，不用担心假网站等各种风险。</p>\r\n<p>第三招 核对正确网址，建议您好手工输入正确网址登陆工行网站和购物网站，不要使用他人提供的各种链接。在使用工行网上支付时，留意核对工行网上支付页面的网址是否正确，工行网上支付页面的网址以https://b2c.icbc.com.cn开头。</p>\r\n<p>第四招 验证预留信息，如不一致辞应立即停止操作。</p>\r\n<p>每五招 查看安全锁，工行个人网银页面都经过SSL加密处理，在网上支付页面上会显示一个&ldquo;挂锁&rdquo;图形的安全证书标识。点击挂锁，有以下信息：已将此站点标识为：b2c.icbc.com.cn。</p>', '4', '/html/article_content/201010/47532f706bf94c9ebb23a87a99424072.html', '', '', '\0', '工商网银付款说明', '工商网银付款说明', '3', '工商网银付款说明', '402881882ba8455f012ba86aa5c60002');
INSERT INTO `article` VALUES ('402881882bbdfe19012bbe91497e0013', '2010-10-18 17:00:14', '2015-01-04 14:25:59', 'admin', '<p><strong>官方网站：</strong><a href=\"http://www.jfinalshop.com\">http://www.jfinalshop.com</a></p>\r\n<p><strong>官方论坛：</strong><a href=\"http://bbs.jfinalshop.com\">http://bbs.jfinalshop.com</a></p>\r\n<p>&nbsp;</p>\r\n<p><strong>技术中心</strong></p>\r\n<p>QQ：614204367</p>\r\n<p>技术E-mail：<a href=\"mailto:jfinalshop@163.com\">JFinalShop@163.com</a></p>', '26', '/html/article_content/201010/5010509a555548939840a3103d3cea71.html', '', '', '', null, null, '1', '联系我们', '402881882ba8455f012ba86db8560006');
-- ----------------------------
-- Records of articlecategory
-- ----------------------------
INSERT INTO `articlecategory` VALUES ('402881882ba8455f012ba86aa5c60002', '2010-10-14 09:46:23', '2010-10-27 22:33:15', '在线支付、网上转账、汇款等', '支付', '支付方式', '2', '402881882ba8455f012ba86aa5c60002', null);
INSERT INTO `articlecategory` VALUES ('402881882ba8455f012ba86db8560006', '2010-10-14 09:49:44', '2010-10-27 22:33:23', '解决一些常见问题', '帮助，解决', '帮助中心', '3', '402881882ba8455f012ba86db8560006', null);
INSERT INTO `articlecategory` VALUES ('402881882ba8753a012ba87a518e0001', '2010-10-14 10:03:30', '2010-10-27 22:33:07', '会员的享有的活动及需要了解相关制度', '会员', '关于会员', '1', '402881882ba8753a012ba87a518e0001', null);
-- ----------------------------
-- Records of deliverycorp
-- ----------------------------
INSERT INTO `deliverycorp` VALUES ('402881862b9e7507012b9e7d64fc0007', '2010-10-12 11:30:39', '2010-10-28 01:07:22', '圆通快递', '0', 'http://www.yto.net.cn');
INSERT INTO `deliverycorp` VALUES ('402881882ba8753a012ba8b49033000f', '2010-10-14 11:07:07', '2010-10-28 01:07:27', '全球邮政快递', '0', 'http://www.ems.com.cn');
INSERT INTO `deliverycorp` VALUES ('402881882ba8753a012ba8b5a82b0010', '2010-10-14 11:08:18', '2010-10-28 01:07:32', '顺丰速运', '0', 'http://www.sf-express.com');
INSERT INTO `deliverycorp` VALUES ('402881882ba8753a012ba8b603990011', '2010-10-14 11:08:42', '2010-10-28 01:07:37', '韵达快递', '0', 'http://www.yundaex.com');
INSERT INTO `deliverycorp` VALUES ('402881882ba8753a012ba8b64d060012', '2010-10-14 11:09:01', '2010-10-28 01:07:42', '申通快递', '0', 'http://www.sto.cn');
INSERT INTO `deliverycorp` VALUES ('402881882ba8753a012ba8b68a2e0013', '2010-10-14 11:09:16', '2010-10-28 01:07:47', '中通速递', '0', 'http://www.zto.cn');
INSERT INTO `deliverycorp` VALUES ('402881882ba8753a012ba8b6cc480014', '2010-10-14 11:09:33', '2010-10-28 01:07:52', '天天快递', '0', 'http://www.ttkdex.com');
INSERT INTO `deliverycorp` VALUES ('402881882ba8753a012ba8b7502e0016', '2010-10-14 11:10:07', '2010-10-28 01:07:56', '宅急送', '0', 'http://www.zjs.com.cn');
-- ----------------------------
-- Records of deliverytype
-- ----------------------------
INSERT INTO `deliverytype` VALUES ('402881862b9e7507012b9e7e24540008', '2010-10-12 11:31:28', '2010-10-27 22:46:27', '1', '5.00000', '1', '0', '<p>配送时间：3-5天（配送时间自发货之日算起，实际送达时间，以投递方通知为准。）</p>\r\n<p>配送范围： 全国范围（除港澳台）</p>', '1', '10.00000', '1', 'EMS', '0', '402881882ba8753a012ba8b49033000f');
INSERT INTO `deliverytype` VALUES ('402881862b9f9e78012b9f9fe5a30001', '2010-10-12 16:47:57', '2015-01-07 16:16:01', '1', '5.00000', '1', '0', '<p>配送时间：1-4天（配送时间自发货之日算起，实际送达时间以投递方通知为准。）</p>\r\n<p>配送范围：只可投递到您所选择城市的市区范围内，周边及下属县市、乡镇将无法投递。</p>\r\n<p>&nbsp;</p>\r\n<p>qq</p>', '1', '15.00000', '1', '快递公司', '1', '402881862b9e7507012b9e7d64fc0007');
INSERT INTO `deliverytype` VALUES ('402881882ba8753a012ba8bc6582001a', '2010-10-14 11:15:40', '2015-01-07 16:16:10', '1', '0.00000', '1', '0', '<p>配送时间：10-15天（配送时间自发货之日算起，实际送达时间以投递方通知为准。）</p>\r\n<p>配送范围： 全国范围（除港澳台）qq</p>', '1', '0.00000', '1', '普通快速（免费）', '2', '402881882ba8753a012ba8b5a82b0010');
-- ----------------------------
-- Records of deposit
-- ----------------------------
INSERT INTO `deposit` VALUES ('19ce420124424da4afc63efa8f3323a2', '2014-12-12 16:05:51', null, '9919.00', '0.00', '81.00', '4', '402881862bf08f18012bf0a16b7c0010');
INSERT INTO `deposit` VALUES ('1a11edb8aa6e4581990af82318ed91d8', '2014-12-12 11:24:12', null, '100.00', '100.00', '0.00', '2', '60a825648b30481b80d010c1d96c1dac');
INSERT INTO `deposit` VALUES ('3f22fb32824c4b959143ba9148020837', '2014-12-12 14:43:15', null, '500.00', '400.00', '0.00', '2', '150c791333b24223b4e12bf0fe1730e6');
INSERT INTO `deposit` VALUES ('4021bac587fd4be1ad19d45a2fcc95d0', '2014-12-15 10:48:20', null, '623.00', '0.00', '17.00', '4', '150c791333b24223b4e12bf0fe1730e6');
INSERT INTO `deposit` VALUES ('49d96d31246546afa061733204860f92', '2014-12-12 16:05:34', null, '10000.00', '10000.00', '0.00', '2', '402881862bf08f18012bf0a16b7c0010');
INSERT INTO `deposit` VALUES ('5399c19c283f4664af6985b96a5bf8d8', '2014-12-15 14:23:20', null, '618.00', '0.00', '81.00', '4', '150c791333b24223b4e12bf0fe1730e6');
INSERT INTO `deposit` VALUES ('631c2f029a1a45328e14e22b4a4970cb', '2014-12-12 15:48:42', null, '652.00', '0.00', '148.00', '4', '150c791333b24223b4e12bf0fe1730e6');
INSERT INTO `deposit` VALUES ('8624fe20895a43c28cd044dbd5a81950', '2014-12-15 14:17:09', null, '699.00', '76.00', '0.00', '2', '150c791333b24223b4e12bf0fe1730e6');
INSERT INTO `deposit` VALUES ('8a4031fd0de044658570f4ce8569c79f', '2014-12-12 15:40:46', null, '204.00', '0.00', '148.00', '4', '150c791333b24223b4e12bf0fe1730e6');
INSERT INTO `deposit` VALUES ('8e9356539e1f40e58ee4fa1acaa7c82e', '2014-12-12 14:42:01', null, '100.00', '100.00', '0.00', '2', '150c791333b24223b4e12bf0fe1730e6');
INSERT INTO `deposit` VALUES ('8fb347a98f01446eafaad592c5518a0b', '2014-12-12 16:10:08', null, '9762.00', '0.00', '76.00', '4', '402881862bf08f18012bf0a16b7c0010');
INSERT INTO `deposit` VALUES ('9f24d1e15ead4578a7c3566e582e626d', '2014-12-12 11:35:06', null, '100.00', '0.00', '100.00', '2', '60a825648b30481b80d010c1d96c1dac');
INSERT INTO `deposit` VALUES ('a1a701faae684ff48e77dba6a1dd887d', '2014-12-12 11:35:44', null, '300.00', '200.00', '0.00', '2', '60a825648b30481b80d010c1d96c1dac');
INSERT INTO `deposit` VALUES ('a36dfb0619e74aeebd28b064efa7434c', '2014-12-12 16:02:19', null, '640.00', '0.00', '12.00', '4', '150c791333b24223b4e12bf0fe1730e6');
INSERT INTO `deposit` VALUES ('afdf2243a2f14d6c9da57a4964099823', '2014-12-12 16:07:21', null, '9838.00', '0.00', '81.00', '4', '402881862bf08f18012bf0a16b7c0010');
INSERT INTO `deposit` VALUES ('b6eeaffe45524e139d5590d1fdf4eae5', '2014-12-15 14:15:00', null, '623.00', '76.00', '0.00', '2', '150c791333b24223b4e12bf0fe1730e6');
INSERT INTO `deposit` VALUES ('bf8af5fac0914fc283dea8fdcb1760d7', '2014-12-12 14:43:56', null, '352.00', '0.00', '148.00', '4', '150c791333b24223b4e12bf0fe1730e6');
INSERT INTO `deposit` VALUES ('c673e5391d774e7499027576da06317a', '2014-12-12 15:47:05', null, '800.00', '744.00', '0.00', '2', '150c791333b24223b4e12bf0fe1730e6');
INSERT INTO `deposit` VALUES ('d38d7f9b1f774a1f9c568f0caddc8662', '2014-12-12 15:42:42', null, '56.00', '0.00', '148.00', '4', '150c791333b24223b4e12bf0fe1730e6');
INSERT INTO `deposit` VALUES ('e3f72e1ce4e243f9aa82704c459d8c8d', '2014-12-15 13:46:22', null, '547.00', '0.00', '76.00', '4', '150c791333b24223b4e12bf0fe1730e6');
INSERT INTO `deposit` VALUES ('ef7b7e80f6fd48dcadeb27792eb1d93f', '2014-12-12 11:24:39', null, '200.00', '100.00', '0.00', '2', '60a825648b30481b80d010c1d96c1dac');
-- ----------------------------
-- Records of dicts
-- ----------------------------
INSERT INTO `dicts` VALUES ('1', '1', '删除', 'activity', 'isDelete', '');
INSERT INTO `dicts` VALUES ('2', ' 0', '禁用(false)', 'menu', 'isEnabled', '');
INSERT INTO `dicts` VALUES ('3', '1', '启用(true)', 'menu', 'isEnabled', '');
INSERT INTO `dicts` VALUES ('4', '1', '删除', 'packet', 'isDelete', '');
-- ----------------------------
-- Records of footer
-- ----------------------------
INSERT INTO `footer` VALUES ('1', '1899-12-30 01:00:00', '2010-10-28 00:17:27', '<ul>\r\n<li><a>关于商城</a>|</li>\r\n<li><a>帮助中心</a>|</li>\r\n<li><a>网站地图</a>|</li>\r\n<li><a>诚聘英才</a>|</li>\r\n<li><a>联系我们</a>|</li>\r\n<li><a>版权说明</a></li>\r\n</ul>\r\n<ul>\r\n<p>Copyright &copy; 2014 JFinalShop. All rights reserved. <a title=\"开源中国\" href=\"http://www.oschina.net\" target=\"_blank\">开源中国</a></p>\r\n<p>Powered by JFinal<span class=\"systemName\">Shop V1.0</span></p>\r\n</ul>');
-- ----------------------------
-- Records of friendlink
-- ----------------------------
INSERT INTO `friendlink` VALUES ('8c4a41f234784391809216e2ea7fb84d', '2014-12-24 14:46:04', null, '/upload/image/1e31632cf9214b4191bd0adb50b4ed3e.png', '开源中国', '50', 'http://www.oschina.net/');
-- ----------------------------
-- Records of logconfig
-- ----------------------------
INSERT INTO `logconfig` VALUES ('6867e6a96a2e42188d427468dcdb4fc7', '2016-01-07 17:41:56', null, 'com.jfinalshop.controller.admin.AdminController', 'add', null, '管理员');
-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES ('150c791333b24223b4e12bf0fe1730e6', '2014-10-13 10:34:38', '2014-12-15 14:23:20', '618.00000', 'hycx1983@163.com', '', '\0', null, '2015-08-24 15:53:04', '1', '0:0:0:0:0:0:0:1', '7adeaf546b7726c8a40fd4c9c2e96653', null, '68', '127.0.0.1', '222', '111', 'hycx', '402881862be164ae012be16ab6fd0004');
INSERT INTO `member` VALUES ('402881862bf08f18012bf0a16b7c0010', '2010-10-28 10:18:52', '2014-12-12 16:10:08', '9762.00000', 'test2@shopxx.net', '', '\0', null, '2010-10-28 10:34:46', '0', '192.168.1.13', 'b59c67bf196a4758191e42f76670ceba', null, '0', '192.168.1.3', '111', '111', 'test2', '402881862be164ae012be16ab6fd0004');
INSERT INTO `member` VALUES ('60a825648b30481b80d010c1d96c1dac', '2014-12-11 17:36:39', null, '300.00000', 'aaa@33.com', '', '\0', null, '2014-12-12 11:33:43', '0', '127.0.0.1', '2be9bd7a3434f7038ca27d1918de58bd', null, '33', '127.0.0.1', null, null, '3333', '402881862bedd9fc012bee0b65170005');
INSERT INTO `member` VALUES ('748324c4f85748918dfcfa0ef5c87fb8', '2015-08-24 16:11:14', null, '0.00000', 'hycx1983@163.com', '', '\0', null, '2015-08-24 16:11:14', '0', '0:0:0:0:0:0:0:1', '7adeaf546b7726c8a40fd4c9c2e96653', null, '0', '0:0:0:0:0:0:0:1', null, null, 'hycx2', '402881862be164ae012be16ab6fd0004');
INSERT INTO `member` VALUES ('9b8a1c7bc6614e63b4fc64f2921140a1', '2015-08-24 16:11:40', null, '0.00000', 'hycx1983@163.com', '', '\0', null, '2015-08-24 16:11:40', '0', '0:0:0:0:0:0:0:1', '7adeaf546b7726c8a40fd4c9c2e96653', null, '0', '0:0:0:0:0:0:0:1', null, null, 'hycx3', '402881862be164ae012be16ab6fd0004');
INSERT INTO `member` VALUES ('d4dcd061a5c0478ba7bf375e0eb56a16', '2015-08-24 17:45:36', null, '0.00000', 'hycx227@163.com', '', '\0', null, '2015-08-24 17:45:36', '0', '0:0:0:0:0:0:0:1', '7adeaf546b7726c8a40fd4c9c2e96653', null, '0', '0:0:0:0:0:0:0:1', null, null, 'hycx4', '402881862be164ae012be16ab6fd0004');
INSERT INTO `member` VALUES ('f4680febba9f46df99ffd0961edeecf0', '2016-01-13 15:49:53', null, '0.00000', 'jack.zhou@dextrys.com', '', '\0', null, '2016-01-13 15:49:53', '0', '0:0:0:0:0:0:0:1', 'fcd89fadf15d68e963404e3c5d2059e3', null, '0', '0:0:0:0:0:0:0:1', null, null, 'jack', '402881862be164ae012be16ab6fd0004');
INSERT INTO `member` VALUES ('ovihkw0ULJmas-s1pDC4WqJhozIU', '2016-02-04 13:38:56', '2016-02-05 14:39:34', '0.00000', '', '\0', '\0', null, '2016-02-04 13:38:56', '0', 'X-Real-Ip:101.226.69.109', '3f526bf820144ecea6a5b8a5b9b05960', null, '0', '127.0.0.1', null, null, '王成', '402881862be164ae012be16ab6fd0004');
INSERT INTO `member` VALUES ('ovihkw62KTe104q1cDAcPzaa0gkE', '2016-02-04 12:29:09', '2016-02-05 17:04:47', '0.00000', '', '\0', '\0', null, '2016-02-04 12:29:09', '0', 'X-Real-Ip:101.226.125.14', 'fcd89fadf15d68e963404e3c5d2059e3', null, '0', '127.0.0.1', null, null, 'JackFish', '402881862be164ae012be16ab6fd0004');
INSERT INTO `member` VALUES ('ovihkwyaET2t3qTxti5-aB_hLYd0', '2016-02-05 16:48:33', '2016-02-05 17:48:42', '0.00000', '', '\0', '\0', null, '2016-02-05 16:48:33', '0', 'X-Real-Ip:101.226.89.14', 'd126075ec06b44a6b3d9fa75ada55a18', null, '0', 'X-Real-Ip:101.226.89.14', null, null, '沈风亭@Tim', '402881862be164ae012be16ab6fd0004');
-- ----------------------------
-- Records of memberattribute
-- ----------------------------
INSERT INTO `memberattribute` VALUES ('14227290849e4ee0ba329e5b5a4f21ec', '2014-12-11 16:18:37', null, null, '7', '', '\0', '性别', '50');
INSERT INTO `memberattribute` VALUES ('2a5902b30a5f43f0b81e93bbc316c9f9', '2014-12-11 16:23:32', null, null, '8', '', '\0', '生日', '50');
INSERT INTO `memberattribute` VALUES ('402881882badb4ed012badb9b16d0003', '2010-10-15 10:30:49', '2010-10-27 22:18:20', null, '12', '', '\0', '手机', '0');
INSERT INTO `memberattribute` VALUES ('402881882badb4ed012badc9b4ab0013', '2010-10-15 10:48:18', '2010-10-27 22:19:22', null, '14', '', '\0', '联系QQ', '3');
INSERT INTO `memberattribute` VALUES ('402881882badb4ed012badca1d480014', '2010-10-15 10:48:45', '2010-10-27 22:19:17', null, '10', '', '\0', '联系地址', '2');
INSERT INTO `memberattribute` VALUES ('9e1fa1715c28488f8ab7907c8ce63410', '2014-12-11 16:20:27', null, null, '16', '', '\0', '旺旺', '50');
-- ----------------------------
-- Records of memberrank
-- ----------------------------
INSERT INTO `memberrank` VALUES ('402881862be164ae012be16ab6fd0004', '2010-10-25 11:24:48', '2010-10-25 11:25:44', '', '普通会员', '0', '100');
INSERT INTO `memberrank` VALUES ('402881862be164ae012be16affce0005', '2010-10-25 11:25:07', '2010-10-27 23:00:12', '\0', '高级会员', '5000', '96');
INSERT INTO `memberrank` VALUES ('402881862bedd9fc012bee0b65170005', '2010-10-27 22:15:45', '2010-10-27 23:00:35', '\0', '白金会员', '10000', '93');
INSERT INTO `memberrank` VALUES ('402881862bedd9fc012bee0bb9800006', '2010-10-27 22:16:07', '2010-10-27 23:00:43', '\0', '钻石会员', '50000', '90');
-- ----------------------------
-- Records of member_memberattributemapstore
-- ----------------------------
INSERT INTO `member_memberattributemapstore` VALUES ('150c791333b24223b4e12bf0fe1730e6', '13798064110', '402881882badb4ed012badb9b16d0003');
INSERT INTO `member_memberattributemapstore` VALUES ('60a825648b30481b80d010c1d96c1dac', 'male', '14227290849e4ee0ba329e5b5a4f21ec');
INSERT INTO `member_memberattributemapstore` VALUES ('60a825648b30481b80d010c1d96c1dac', '2014-12-23', '2a5902b30a5f43f0b81e93bbc316c9f9');
INSERT INTO `member_memberattributemapstore` VALUES ('60a825648b30481b80d010c1d96c1dac', '13798064110', '402881882badb4ed012badb9b16d0003');
INSERT INTO `member_memberattributemapstore` VALUES ('60a825648b30481b80d010c1d96c1dac', '123', '402881882badb4ed012badc9b4ab0013');
INSERT INTO `member_memberattributemapstore` VALUES ('60a825648b30481b80d010c1d96c1dac', '1234567', '402881882badb4ed012badca1d480014');
INSERT INTO `member_memberattributemapstore` VALUES ('60a825648b30481b80d010c1d96c1dac', '333', '9e1fa1715c28488f8ab7907c8ce63410');
-- ----------------------------
-- Records of member_product
-- ----------------------------
INSERT INTO `member_product` VALUES ('150c791333b24223b4e12bf0fe1730e6', 'f21d18e67f274262bd836d1dea7c30f1');
-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '商品管理', null, 'fa-tasks', '', '0', '0', '2015-08-30 13:58:35', null);
INSERT INTO `menu` VALUES ('2', '商品列表', '/product/list', '', '', '1', '1', '2015-08-30 13:58:36', null);
INSERT INTO `menu` VALUES ('3', '添加商品', '/product/add', null, '', '2', '1', '2015-08-30 13:58:37', '2016-01-15 14:27:13');
INSERT INTO `menu` VALUES ('4', '分类列表', '/productCategory/list', null, '', '3', '1', '2015-08-30 13:59:06', null);
INSERT INTO `menu` VALUES ('5', '添加分类', '/productCategory/add', null, '', '4', '1', '2015-08-30 13:59:33', null);
INSERT INTO `menu` VALUES ('6', '类型列表', '/productType/list', null, '', '5', '1', '2015-08-30 14:00:02', null);
INSERT INTO `menu` VALUES ('7', '属性列表', '/productAttribute/list', null, '', '6', '1', '2015-08-30 14:00:29', null);
INSERT INTO `menu` VALUES ('8', '品牌列表', '/brand/list', null, '', '7', '1', '2015-08-30 14:00:54', null);
INSERT INTO `menu` VALUES ('9', '添加品牌', '/brand/add', null, '', '8', '1', '2015-08-30 14:01:18', null);
INSERT INTO `menu` VALUES ('10', '订单管理', null, 'fa-shopping-cart', '', '1', '0', '2015-08-30 14:01:44', null);
INSERT INTO `menu` VALUES ('11', '订单列表', '/order/list', null, '', '1', '10', '2015-08-30 14:02:14', null);
INSERT INTO `menu` VALUES ('12', '收款单', '/payment/list', null, '', '2', '10', '2015-08-30 14:02:39', null);
INSERT INTO `menu` VALUES ('13', '退款单', '/refund/list', null, '', '3', '10', '2015-08-30 14:03:03', null);
INSERT INTO `menu` VALUES ('14', '发货单', '/shipping/list', null, '', '4', '10', '2015-08-30 14:03:25', null);
INSERT INTO `menu` VALUES ('15', '退货单', '/reship/list', null, '', '5', '10', '2015-08-30 14:03:53', null);
INSERT INTO `menu` VALUES ('16', '内容管理', null, 'fa-rss-square', '', '2', '0', '2015-08-30 14:05:04', null);
INSERT INTO `menu` VALUES ('17', '文章管理', '/article/list', null, '', '1', '16', '2015-08-30 14:05:40', null);
INSERT INTO `menu` VALUES ('18', '文章分类', '/articleCategory/list', null, '', '2', '16', '2015-08-30 14:06:06', null);
INSERT INTO `menu` VALUES ('19', '导航管理', '/navigation/list', null, '', '3', '16', '2015-08-30 14:06:42', null);
INSERT INTO `menu` VALUES ('20', '友情链接', '/friendLink/list', null, '', '4', '16', '2015-08-30 14:07:28', null);
INSERT INTO `menu` VALUES ('21', '网页底部信息', '/footer/edit', null, '', '5', '16', '2015-08-30 14:07:53', null);
INSERT INTO `menu` VALUES ('22', '会员注册协议', '/agreement/edit', null, '', '6', '16', '2015-08-30 14:08:09', null);
INSERT INTO `menu` VALUES ('23', '模板管理', null, 'fa-file-text', '', '3', '0', '2015-08-30 14:09:21', null);
INSERT INTO `menu` VALUES ('24', '动态模板管理', '/templateDynamic/list', null, '', '1', '23', '2015-08-30 14:09:48', null);
INSERT INTO `menu` VALUES ('25', '静态模板管理', '/templateHtml/list', null, '', '2', '23', '2015-08-30 14:10:29', null);
INSERT INTO `menu` VALUES ('26', '邮件模板管理', '/templateMail/list', null, '', '3', '23', '2015-08-30 14:10:51', null);
INSERT INTO `menu` VALUES ('27', '一键网站更新', '/buildHtml/allInput', null, '', '4', '23', '2015-08-30 14:11:19', null);
INSERT INTO `menu` VALUES ('28', '文章更新', '/buildHtml/articleInput', null, '', '5', '23', '2015-08-30 14:11:43', null);
INSERT INTO `menu` VALUES ('29', '商品更新', '/buildHtml/productInput', null, '', '6', '23', '2015-08-30 14:12:04', null);
INSERT INTO `menu` VALUES ('30', '管理员', null, 'fa-user', '', '4', '0', '2015-08-30 14:12:24', null);
INSERT INTO `menu` VALUES ('31', '管理员列表', '/admin/list', null, '', '0', '30', '2015-08-30 14:12:53', null);
INSERT INTO `menu` VALUES ('32', '角色管理', '/role/list', null, '', '0', '30', '2015-08-30 14:13:39', null);
INSERT INTO `menu` VALUES ('33', '资源管理', '/resource/list', null, '', '0', '30', '2015-08-30 14:14:01', null);
INSERT INTO `menu` VALUES ('34', '收件箱', '/message/inbox', null, '', '0', '30', '2015-08-30 14:14:31', null);
INSERT INTO `menu` VALUES ('35', '发件箱', '/message/outbox', null, '', '0', '30', '2015-08-30 14:14:52', null);
INSERT INTO `menu` VALUES ('36', '查看日志', '/log/list', null, '', '0', '30', '2015-08-30 14:15:20', null);
INSERT INTO `menu` VALUES ('37', '日志配置', '/logConfig/list', null, '', '0', '30', '2015-08-30 14:15:45', null);
INSERT INTO `menu` VALUES ('38', '网站设置', null, 'fa-wrench', '', '4', '0', '2015-08-30 14:16:12', null);
INSERT INTO `menu` VALUES ('39', '系统设置', '/systemConfig/edit', null, '', '0', '38', '2015-08-30 14:17:40', null);
INSERT INTO `menu` VALUES ('40', '支付方式', '/paymentConfig/list', null, '', '0', '38', '2015-08-30 14:18:07', null);
INSERT INTO `menu` VALUES ('41', '配送方式', '/deliveryType/list', null, '', '0', '38', '2015-08-30 14:18:32', null);
INSERT INTO `menu` VALUES ('42', '地区管理', '/area/list', null, '', '0', '38', '2015-08-30 14:18:55', null);
INSERT INTO `menu` VALUES ('43', '物流公司', '/deliveryCorp/list', null, '', '0', '38', '2015-08-30 14:19:20', null);
INSERT INTO `menu` VALUES ('44', '菜单管理', '/systemMenu/list', null, '', '5', '38', '2015-08-30 14:19:20', null);
INSERT INTO `menu` VALUES ('101', '活动管理', '/activity/list', null, '', '9', '1', '2016-01-08 13:58:35', null);
INSERT INTO `menu` VALUES ('102', '添加活动', '/activity/add', null, '', '10', '1', '2016-01-08 13:58:35', null);
INSERT INTO `menu` VALUES ('103', '货架管理', '/shelf/list', null, '', '11', '1', null, null);
INSERT INTO `menu` VALUES ('104', '商品包管理', '/packet/list', null, '', '12', '1', null, null);
INSERT INTO `menu` VALUES ('105', '商品打包', '/packet/productPackage', null, '', '13', '1', null, null);
-- ----------------------------
-- Records of navigation
-- ----------------------------
INSERT INTO `navigation` VALUES ('402881882ba98cce012ba9d6e43c001e', '2010-10-14 16:24:14', '2010-10-27 22:06:32', '\0', '', '购物流程', '0', '2', '/html/article_content/201010/9102600e47b7401b843ad3722e1e9b70.html');
INSERT INTO `navigation` VALUES ('402881882ba98cce012ba9db98a4001f', '2010-10-14 16:29:22', '2010-10-27 22:06:42', '\0', '', '网站制度', '0', '2', '/html/article_content/201010/90eb7634990341909027a5e20245b3e1.html');
INSERT INTO `navigation` VALUES ('402881882ba98cce012ba9dbe8c80020', '2010-10-14 16:29:42', '2010-10-27 22:06:51', '\0', '', '订单查询', '0', '2', '/html/article_content/201010/50588403d9dd494c9035fa763e49e112.html');
INSERT INTO `navigation` VALUES ('402881882ba98cce012baa5805da0027', '2010-10-14 18:45:16', '2010-10-27 22:06:58', '\0', '', '积分说明', '0', '2', '/html/article_content/201010/390aed8de096473aa3fd928c25bf9fb9.html');
INSERT INTO `navigation` VALUES ('402881882ba98cce012baa5888780028', '2010-10-14 18:45:50', '2010-10-27 22:07:06', '\0', '', '会员注册协议', '0', '2', '/html/article_content/201010/c55109104bb241c7a51605602b1531df.html');
INSERT INTO `navigation` VALUES ('402881882ba98cce012baa58f1440029', '2010-10-14 18:46:17', '2010-10-27 22:42:41', '\0', '', '会员等级', '0', '2', '/html/article_content/201010/0340b92488ca464aa8d545fb899dcd25.html');
INSERT INTO `navigation` VALUES ('402881882ba98cce012baa5945fb002a', '2010-10-14 18:46:38', '2010-10-27 23:00:07', '\0', '', '网上支付', '0', '2', '/html/article_content/201010/fd97e448663c4f5a8f033743328a8038.html');
INSERT INTO `navigation` VALUES ('402881882ba98cce012baa598d84002b', '2010-10-14 18:46:57', '2010-10-27 22:59:33', '\0', '', '邮局汇款', '0', '2', '/html/article_content/201010/fd97e448663c4f5a8f033743328a8038.html');
INSERT INTO `navigation` VALUES ('402881882ba98cce012baa5a7ce5002d', '2010-10-14 18:47:58', '2010-10-27 22:09:04', '\0', '', '退货政策', '0', '2', '/html/article_content/201010/ac6f0b7c351c41058dc800ea0091e26c.html');
INSERT INTO `navigation` VALUES ('402881882ba98cce012baa5ac42f002e', '2010-10-14 18:48:16', '2010-10-27 22:09:13', '\0', '', '关于我们', '0', '2', '/html/article_content/201010/070088f2df794b26b03bdf022565f1f2.html');
INSERT INTO `navigation` VALUES ('402881882ba98cce012baa5b09c4002f', '2010-10-14 18:48:34', '2010-10-27 22:09:21', '\0', '', '发票制度说明', '0', '2', '/html/article_content/201010/82c2ffe3f0234a6ba2aed4727a75a19a.html');
INSERT INTO `navigation` VALUES ('402881882ba98cce012baa5b4ad40030', '2010-10-14 18:48:51', '2010-10-27 22:09:35', '\0', '', '常见问题', '0', '2', '/html/article_content/201010/cb4b35cc2fd14ddbb20b49d7637fab2f.html');
INSERT INTO `navigation` VALUES ('402881882badb4ed012badc775b70012', '2010-10-15 10:45:51', '2010-10-27 22:05:11', '\0', '', '首页', '0', '1', '/');
INSERT INTO `navigation` VALUES ('402881882bbdfe19012bbe924ac10014', '2010-10-18 17:01:19', '2015-01-09 17:20:52', '', '', '关于我们', '2', '0', '/html/article_content/201010/5010509a555548939840a3103d3cea71.html');
-- ----------------------------
-- Records of paymentconfig
-- ----------------------------
INSERT INTO `paymentconfig` VALUES ('402881862b9f2bff012b9f2d616a0001', '2010-10-12 14:42:52', '2014-12-20 09:55:26', '{\"bargainorId\":\"1216219001\",\"key\":\"5b1444206401b1e88a6388f6c2c6baa8\",\"tenpayType\":\"direct\"}', '<p>财付通致力于为互联网用户和企业提供安全、便捷、专业的在线支付服务。<br />财付通构建全新的综合支付平台，业务覆盖B2B、B2C和C2C各领域，提供卓越的网上支付及清算服务。</p>', '财付通', '0', '2', '0.10000', '0');
INSERT INTO `paymentconfig` VALUES ('402881862b9f9e78012b9fa02aca0002', '2010-10-12 16:48:15', '2010-10-27 22:47:19', null, '<div class=\"note\">您可以通过现金付款或银行转帐的方式进行收款。</div>', '线下支付', '2', '1', '0.10000', '0');
INSERT INTO `paymentconfig` VALUES ('402881862b9f9e78012b9fa092db0003', '2010-10-12 16:48:42', '2010-10-27 22:43:23', null, '<div class=\"note\">预存款是客户在网站上的虚拟资金帐户。</div>', '预存款', '1', '0', '0.10000', '0');
INSERT INTO `paymentconfig` VALUES ('b7f46b2c4f394f748c77221a43fb6b5a', '2014-12-22 16:06:50', null, '{\"alipayType\":\"direct\",\"bargainorId\":\"1111111111111\",\"key\":\"!&%^&*^&*^*(\"}', '<p>ee</p>', '支付宝', '50', '3', '12.00000', '0');
-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('3', '2015-01-09 16:41:20', null, '<p><img src=\"http://localhost/upload/image/201501/50628c8d22d04953a610eab42bdbceb5.jpg\" alt=\"\" width=\"750\" height=\"11129\" /></p>', '0', '/html/product_content/201501/5c8d0f1a3f9e4b26b510f36cb0dbd40a.html', '', '\0', '\0', '', '509.00000', 'SKG手机平板移动电源商务', 'SKG手机平板移动电源商务', 'SKG手机平板移动电源商务 超薄聚合物锂电芯 安卓通用充电宝5802', '286', '286.00000', '[\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2_big.jpg\",\n		\"id\":\"b48c479983cf4ae98b55c1fb03f257b2\",\n		\"smallProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677_big.jpg\",\n		\"id\":\"1a5a5cfb934f4c389cde2c1187270677\",\n		\"smallProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1_big.jpg\",\n		\"id\":\"43e36bd8c975417e82046454ad1aacf1\",\n		\"smallProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4_big.jpg\",\n		\"id\":\"bdd9193c8ae94df380bf5c5895ea35a4\",\n		\"smallProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847_big.jpg\",\n		\"id\":\"ee74969af8e645569b1bef6dce568847\",\n		\"smallProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847_thumbnail.jpg\"\n	}\n]', '3', '1966', '150', '0', '85b85945d8ae4eceac44bc753e1b7a84', '340f3673c9f340529a89398228a0cc87', '7ad4f0c4ae544a78952623f2d417519c', '');
INSERT INTO `product` VALUES ('4', '2015-01-09 16:41:20', null, '<p><img src=\"http://localhost/upload/image/201501/50628c8d22d04953a610eab42bdbceb5.jpg\" alt=\"\" width=\"750\" height=\"11129\" /></p>', '0', '/html/product_content/201501/5c8d0f1a3f9e4b26b510f36cb0dbd40a.html', '', '\0', '\0', '', '509.00000', 'SKG手机平板移动电源商务', 'SKG手机平板移动电源商务', 'SKG手机平板移动电源商务 超薄聚合物锂电芯 安卓通用充电宝5802', '286', '286.00000', '[\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2_big.jpg\",\n		\"id\":\"b48c479983cf4ae98b55c1fb03f257b2\",\n		\"smallProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677_big.jpg\",\n		\"id\":\"1a5a5cfb934f4c389cde2c1187270677\",\n		\"smallProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1_big.jpg\",\n		\"id\":\"43e36bd8c975417e82046454ad1aacf1\",\n		\"smallProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4_big.jpg\",\n		\"id\":\"bdd9193c8ae94df380bf5c5895ea35a4\",\n		\"smallProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847_big.jpg\",\n		\"id\":\"ee74969af8e645569b1bef6dce568847\",\n		\"smallProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847_thumbnail.jpg\"\n	}\n]', '4', '1966', '150', '0', '85b85945d8ae4eceac44bc753e1b7a84', '340f3673c9f340529a89398228a0cc87', '7ad4f0c4ae544a78952623f2d417519c', '\0');
INSERT INTO `product` VALUES ('4f5e5aa3e3e84bf4a89e0263cd12b081', '2015-01-09 14:57:39', '2015-01-09 16:25:10', '<p><img src=\"http://localhost/upload/image/201501/001a1de4f15a4328abc095dadf1b0da8.jpg\" alt=\"\" width=\"750\" height=\"9437\" /></p>\r\n<p><img src=\"http://localhost/upload/image/201501/6a048cd1d34a4e01b1521b817ae46f16.jpg\" alt=\"\" width=\"750\" height=\"7010\" /></p>', '0', '/html/product_content/201501/709936434ae64444b52dd29edda6618a.html', '', '', '', '', '699.00000', '新款SKG GW3315榨汁机 不锈钢 婴儿榨汁机 出汁率高 特价ZZ1318', '新款SKG GW3315榨汁机', '新款SKG GW3315榨汁机 不锈钢 婴儿榨汁机 出汁率高 特价ZZ1318', '299', '299.00000', '[\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/d7ac6f6bcf734de3a37411bd405166d4_big.jpg\",\n		\"id\":\"d7ac6f6bcf734de3a37411bd405166d4\",\n		\"smallProductImagePath\":\"/upload/image/201501/d7ac6f6bcf734de3a37411bd405166d4_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/d7ac6f6bcf734de3a37411bd405166d4.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/d7ac6f6bcf734de3a37411bd405166d4_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/0aa1288168694b2c8686ffaa20ddb8d0_big.jpg\",\n		\"id\":\"0aa1288168694b2c8686ffaa20ddb8d0\",\n		\"smallProductImagePath\":\"/upload/image/201501/0aa1288168694b2c8686ffaa20ddb8d0_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/0aa1288168694b2c8686ffaa20ddb8d0.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/0aa1288168694b2c8686ffaa20ddb8d0_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/afc61a6a107140f8a504140f60087055_big.jpg\",\n		\"id\":\"afc61a6a107140f8a504140f60087055\",\n		\"smallProductImagePath\":\"/upload/image/201501/afc61a6a107140f8a504140f60087055_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/afc61a6a107140f8a504140f60087055.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/afc61a6a107140f8a504140f60087055_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/f04cdde6d96b4ffb9dccc2ea5211f8bf_big.jpg\",\n		\"id\":\"f04cdde6d96b4ffb9dccc2ea5211f8bf\",\n		\"smallProductImagePath\":\"/upload/image/201501/f04cdde6d96b4ffb9dccc2ea5211f8bf_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/f04cdde6d96b4ffb9dccc2ea5211f8bf.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/f04cdde6d96b4ffb9dccc2ea5211f8bf_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/85ba9b4cb06d4f0e9945e3688ce27550_big.jpg\",\n		\"id\":\"85ba9b4cb06d4f0e9945e3688ce27550\",\n		\"smallProductImagePath\":\"/upload/image/201501/85ba9b4cb06d4f0e9945e3688ce27550_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/85ba9b4cb06d4f0e9945e3688ce27550.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/85ba9b4cb06d4f0e9945e3688ce27550_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/74fdc7fb076c4d44b08480d842c22b9c_big.jpg\",\n		\"id\":\"74fdc7fb076c4d44b08480d842c22b9c\",\n		\"smallProductImagePath\":\"/upload/image/201501/74fdc7fb076c4d44b08480d842c22b9c_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/74fdc7fb076c4d44b08480d842c22b9c.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/74fdc7fb076c4d44b08480d842c22b9c_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/88eb2fd8d06542dc9692309d059cf0ed_big.jpg\",\n		\"id\":\"88eb2fd8d06542dc9692309d059cf0ed\",\n		\"smallProductImagePath\":\"/upload/image/201501/88eb2fd8d06542dc9692309d059cf0ed_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/88eb2fd8d06542dc9692309d059cf0ed.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/88eb2fd8d06542dc9692309d059cf0ed_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/366962fc937f41a3a035117fbc619cb8_big.jpg\",\n		\"id\":\"366962fc937f41a3a035117fbc619cb8\",\n		\"smallProductImagePath\":\"/upload/image/201501/366962fc937f41a3a035117fbc619cb8_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/366962fc937f41a3a035117fbc619cb8.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/366962fc937f41a3a035117fbc619cb8_thumbnail.jpg\"\n	}\n]', 'SN_E322127BDD6A', '135', '1', '1', '85b85945d8ae4eceac44bc753e1b7a84', '3693519d7a81423082a8639f6cfb31ef', '641950e9a55943f3b44477319671a081', '\0');
INSERT INTO `product` VALUES ('5', '2015-01-09 16:41:20', null, '<p><img src=\"http://localhost/upload/image/201501/50628c8d22d04953a610eab42bdbceb5.jpg\" alt=\"\" width=\"750\" height=\"11129\" /></p>', '0', '/html/product_content/201501/5c8d0f1a3f9e4b26b510f36cb0dbd40a.html', '', '\0', '\0', '', '509.00000', 'SKG手机平板移动电源商务', 'SKG手机平板移动电源商务', 'SKG手机平板移动电源商务 超薄聚合物锂电芯 安卓通用充电宝5802', '286', '286.00000', '[\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2_big.jpg\",\n		\"id\":\"b48c479983cf4ae98b55c1fb03f257b2\",\n		\"smallProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677_big.jpg\",\n		\"id\":\"1a5a5cfb934f4c389cde2c1187270677\",\n		\"smallProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1_big.jpg\",\n		\"id\":\"43e36bd8c975417e82046454ad1aacf1\",\n		\"smallProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4_big.jpg\",\n		\"id\":\"bdd9193c8ae94df380bf5c5895ea35a4\",\n		\"smallProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847_big.jpg\",\n		\"id\":\"ee74969af8e645569b1bef6dce568847\",\n		\"smallProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847_thumbnail.jpg\"\n	}\n]', '5', '1966', '150', '0', '85b85945d8ae4eceac44bc753e1b7a84', '340f3673c9f340529a89398228a0cc87', '7ad4f0c4ae544a78952623f2d417519c', '\0');
INSERT INTO `product` VALUES ('58a633353ce142d4b94b2d880f22c481', '2015-01-09 13:47:33', '2015-01-09 14:20:07', '<p><img src=\"http://localhost/upload/image/201501/9d560e7ecbdc47b0bd5936dee5af5069.jpg\" alt=\"\" width=\"750\" height=\"17317\" /></p>', '0', '/html/product_content/201501/f08704d9d0e64c4dadd9500f925d9ce1.html', '', '\0', '\0', '', '208.00000', 'SKG1101电热开水瓶 一次沸腾 特有气压出水 健康除氟 不锈钢材质', 'SKG1101电热开水瓶 一次沸腾 特有气压出水 健康除氟 不锈钢材质', 'SKG1101电热开水瓶 一次沸腾 特有气压出水 健康除氟 不锈钢材质', '199', '199.00000', '[\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/38999f27a6db4f41b2042bd1094a7398_big.jpg\",\n		\"id\":\"38999f27a6db4f41b2042bd1094a7398\",\n		\"smallProductImagePath\":\"/upload/image/201501/38999f27a6db4f41b2042bd1094a7398_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/38999f27a6db4f41b2042bd1094a7398.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/38999f27a6db4f41b2042bd1094a7398_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/1dae9983b68d46f4a6a3fb9295c0816b_big.jpg\",\n		\"id\":\"1dae9983b68d46f4a6a3fb9295c0816b\",\n		\"smallProductImagePath\":\"/upload/image/201501/1dae9983b68d46f4a6a3fb9295c0816b_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/1dae9983b68d46f4a6a3fb9295c0816b.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/1dae9983b68d46f4a6a3fb9295c0816b_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/988e8bc3cd944fa481ab4fc807790e63_big.jpg\",\n		\"id\":\"988e8bc3cd944fa481ab4fc807790e63\",\n		\"smallProductImagePath\":\"/upload/image/201501/988e8bc3cd944fa481ab4fc807790e63_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/988e8bc3cd944fa481ab4fc807790e63.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/988e8bc3cd944fa481ab4fc807790e63_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/e29199834b8d491287560cf2d3ce2a99_big.jpg\",\n		\"id\":\"e29199834b8d491287560cf2d3ce2a99\",\n		\"smallProductImagePath\":\"/upload/image/201501/e29199834b8d491287560cf2d3ce2a99_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/e29199834b8d491287560cf2d3ce2a99.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/e29199834b8d491287560cf2d3ce2a99_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/48c4a9e7e09647c7b2517ebd4b8224d9_big.jpg\",\n		\"id\":\"48c4a9e7e09647c7b2517ebd4b8224d9\",\n		\"smallProductImagePath\":\"/upload/image/201501/48c4a9e7e09647c7b2517ebd4b8224d9_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/48c4a9e7e09647c7b2517ebd4b8224d9.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/48c4a9e7e09647c7b2517ebd4b8224d9_thumbnail.jpg\"\n	}\n]', 'SN_4A53A384F02C', '197', '500', '0', '85b85945d8ae4eceac44bc753e1b7a84', '2505aa1eda674d78a3325db74b0bfd72', '79b67a8dce2e451588a4f42a9475dd9d', '\0');
INSERT INTO `product` VALUES ('6', '2015-01-09 16:41:20', null, '<p><img src=\"http://localhost/upload/image/201501/50628c8d22d04953a610eab42bdbceb5.jpg\" alt=\"\" width=\"750\" height=\"11129\" /></p>', '0', '/html/product_content/201501/5c8d0f1a3f9e4b26b510f36cb0dbd40a.html', '', '\0', '\0', '', '509.00000', 'SKG手机平板移动电源商务', 'SKG手机平板移动电源商务', 'SKG手机平板移动电源商务 超薄聚合物锂电芯 安卓通用充电宝5802', '286', '286.00000', '[\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2_big.jpg\",\n		\"id\":\"b48c479983cf4ae98b55c1fb03f257b2\",\n		\"smallProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677_big.jpg\",\n		\"id\":\"1a5a5cfb934f4c389cde2c1187270677\",\n		\"smallProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1_big.jpg\",\n		\"id\":\"43e36bd8c975417e82046454ad1aacf1\",\n		\"smallProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4_big.jpg\",\n		\"id\":\"bdd9193c8ae94df380bf5c5895ea35a4\",\n		\"smallProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847_big.jpg\",\n		\"id\":\"ee74969af8e645569b1bef6dce568847\",\n		\"smallProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847_thumbnail.jpg\"\n	}\n]', '6', '1966', '150', '0', '85b85945d8ae4eceac44bc753e1b7a84', '340f3673c9f340529a89398228a0cc87', '7ad4f0c4ae544a78952623f2d417519c', '\0');
INSERT INTO `product` VALUES ('6402339746e04840932a5d400dcc8654', '2015-01-09 16:28:11', null, '<p><img src=\"http://localhost/upload/image/201501/8ec9e136d5df49c5ac4d19f2997317c9.jpg\" alt=\"\" width=\"750\" height=\"11958\" /></p>', '0', '/html/product_content/201501/7bb5a5692a164d6d93af2ff318808185.html', '', '', '', '', '399.00000', 'SKG 1638 家用静音电陶炉', 'SKG 1638 家用静音电陶炉', 'SKG 1638 家用静音电陶炉 不锈钢 包邮特价 无辐射黑晶炉', '179', '179.00000', '[\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/877e84f41e07437c9e3756a3ac32c2e7_big.jpg\",\n		\"id\":\"877e84f41e07437c9e3756a3ac32c2e7\",\n		\"smallProductImagePath\":\"/upload/image/201501/877e84f41e07437c9e3756a3ac32c2e7_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/877e84f41e07437c9e3756a3ac32c2e7.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/877e84f41e07437c9e3756a3ac32c2e7_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/3589d5d0f08642daa64fdf584f8f7f76_big.jpg\",\n		\"id\":\"3589d5d0f08642daa64fdf584f8f7f76\",\n		\"smallProductImagePath\":\"/upload/image/201501/3589d5d0f08642daa64fdf584f8f7f76_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/3589d5d0f08642daa64fdf584f8f7f76.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/3589d5d0f08642daa64fdf584f8f7f76_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/a1a51991b59a45ed8a546707c257c279_big.jpg\",\n		\"id\":\"a1a51991b59a45ed8a546707c257c279\",\n		\"smallProductImagePath\":\"/upload/image/201501/a1a51991b59a45ed8a546707c257c279_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/a1a51991b59a45ed8a546707c257c279.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/a1a51991b59a45ed8a546707c257c279_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/3a33fc7fe7644049b38b010b0a480b66_big.jpg\",\n		\"id\":\"3a33fc7fe7644049b38b010b0a480b66\",\n		\"smallProductImagePath\":\"/upload/image/201501/3a33fc7fe7644049b38b010b0a480b66_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/3a33fc7fe7644049b38b010b0a480b66.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/3a33fc7fe7644049b38b010b0a480b66_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/eddaa91ac3234644be7c2f7abcafad56_big.jpg\",\n		\"id\":\"eddaa91ac3234644be7c2f7abcafad56\",\n		\"smallProductImagePath\":\"/upload/image/201501/eddaa91ac3234644be7c2f7abcafad56_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/eddaa91ac3234644be7c2f7abcafad56.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/eddaa91ac3234644be7c2f7abcafad56_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/0626d0484b64438fb0253a01ce2cd9f0_big.jpg\",\n		\"id\":\"0626d0484b64438fb0253a01ce2cd9f0\",\n		\"smallProductImagePath\":\"/upload/image/201501/0626d0484b64438fb0253a01ce2cd9f0_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/0626d0484b64438fb0253a01ce2cd9f0.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/0626d0484b64438fb0253a01ce2cd9f0_thumbnail.jpg\"\n	}\n]', 'SN_EB60E254149C', '2382', '2', '1', '85b85945d8ae4eceac44bc753e1b7a84', 'a2a54141e9c04a20ac81d9b18b6e96ab', '6615e9f8f28f47e184968837a24864a5', '\0');
INSERT INTO `product` VALUES ('7', '2015-01-09 16:41:20', null, '<p><img src=\"http://localhost/upload/image/201501/50628c8d22d04953a610eab42bdbceb5.jpg\" alt=\"\" width=\"750\" height=\"11129\" /></p>', '0', '/html/product_content/201501/5c8d0f1a3f9e4b26b510f36cb0dbd40a.html', '', '\0', '\0', '', '509.00000', 'SKG手机平板移动电源商务', 'SKG手机平板移动电源商务', 'SKG手机平板移动电源商务 超薄聚合物锂电芯 安卓通用充电宝5802', '286', '286.00000', '[\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2_big.jpg\",\n		\"id\":\"b48c479983cf4ae98b55c1fb03f257b2\",\n		\"smallProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677_big.jpg\",\n		\"id\":\"1a5a5cfb934f4c389cde2c1187270677\",\n		\"smallProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1_big.jpg\",\n		\"id\":\"43e36bd8c975417e82046454ad1aacf1\",\n		\"smallProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4_big.jpg\",\n		\"id\":\"bdd9193c8ae94df380bf5c5895ea35a4\",\n		\"smallProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847_big.jpg\",\n		\"id\":\"ee74969af8e645569b1bef6dce568847\",\n		\"smallProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847_thumbnail.jpg\"\n	}\n]', '8', '1966', '150', '0', '85b85945d8ae4eceac44bc753e1b7a84', '340f3673c9f340529a89398228a0cc87', '7ad4f0c4ae544a78952623f2d417519c', '\0');
INSERT INTO `product` VALUES ('8', '2015-01-09 16:41:20', null, '<p><img src=\"http://localhost/upload/image/201501/50628c8d22d04953a610eab42bdbceb5.jpg\" alt=\"\" width=\"750\" height=\"11129\" /></p>', '0', '/html/product_content/201501/5c8d0f1a3f9e4b26b510f36cb0dbd40a.html', '', '\0', '\0', '', '509.00000', 'SKG手机平板移动电源商务', 'SKG手机平板移动电源商务', 'SKG手机平板移动电源商务 超薄聚合物锂电芯 安卓通用充电宝5802', '286', '286.00000', '[\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2_big.jpg\",\n		\"id\":\"b48c479983cf4ae98b55c1fb03f257b2\",\n		\"smallProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677_big.jpg\",\n		\"id\":\"1a5a5cfb934f4c389cde2c1187270677\",\n		\"smallProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1_big.jpg\",\n		\"id\":\"43e36bd8c975417e82046454ad1aacf1\",\n		\"smallProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4_big.jpg\",\n		\"id\":\"bdd9193c8ae94df380bf5c5895ea35a4\",\n		\"smallProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847_big.jpg\",\n		\"id\":\"ee74969af8e645569b1bef6dce568847\",\n		\"smallProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847_thumbnail.jpg\"\n	}\n]', '9', '1966', '150', '0', '85b85945d8ae4eceac44bc753e1b7a84', '340f3673c9f340529a89398228a0cc87', '7ad4f0c4ae544a78952623f2d417519c', '\0');
INSERT INTO `product` VALUES ('f21d18e67f274262bd836d1dea7c30f1', '2015-01-09 16:41:20', null, '<p><img src=\"http://localhost/upload/image/201501/50628c8d22d04953a610eab42bdbceb5.jpg\" alt=\"\" width=\"750\" height=\"11129\" /></p>', '0', '/html/product_content/201501/5c8d0f1a3f9e4b26b510f36cb0dbd40a.html', '', '\0', '\0', '', '509.00000', 'SKG手机平板移动电源商务', 'SKG手机平板移动电源商务', 'SKG手机平板移动电源商务 超薄聚合物锂电芯 安卓通用充电宝5802', '286', '286.00000', '[\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2_big.jpg\",\n		\"id\":\"b48c479983cf4ae98b55c1fb03f257b2\",\n		\"smallProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/b48c479983cf4ae98b55c1fb03f257b2_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677_big.jpg\",\n		\"id\":\"1a5a5cfb934f4c389cde2c1187270677\",\n		\"smallProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/1a5a5cfb934f4c389cde2c1187270677_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1_big.jpg\",\n		\"id\":\"43e36bd8c975417e82046454ad1aacf1\",\n		\"smallProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/43e36bd8c975417e82046454ad1aacf1_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4_big.jpg\",\n		\"id\":\"bdd9193c8ae94df380bf5c5895ea35a4\",\n		\"smallProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/bdd9193c8ae94df380bf5c5895ea35a4_thumbnail.jpg\"\n	},\n	{\n		\"bigProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847_big.jpg\",\n		\"id\":\"ee74969af8e645569b1bef6dce568847\",\n		\"smallProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847_small.jpg\",\n		\"sourceProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847.jpeg\",\n		\"thumbnailProductImagePath\":\"/upload/image/201501/ee74969af8e645569b1bef6dce568847_thumbnail.jpg\"\n	}\n]', 'SN_38ECD6CB23CF', '1966', '150', '0', '85b85945d8ae4eceac44bc753e1b7a84', '340f3673c9f340529a89398228a0cc87', '7ad4f0c4ae544a78952623f2d417519c', '\0');
-- ----------------------------
-- Records of productattribute
-- ----------------------------
INSERT INTO `productattribute` VALUES ('08bc92b3df27467cb6c3775f2f268708', '2015-01-09 15:05:31', null, null, '0', '', '\0', '品牌', '7', '641950e9a55943f3b44477319671a081');
INSERT INTO `productattribute` VALUES ('100a2814d07b49caa875bf005da05416', '2015-01-09 16:52:37', null, null, '0', '', '\0', '货号', '4', '15e9cbc5fce2428dabbd4f8a6fc2da4e');
INSERT INTO `productattribute` VALUES ('1399933b3edd47ea842bc44217057154', '2015-01-09 16:33:38', null, null, '0', '', '\0', '品牌', '3', '7ad4f0c4ae544a78952623f2d417519c');
INSERT INTO `productattribute` VALUES ('1451abb39ea44ba684d9aea3cabbe480', '2015-01-09 16:52:17', null, null, '0', '', '\0', '品牌', '2', '15e9cbc5fce2428dabbd4f8a6fc2da4e');
INSERT INTO `productattribute` VALUES ('1714eec7aab24827ade02a9ea5eb5c55', '2015-01-09 15:04:33', null, null, '0', '', '\0', '果肉渣滓盒容量', '3', '641950e9a55943f3b44477319671a081');
INSERT INTO `productattribute` VALUES ('1d803559e5a34a2d849c084237cc27c7', '2015-01-09 11:33:42', null, null, '0', '', '\0', '型号', '13', '79b67a8dce2e451588a4f42a9475dd9d');
INSERT INTO `productattribute` VALUES ('201918f2319b4d3f8e3e1d237612358d', '2015-01-09 15:05:18', null, null, '0', '', '\0', '榨汁搅拌料理机功率（值)', '6', '641950e9a55943f3b44477319671a081');
INSERT INTO `productattribute` VALUES ('21be12b6122b4de99551ba7981be30a6', '2015-01-09 15:08:22', null, null, '0', '', '\0', '保修卡', '14', '641950e9a55943f3b44477319671a081');
INSERT INTO `productattribute` VALUES ('23661fcc703046caac8e5b022a679279', '2015-01-09 16:23:37', null, null, '0', '', '\0', '售后服务', '6', '6615e9f8f28f47e184968837a24864a5');
INSERT INTO `productattribute` VALUES ('2735e4ffd3f946238e9593f15e4a250d', '2015-01-09 15:07:09', null, null, '0', '', '\0', '电源线', '12', '641950e9a55943f3b44477319671a081');
INSERT INTO `productattribute` VALUES ('28cc20c141344fd3be03a695349a3e74', '2015-01-09 15:05:04', null, null, '0', '', '\0', '榨汁机附加功能', '5', '641950e9a55943f3b44477319671a081');
INSERT INTO `productattribute` VALUES ('35199544b8a54760b98fdb324c7ccbe3', '2015-01-09 16:33:19', null, null, '0', '', '\0', '电池容量', '1', '7ad4f0c4ae544a78952623f2d417519c');
INSERT INTO `productattribute` VALUES ('3ab4c4727185459096370ecd4d091001', '2015-01-09 11:32:07', null, null, '0', '', '\0', '自动断电', '7', '79b67a8dce2e451588a4f42a9475dd9d');
INSERT INTO `productattribute` VALUES ('3d24e68545b441dfa25aa7d13bfabf3c', '2015-01-09 15:04:17', null, null, '0', '', '\0', '一次性最大出汁量', '2', '641950e9a55943f3b44477319671a081');
INSERT INTO `productattribute` VALUES ('3f6ab53c4fac44c08206024d651ad081', '2015-01-09 15:04:54', null, null, '0', '', '\0', '榨汁机最高转速', '4', '641950e9a55943f3b44477319671a081');
INSERT INTO `productattribute` VALUES ('43d300b993d84a6ea2025d0a4866c764', '2015-01-09 16:35:13', null, null, '0', '', '\0', '电池类型', '10', '7ad4f0c4ae544a78952623f2d417519c');
INSERT INTO `productattribute` VALUES ('46381f53778d46e78f9d8e00ba0b4353', '2015-01-09 16:23:01', null, null, '0', '', '\0', '发热原理', '4', '6615e9f8f28f47e184968837a24864a5');
INSERT INTO `productattribute` VALUES ('478d700bf346469c8059999066f0b34b', '2015-01-09 11:31:25', null, null, '0', '', '\0', '加热速度', '4', '79b67a8dce2e451588a4f42a9475dd9d');
INSERT INTO `productattribute` VALUES ('4b428690e93a41d0bc213fc0be690f75', '2015-01-09 11:31:53', null, null, '0', '', '\0', '加热方式', '6', '79b67a8dce2e451588a4f42a9475dd9d');
INSERT INTO `productattribute` VALUES ('5d8f4cec44964d48a0aa811955a78f5f', '2015-01-09 11:33:27', null, null, '0', '', '\0', '品牌', '12', '79b67a8dce2e451588a4f42a9475dd9d');
INSERT INTO `productattribute` VALUES ('612d855d3e064eb8bba420a03d6028c3', '2015-01-09 16:33:50', null, null, '0', '', '\0', '产品尺寸', '4', '7ad4f0c4ae544a78952623f2d417519c');
INSERT INTO `productattribute` VALUES ('6fea61b9a33040c6b1f9211b9d2c1a8d', '2015-01-09 16:11:43', null, null, '0', '', '\0', '型号', '3', '6615e9f8f28f47e184968837a24864a5');
INSERT INTO `productattribute` VALUES ('846ceef0e1b84eabb2c9baed7851415d', '2015-01-09 15:07:31', null, null, '0', '', '\0', '说明书', '13', '641950e9a55943f3b44477319671a081');
INSERT INTO `productattribute` VALUES ('8a6df07db9074b14866a615e68526710', '2015-01-09 16:23:52', null, null, '0', '', '\0', '光热波炉功率（值）', '7', '6615e9f8f28f47e184968837a24864a5');
INSERT INTO `productattribute` VALUES ('9b786b9118424c4c87cef685402465eb', '2015-01-09 11:32:21', null, null, '0', '', '\0', '电热水壶类型', '8', '79b67a8dce2e451588a4f42a9475dd9d');
INSERT INTO `productattribute` VALUES ('a03e2f2c49c1452f8f62b95a07865446', '2015-01-09 11:31:11', null, null, '0', '', '\0', '容量', '3', '79b67a8dce2e451588a4f42a9475dd9d');
INSERT INTO `productattribute` VALUES ('a923cd9569c845808d8e901767695474', '2015-01-09 16:34:42', null, null, '0', '', '\0', '型号', '7', '7ad4f0c4ae544a78952623f2d417519c');
INSERT INTO `productattribute` VALUES ('b636c567253f42bc927298dd2938dc0f', '2015-01-09 16:34:08', null, null, '0', '', '\0', '输出接口', '5', '7ad4f0c4ae544a78952623f2d417519c');
INSERT INTO `productattribute` VALUES ('b9679d4aacf44d7b94dbbf8afc54857a', '2015-01-09 16:34:20', null, null, '0', '', '\0', '是否支持太阳能', '6', '7ad4f0c4ae544a78952623f2d417519c');
INSERT INTO `productattribute` VALUES ('bccdf0f5f4054404b3b8c4f4cc2567a0', '2015-01-09 16:52:05', null, null, '0', '', '\0', '产品名称', '1', '15e9cbc5fce2428dabbd4f8a6fc2da4e');
INSERT INTO `productattribute` VALUES ('c7bc0df2231b4318a82f13cd48c4726e', '2015-01-09 16:52:27', null, null, '0', '', '\0', '型号', '3', '15e9cbc5fce2428dabbd4f8a6fc2da4e');
INSERT INTO `productattribute` VALUES ('c8a0f97a10ae457d9a9ea0950f254b34', '2015-01-09 15:23:07', '2015-01-09 16:09:26', null, '0', '', '\0', '产品名称', '1', '6615e9f8f28f47e184968837a24864a5');
INSERT INTO `productattribute` VALUES ('d243e28534a14d92aa421735ba5ba022', '2015-01-09 15:06:12', null, null, '0', '', '\0', '颜色分类', '9', '641950e9a55943f3b44477319671a081');
INSERT INTO `productattribute` VALUES ('d3af24a382c84f25a1f9160a134141b7', '2015-01-09 16:08:58', null, null, '0', '', '\0', '品牌', '2', '6615e9f8f28f47e184968837a24864a5');
INSERT INTO `productattribute` VALUES ('d3d33c8b7ca94f139e206a81d14c4b79', '2015-01-09 16:33:29', null, null, '0', '', '\0', '适用对象', '2', '7ad4f0c4ae544a78952623f2d417519c');
INSERT INTO `productattribute` VALUES ('d3dc14fb9c914ba38cb002dc8b06c3c4', '2015-01-09 11:27:41', '2015-01-09 11:28:52', null, '0', '', '\0', '功率', '1', '79b67a8dce2e451588a4f42a9475dd9d');
INSERT INTO `productattribute` VALUES ('d6f187eff1f74c72af7c58cc1d4c6990', '2015-01-09 15:06:34', '2015-01-09 15:14:37', null, '0', '', '\0', '机身材质', '10', '641950e9a55943f3b44477319671a081');
INSERT INTO `productattribute` VALUES ('d86ace13caa44e29b48595e28a065413', '2015-01-09 11:31:41', null, null, '0', '', '\0', '外壳材质', '5', '79b67a8dce2e451588a4f42a9475dd9d');
INSERT INTO `productattribute` VALUES ('de1f0acd37604ad2825eff8f5c313780', '2015-01-09 16:52:48', null, null, '0', '', '\0', '颜色分类', '5', '15e9cbc5fce2428dabbd4f8a6fc2da4e');
INSERT INTO `productattribute` VALUES ('de731b3b56c047ac94653680b70459ff', '2015-01-09 11:30:56', null, null, '0', '', '\0', '内胆材质', '2', '79b67a8dce2e451588a4f42a9475dd9d');
INSERT INTO `productattribute` VALUES ('e5e45a2162364f289a72f55a8bf58cf2', '2015-01-09 11:33:04', null, null, '0', '', '\0', '颜色', '10', '79b67a8dce2e451588a4f42a9475dd9d');
INSERT INTO `productattribute` VALUES ('e9f02a63aba1419dac4689c534364ff9', '2015-01-09 16:34:31', null, null, '0', '', '\0', 'LED灯照明', '7', '7ad4f0c4ae544a78952623f2d417519c');
INSERT INTO `productattribute` VALUES ('f334d4083267411f892926b34ca6b4e5', '2015-01-09 16:23:23', null, null, '0', '', '\0', '功率', '5', '6615e9f8f28f47e184968837a24864a5');
INSERT INTO `productattribute` VALUES ('f40d10712bbf4279b0a266bc37c62833', '2015-01-09 15:06:57', '2015-01-09 15:14:28', null, '0', '', '\0', '主机', '11', '641950e9a55943f3b44477319671a081');
INSERT INTO `productattribute` VALUES ('f52de9f13185418d918e4714079d02f5', '2015-01-09 11:32:41', null, null, '0', '', '\0', '温控器类型', '9', '79b67a8dce2e451588a4f42a9475dd9d');
INSERT INTO `productattribute` VALUES ('f61d0df20e954aaea2213dd82fb9cd63', '2015-01-09 11:33:15', null, null, '0', '', '\0', '电源', '11', '79b67a8dce2e451588a4f42a9475dd9d');
INSERT INTO `productattribute` VALUES ('f6c660b9e7e54e00907d51c4d6ed89a3', '2015-01-09 15:05:54', null, null, '0', '', '\0', '型号', '8', '641950e9a55943f3b44477319671a081');
INSERT INTO `productattribute` VALUES ('f8409b1fe7e040c9af9e43234f894214', '2015-01-09 16:34:51', null, null, '0', '', '\0', '产品重量', '8', '7ad4f0c4ae544a78952623f2d417519c');
INSERT INTO `productattribute` VALUES ('fb92953996d04263873ef2ea36e46752', '2015-01-09 15:01:55', null, null, '0', '', '\0', '功率', '1', '641950e9a55943f3b44477319671a081');
INSERT INTO `productattribute` VALUES ('febcb562a77f4c3486c1d81f41861b79', '2015-01-09 16:35:01', null, null, '0', '', '\0', '产品电压', '9', '7ad4f0c4ae544a78952623f2d417519c');
-- ----------------------------
-- Records of productcategory
-- ----------------------------
INSERT INTO `productcategory` VALUES ('0e3d1018956045ea8588796d321f7317', '2015-01-09 16:32:04', '2015-01-09 16:32:04', '3C数码配件市场', '3C数码配件市场', '3C数码配件市场', '2', '0e3d1018956045ea8588796d321f7317', null);
INSERT INTO `productcategory` VALUES ('2505aa1eda674d78a3325db74b0bfd72', '2015-01-09 12:00:34', '2015-01-09 12:00:34', '电水壶', '电水壶', '电水壶', '1', 'c5910cfe886244c9b23bd0234d946c3e,2505aa1eda674d78a3325db74b0bfd72', 'c5910cfe886244c9b23bd0234d946c3e');
INSERT INTO `productcategory` VALUES ('28663da185934da0a4cf52784f771157', '2015-08-26 11:48:22', '2015-08-26 11:48:22', '11', '11', '111', '50', 'c5910cfe886244c9b23bd0234d946c3e,28663da185934da0a4cf52784f771157', 'c5910cfe886244c9b23bd0234d946c3e');
INSERT INTO `productcategory` VALUES ('2dcf75f487de4c7ea62bc181a0c28662', '2015-01-09 16:50:22', '2015-01-09 16:50:22', '个人护理清洁', '个人护理清洁', '个人护理清洁', '3', '2dcf75f487de4c7ea62bc181a0c28662', null);
INSERT INTO `productcategory` VALUES ('340f3673c9f340529a89398228a0cc87', '2015-01-09 16:32:19', '2015-01-09 16:32:19', '移动电源', '移动电源', '移动电源', '1', '0e3d1018956045ea8588796d321f7317,340f3673c9f340529a89398228a0cc87', '0e3d1018956045ea8588796d321f7317');
INSERT INTO `productcategory` VALUES ('3693519d7a81423082a8639f6cfb31ef', '2015-01-09 16:24:59', '2015-01-09 16:24:59', '榨汁机', '榨汁机', '榨汁机', '2', 'c5910cfe886244c9b23bd0234d946c3e,3693519d7a81423082a8639f6cfb31ef', 'c5910cfe886244c9b23bd0234d946c3e');
INSERT INTO `productcategory` VALUES ('a0060df8778447a2b2c636b04555f43b', '2015-01-09 16:50:46', '2015-01-09 16:50:46', '电子美容仪', '电子美容仪', '电子美容仪', '1', '2dcf75f487de4c7ea62bc181a0c28662,a0060df8778447a2b2c636b04555f43b', '2dcf75f487de4c7ea62bc181a0c28662');
INSERT INTO `productcategory` VALUES ('a2a54141e9c04a20ac81d9b18b6e96ab', '2015-01-09 16:24:33', '2015-01-09 16:24:33', '电陶炉', '电陶炉', '电陶炉', '3', 'c5910cfe886244c9b23bd0234d946c3e,a2a54141e9c04a20ac81d9b18b6e96ab', 'c5910cfe886244c9b23bd0234d946c3e');
INSERT INTO `productcategory` VALUES ('c5910cfe886244c9b23bd0234d946c3e', '2015-01-09 11:58:15', '2015-01-09 11:58:15', '厨房电器', '厨房电器', '厨房电器', '1', 'c5910cfe886244c9b23bd0234d946c3e', null);
-- ----------------------------
-- Records of producttype
-- ----------------------------
INSERT INTO `producttype` VALUES ('15e9cbc5fce2428dabbd4f8a6fc2da4e', '2015-01-09 16:51:47', null, '洁面仪【产品参数】');
INSERT INTO `producttype` VALUES ('641950e9a55943f3b44477319671a081', '2015-01-09 15:00:48', null, '榨汁机【产品参数】');
INSERT INTO `producttype` VALUES ('6615e9f8f28f47e184968837a24864a5', '2015-01-09 15:21:46', '2015-01-09 15:22:38', '电陶炉【产品参数】');
INSERT INTO `producttype` VALUES ('79b67a8dce2e451588a4f42a9475dd9d', '2015-01-09 11:27:14', '2015-01-09 11:34:22', '电水壶【产品参数】');
INSERT INTO `producttype` VALUES ('7ad4f0c4ae544a78952623f2d417519c', '2015-01-09 16:32:46', '2015-01-09 16:32:57', '移动电源【产品参数】');
-- ----------------------------
-- Records of product_productattributemapstore
-- ----------------------------
INSERT INTO `product_productattributemapstore` VALUES ('4f5e5aa3e3e84bf4a89e0263cd12b081', 'SKG', '08bc92b3df27467cb6c3775f2f268708');
INSERT INTO `product_productattributemapstore` VALUES ('4f5e5aa3e3e84bf4a89e0263cd12b081', '500ml以下（含500ml）', '1714eec7aab24827ade02a9ea5eb5c55');
INSERT INTO `product_productattributemapstore` VALUES ('4f5e5aa3e3e84bf4a89e0263cd12b081', '450W', '201918f2319b4d3f8e3e1d237612358d');
INSERT INTO `product_productattributemapstore` VALUES ('4f5e5aa3e3e84bf4a89e0263cd12b081', '1 件', '21be12b6122b4de99551ba7981be30a6');
INSERT INTO `product_productattributemapstore` VALUES ('4f5e5aa3e3e84bf4a89e0263cd12b081', '1 件', '2735e4ffd3f946238e9593f15e4a250d');
INSERT INTO `product_productattributemapstore` VALUES ('4f5e5aa3e3e84bf4a89e0263cd12b081', '榨汁', '28cc20c141344fd3be03a695349a3e74');
INSERT INTO `product_productattributemapstore` VALUES ('4f5e5aa3e3e84bf4a89e0263cd12b081', '401mL(含)-600mL(含)', '3d24e68545b441dfa25aa7d13bfabf3c');
INSERT INTO `product_productattributemapstore` VALUES ('4f5e5aa3e3e84bf4a89e0263cd12b081', '22001转/分及以上', '3f6ab53c4fac44c08206024d651ad081');
INSERT INTO `product_productattributemapstore` VALUES ('4f5e5aa3e3e84bf4a89e0263cd12b081', '1 件', '846ceef0e1b84eabb2c9baed7851415d');
INSERT INTO `product_productattributemapstore` VALUES ('4f5e5aa3e3e84bf4a89e0263cd12b081', '黑色', 'd243e28534a14d92aa421735ba5ba022');
INSERT INTO `product_productattributemapstore` VALUES ('4f5e5aa3e3e84bf4a89e0263cd12b081', '金属', 'd6f187eff1f74c72af7c58cc1d4c6990');
INSERT INTO `product_productattributemapstore` VALUES ('4f5e5aa3e3e84bf4a89e0263cd12b081', '1 件', 'f40d10712bbf4279b0a266bc37c62833');
INSERT INTO `product_productattributemapstore` VALUES ('4f5e5aa3e3e84bf4a89e0263cd12b081', 'GW3315', 'f6c660b9e7e54e00907d51c4d6ed89a3');
INSERT INTO `product_productattributemapstore` VALUES ('4f5e5aa3e3e84bf4a89e0263cd12b081', '201W(含)-500W(含)', 'fb92953996d04263873ef2ea36e46752');
INSERT INTO `product_productattributemapstore` VALUES ('58a633353ce142d4b94b2d880f22c481', 'SKG1101', '1d803559e5a34a2d849c084237cc27c7');
INSERT INTO `product_productattributemapstore` VALUES ('58a633353ce142d4b94b2d880f22c481', '支持', '3ab4c4727185459096370ecd4d091001');
INSERT INTO `product_productattributemapstore` VALUES ('58a633353ce142d4b94b2d880f22c481', '4分钟(含)-6分钟(含)', '478d700bf346469c8059999066f0b34b');
INSERT INTO `product_productattributemapstore` VALUES ('58a633353ce142d4b94b2d880f22c481', '电热圈加热', '4b428690e93a41d0bc213fc0be690f75');
INSERT INTO `product_productattributemapstore` VALUES ('58a633353ce142d4b94b2d880f22c481', 'SKG', '5d8f4cec44964d48a0aa811955a78f5f');
INSERT INTO `product_productattributemapstore` VALUES ('58a633353ce142d4b94b2d880f22c481', '电热开水瓶', '9b786b9118424c4c87cef685402465eb');
INSERT INTO `product_productattributemapstore` VALUES ('58a633353ce142d4b94b2d880f22c481', '2.8L', 'a03e2f2c49c1452f8f62b95a07865446');
INSERT INTO `product_productattributemapstore` VALUES ('58a633353ce142d4b94b2d880f22c481', '750W', 'd3dc14fb9c914ba38cb002dc8b06c3c4');
INSERT INTO `product_productattributemapstore` VALUES ('58a633353ce142d4b94b2d880f22c481', '塑料', 'd86ace13caa44e29b48595e28a065413');
INSERT INTO `product_productattributemapstore` VALUES ('58a633353ce142d4b94b2d880f22c481', '不锈钢', 'de731b3b56c047ac94653680b70459ff');
INSERT INTO `product_productattributemapstore` VALUES ('58a633353ce142d4b94b2d880f22c481', '白色', 'e5e45a2162364f289a72f55a8bf58cf2');
INSERT INTO `product_productattributemapstore` VALUES ('58a633353ce142d4b94b2d880f22c481', '国产优质温控器', 'f52de9f13185418d918e4714079d02f5');
INSERT INTO `product_productattributemapstore` VALUES ('58a633353ce142d4b94b2d880f22c481', '220V/50HZ', 'f61d0df20e954aaea2213dd82fb9cd63');
INSERT INTO `product_productattributemapstore` VALUES ('6402339746e04840932a5d400dcc8654', '全国联保', '23661fcc703046caac8e5b022a679279');
INSERT INTO `product_productattributemapstore` VALUES ('6402339746e04840932a5d400dcc8654', '红外线碳素管发光', '46381f53778d46e78f9d8e00ba0b4353');
INSERT INTO `product_productattributemapstore` VALUES ('6402339746e04840932a5d400dcc8654', '16101', '6fea61b9a33040c6b1f9211b9d2c1a8d');
INSERT INTO `product_productattributemapstore` VALUES ('6402339746e04840932a5d400dcc8654', '2000W', '8a6df07db9074b14866a615e68526710');
INSERT INTO `product_productattributemapstore` VALUES ('6402339746e04840932a5d400dcc8654', 'SKG 16101', 'c8a0f97a10ae457d9a9ea0950f254b34');
INSERT INTO `product_productattributemapstore` VALUES ('6402339746e04840932a5d400dcc8654', 'SKG', 'd3af24a382c84f25a1f9160a134141b7');
INSERT INTO `product_productattributemapstore` VALUES ('6402339746e04840932a5d400dcc8654', '1601W以上', 'f334d4083267411f892926b34ca6b4e5');
INSERT INTO `product_productattributemapstore` VALUES ('f21d18e67f274262bd836d1dea7c30f1', '126*66*14mm', '1399933b3edd47ea842bc44217057154');
INSERT INTO `product_productattributemapstore` VALUES ('f21d18e67f274262bd836d1dea7c30f1', '通用', '35199544b8a54760b98fdb324c7ccbe3');
INSERT INTO `product_productattributemapstore` VALUES ('f21d18e67f274262bd836d1dea7c30f1', '锂聚合物电池', '43d300b993d84a6ea2025d0a4866c764');
INSERT INTO `product_productattributemapstore` VALUES ('f21d18e67f274262bd836d1dea7c30f1', '双USB', '612d855d3e064eb8bba420a03d6028c3');
INSERT INTO `product_productattributemapstore` VALUES ('f21d18e67f274262bd836d1dea7c30f1', '5802', 'a923cd9569c845808d8e901767695474');
INSERT INTO `product_productattributemapstore` VALUES ('f21d18e67f274262bd836d1dea7c30f1', '否', 'b636c567253f42bc927298dd2938dc0f');
INSERT INTO `product_productattributemapstore` VALUES ('f21d18e67f274262bd836d1dea7c30f1', '否', 'b9679d4aacf44d7b94dbbf8afc54857a');
INSERT INTO `product_productattributemapstore` VALUES ('f21d18e67f274262bd836d1dea7c30f1', 'SKG', 'd3d33c8b7ca94f139e206a81d14c4b79');
INSERT INTO `product_productattributemapstore` VALUES ('f21d18e67f274262bd836d1dea7c30f1', '否', 'e9f02a63aba1419dac4689c534364ff9');
INSERT INTO `product_productattributemapstore` VALUES ('f21d18e67f274262bd836d1dea7c30f1', '150g', 'f8409b1fe7e040c9af9e43234f894214');
INSERT INTO `product_productattributemapstore` VALUES ('f21d18e67f274262bd836d1dea7c30f1', '5V', 'febcb562a77f4c3486c1d81f41861b79');
-- ----------------------------
-- Records of resource
-- ----------------------------
INSERT INTO `resource` VALUES ('328ef07d263d4d6bb816b6972151a60d', '2014-12-04 14:42:37', null, '角色管理资源', '\0', '角色:新增', '50', 'role:add');
INSERT INTO `resource` VALUES ('402881862bec2a21012bec2aff470001', '2010-10-27 13:31:02', '2010-10-27 13:31:02', '后台管理所有资源', '', '后台管理资源', '999', 'admin');
INSERT INTO `resource` VALUES ('95e6b5dd55ab4211a535cca7fe0a3077', '2014-12-04 14:32:43', null, '角色管理资源', '\0', '角色:列表', '1', 'role:list');
-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('402881862bec2a21012bec2b70510002', '2010-10-27 13:31:31', '2010-10-27 13:31:31', '拥有最高后台管理权限', '', '超级管理员', 'ROLE_ADMIN');
INSERT INTO `role` VALUES ('fec8b898e71845ac96bfabcba97b9fec', '2014-11-07 16:29:12', null, '售前客服', '\0', '客服', 'ROLE_SERVICE');
-- ----------------------------
-- Records of role_resource
-- ----------------------------
INSERT INTO `role_resource` VALUES ('402881862bec2a21012bec2b70510002', '402881862bec2a21012bec2aff470001');
INSERT INTO `role_resource` VALUES ('fec8b898e71845ac96bfabcba97b9fec', '328ef07d263d4d6bb816b6972151a60d');
INSERT INTO `role_resource` VALUES ('fec8b898e71845ac96bfabcba97b9fec', '95e6b5dd55ab4211a535cca7fe0a3077');

-- ----------------------------
-- End
-- ----------------------------
SET FOREIGN_KEY_CHECKS=1;