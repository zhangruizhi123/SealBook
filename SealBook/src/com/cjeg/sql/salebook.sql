/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : salebook

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2017-04-13 15:55:41
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin_user`
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `name` varchar(20) NOT NULL COMMENT '用户名，必须唯一',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `sex` bit(1) NOT NULL DEFAULT b'0' COMMENT '性别，1为男，0为女',
  `phone` varchar(15) NOT NULL COMMENT '电话',
  `mail` varchar(20) NOT NULL COMMENT '邮箱',
  `create_time` datetime NOT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '最后一次修改日期',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin_user
-- ----------------------------
INSERT INTO `admin_user` VALUES ('3333333', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '', '1234567', '1234567', '2017-02-28 22:01:43', '2017-03-02 22:19:15');
INSERT INTO `admin_user` VALUES ('819090d70d444ba0ac7efb626858555a', '李四', 'e10adc3949ba59abbe56e057f20f883e', '', '123456', '123456', '2017-03-02 22:07:55', '2017-03-02 22:19:31');
INSERT INTO `admin_user` VALUES ('364c91222b284051bd268bc124e5ddbd', '王五', 'e10adc3949ba59abbe56e057f20f883e', '', '123456', '123456', '2017-03-02 22:17:13', '2017-03-02 22:17:13');

-- ----------------------------
-- Table structure for `book`
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '书名',
  `descripts` varchar(400) NOT NULL COMMENT '书本简介',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态 0：下架 ，1：上架',
  `author` varchar(20) NOT NULL COMMENT '作者',
  `create_date` datetime NOT NULL COMMENT '创建日期',
  `update_date` datetime DEFAULT NULL COMMENT '修改日期',
  `publish_data` date NOT NULL COMMENT '出版日期',
  `prime_cost` float DEFAULT NULL COMMENT '原价',
  `current_price` float DEFAULT NULL COMMENT '现价',
  `image` varchar(200) DEFAULT NULL COMMENT '书本的封面',
  `publishing_company` varchar(100) DEFAULT NULL COMMENT '出版社名字',
  `type` varchar(32) NOT NULL COMMENT '书籍类型\r\n保存的是类型表中的id，',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES ('65d5cb3111e44160a56f500def172744', '疯狂Java讲义', 'zzczczx', '1', '李刚', '2017-02-19 00:25:31', '2017-03-10 22:06:04', '2017-02-16', '88', '22.5', '/SealBook/files/5fffb44f6d6144ce8c432c4c96e6a42d.png', '电子工业出版社', 'a36ca8a828354b5e9379b6274902bb3b');
INSERT INTO `book` VALUES ('1247aa0c339a4efcaf8efdd4951aefdd', '疯狂Java讲义', '李刚的疯狂Java讲义1', '1', '李刚', '2017-02-19 11:19:27', '2017-03-05 20:52:34', '2017-02-19', '88.5', '22.58', '/SealBook/files/8d949ea28823442d95d7ec6eb7789389.jpg', '清华大学出版社', '4c60488df8c34c35b6dcd00ba1b2f137');
INSERT INTO `book` VALUES ('4cce35a3ffe64e029617fd0be60c68b4', 'C语言程序设计', '这本书很好看1', '1', '曹倩倩', '2017-02-21 21:48:24', '2017-02-26 10:31:41', '2017-02-21', '99', '77', '/SealBook/files/355a0d03529741f9b89d9b0c2f8e9011.png', '清华大学出版社', 'a36ca8a828354b5e9379b6274902bb3b');
INSERT INTO `book` VALUES ('9b618e9b76f54e72ac41f2b340570bf6', '衣领杂志', '这本书灰常好看', '1', '曹倩倩', '2017-02-20 22:01:37', '2017-02-26 10:19:43', '2017-02-21', '99', '66', '/SealBook/files/851aa5efbb114b41bda3270316ccb78c.jpg', '电子工业出版社', '4c60488df8c34c35b6dcd00ba1b2f137');
INSERT INTO `book` VALUES ('3797f8125ca045abb451e2db078b4c39', '21天精通Java', '这本书真的很好看', '1', '曹倩倩', '2017-02-20 21:57:11', '2017-02-26 10:19:51', '2017-02-20', '88', '66', '/SealBook/files/fd246159b5d5480a8c066ff4bcfaf3db.png', '清华大学', 'a36ca8a828354b5e9379b6274902bb3b');
INSERT INTO `book` VALUES ('9c0faff585b9437c8e982fd943d23715', '测试', '测试书籍', '1', '测试', '2017-02-22 22:21:43', '2017-02-22 22:21:43', '2017-02-22', '66', '44', '/SealBook/files/7d283047a36b4fc684ef1f65a38323ee.png', '测试', '');
INSERT INTO `book` VALUES ('1f1cf9d12f3e4e33a0833c8b0588bce0', '测试', '测试', '1', '曹倩倩', '2017-03-04 12:38:24', '2017-04-04 13:46:31', '2017-03-04', '99', '22', '/SealBook/files/3e41ab7d2b294314a2c30bd7f9f3b0d5.png', '清华出版社', 'a36ca8a828354b5e9379b6274902bb3b');
INSERT INTO `book` VALUES ('5df98c5ece5e4a148ed4d7217637365c', 'sfsf', 'ararwqrwrewrtew', '1', 'sdfsd', '2017-03-05 20:46:05', '2017-04-04 13:45:58', '2017-03-05', '2', '3', '/SealBook/files/7c60e6c2790d4270944c2f20708240cb.png', 'sfsfd', 'a36ca8a828354b5e9379b6274902bb3b');

-- ----------------------------
-- Table structure for `dic`
-- ----------------------------
DROP TABLE IF EXISTS `dic`;
CREATE TABLE `dic` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `value` varchar(200) NOT NULL COMMENT '值',
  `descripts` varchar(200) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dic
-- ----------------------------
INSERT INTO `dic` VALUES ('8646c172d9194d68ae05e773a2c93f63', 'NOTICE_MESSAGE', '通知：明天有促销活动', '公告提示信息');
INSERT INTO `dic` VALUES ('d0c795eb4b2043fb8f6c4ff17f3ea539', 'FIRST_IMG', '/SealBook/files/191262b0b2b44b75809f501b788cdbaa.png', '首页大图片');
INSERT INTO `dic` VALUES ('60b02cf4d34f48228c04e4b567341b13', 'FIRST_BOOK_DESCRIPTS', 'java核心技术', '大图对应书籍描述');
INSERT INTO `dic` VALUES ('248824f324d143e5a2318c5384ff0a43', 'FIRST_BOOK_LINK', 'www.baidu.com', '大图对应书籍链接');
INSERT INTO `dic` VALUES ('e3d06146e5db4f6396f9e2471d14cc19', 'FIRST_BOOK_NAME', 'java', '大图对应书籍名称');

-- ----------------------------
-- Table structure for `type_t`
-- ----------------------------
DROP TABLE IF EXISTS `type_t`;
CREATE TABLE `type_t` (
  `id` char(32) NOT NULL DEFAULT '主键',
  `name` varchar(100) NOT NULL COMMENT '类型名称',
  `create_time` datetime NOT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '修改日期',
  `descripts` varchar(200) DEFAULT NULL COMMENT '说明',
  `sort` tinyint(4) NOT NULL DEFAULT '0' COMMENT '排序',
  `shows` bit(1) NOT NULL DEFAULT b'1' COMMENT '首页是否显示\r\n1显示，0不显示',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of type_t
-- ----------------------------
INSERT INTO `type_t` VALUES ('a36ca8a828354b5e9379b6274902bb3b', '编程类', '2017-02-23 22:58:20', '2017-03-04 10:22:58', '编程和数据库', '1', '');
INSERT INTO `type_t` VALUES ('4c60488df8c34c35b6dcd00ba1b2f137', '杂志类', '2017-02-26 09:30:39', '2017-03-04 10:23:07', '这是杂志类书籍', '2', '');
INSERT INTO `type_t` VALUES ('8a148d091ec44a7a8d46fa5a64071c00', '计算机编程', '2017-03-04 10:03:25', '2017-03-04 10:21:13', '计算机编程', '0', '');
INSERT INTO `type_t` VALUES ('8099ea0e31234df5addf107d6b3ccbe6', '计算机网络', '2017-03-04 10:03:35', '2017-03-04 10:21:20', '计算机网络', '0', '');
INSERT INTO `type_t` VALUES ('a9cce0f8660c4beda236560eeb276c90', '考试认证', '2017-03-04 10:03:44', '2017-03-04 10:21:24', '考试认证', '0', '');
INSERT INTO `type_t` VALUES ('d7ab23935de34ed788e7c2422d0d89d9', '工具书籍', '2017-03-04 10:03:55', '2017-03-04 10:21:29', '工具书籍', '0', '');
INSERT INTO `type_t` VALUES ('0e027685bae444788431b328311d32f8', '游戏', '2017-03-04 10:04:11', '2017-03-04 10:21:33', '游戏', '0', '');
INSERT INTO `type_t` VALUES ('68a4d8bb9c594ddeb2f87a2f92ce98d4', '操作系统', '2017-03-04 10:04:18', '2017-03-04 10:21:38', '操作系统', '0', '');
INSERT INTO `type_t` VALUES ('b9bb9769e89a49b380c28ec070420d96', '图形学', '2017-03-04 10:04:26', '2017-03-04 10:21:42', '图形学', '0', '');
INSERT INTO `type_t` VALUES ('e8e22f2878a64a70a2a4825f1b0ff3b6', '多媒体', '2017-03-04 10:04:34', '2017-03-04 10:21:48', '多媒体', '0', '');
INSERT INTO `type_t` VALUES ('05e9e46be33646e38cebf0d7f7296128', '嵌入式', '2017-03-04 10:04:41', '2017-03-04 10:21:54', '网络通信嵌入式', '0', '');
INSERT INTO `type_t` VALUES ('5d8e5301116c4f3cab16b2a044f7082a', '测试', '2017-03-18 20:43:26', '2017-03-18 20:43:26', '测试', '0', '');

-- ----------------------------
-- Table structure for `user_book`
-- ----------------------------
DROP TABLE IF EXISTS `user_book`;
CREATE TABLE `user_book` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `book_id` varchar(32) NOT NULL COMMENT '书籍id',
  `user_id` varchar(32) NOT NULL COMMENT '用户id',
  `type_id` varchar(32) NOT NULL COMMENT '书籍类型id',
  `number` int(11) NOT NULL COMMENT '商品的数量',
  `evaluate` varchar(300) DEFAULT NULL COMMENT '评价',
  `status` tinyint(4) NOT NULL COMMENT '状态  0：加入购物车，1：购买，2：已经结账，3：已经发货,4,：已经收货 ，5：已经评价，6,：已经完成',
  `create_time` datetime NOT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '修改日期',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_book
-- ----------------------------
INSERT INTO `user_book` VALUES ('562d3a8b7b094dcbb05afee77bc0a19a', '1f1cf9d12f3e4e33a0833c8b0588bce0', '3f19be83d25d4e0d8ed0bbd11ef86a39', 'a36ca8a828354b5e9379b6274902bb3b', '1', null, '4', '2017-03-04 20:50:14', '2017-03-04 20:50:14');
INSERT INTO `user_book` VALUES ('e18a4b5ec6014655ac1e60076420d687', '3797f8125ca045abb451e2db078b4c39', '3f19be83d25d4e0d8ed0bbd11ef86a39', 'a36ca8a828354b5e9379b6274902bb3b', '1', null, '0', '2017-03-04 14:43:36', '2017-03-04 14:43:36');
INSERT INTO `user_book` VALUES ('6c43cf8057cd44b1aa5e712e2b7a0db6', '1f1cf9d12f3e4e33a0833c8b0588bce0', '3f19be83d25d4e0d8ed0bbd11ef86a39', 'a36ca8a828354b5e9379b6274902bb3b', '1', null, '2', '2017-03-18 20:39:07', '2017-03-18 20:39:07');

-- ----------------------------
-- Table structure for `user_t`
-- ----------------------------
DROP TABLE IF EXISTS `user_t`;
CREATE TABLE `user_t` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `name` varchar(20) NOT NULL COMMENT '用户名，必须唯一',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `sex` bit(1) NOT NULL DEFAULT b'0' COMMENT '性别，1为男，0为女',
  `phone` varchar(15) NOT NULL COMMENT '电话',
  `mail` varchar(20) NOT NULL COMMENT '邮箱',
  `create_time` datetime NOT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '最后一次修改日期',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_t
-- ----------------------------
INSERT INTO `user_t` VALUES ('3f19be83d25d4e0d8ed0bbd11ef86a39', 'zhangsan', 'e10adc3949ba59abbe56e057f20f883e', '', '123456', 'zhangs', '2017-02-26 19:36:25', '2017-02-26 19:36:25');
INSERT INTO `user_t` VALUES ('62677f409b554400ab620b09d73ccb6d', 'lisi', 'e10adc3949ba59abbe56e057f20f883e', '', 'dsdswe', 'zhangs', '2017-02-26 20:27:42', '2017-02-26 20:27:42');
INSERT INTO `user_t` VALUES ('d9947cb19e2b4639b59b96bcbaa92835', 'wangwu', 'e10adc3949ba59abbe56e057f20f883e', '', '1234567', 'zhangs', '2017-02-26 20:29:47', '2017-02-26 20:29:47');
