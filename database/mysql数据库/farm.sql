/*
Navicat MySQL Data Transfer

Source Server         : admin
Source Server Version : 50711
Source Host           : 127.0.0.1:3306
Source Database       : farm

Target Server Type    : MYSQL
Target Server Version : 50711
File Encoding         : 65001

Date: 2019-06-02 11:04:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_category
-- ----------------------------
DROP TABLE IF EXISTS `t_category`;
CREATE TABLE `t_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_category
-- ----------------------------
INSERT INTO `t_category` VALUES ('1', '普通');
INSERT INTO `t_category` VALUES ('2', '高级');
INSERT INTO `t_category` VALUES ('3', '梦幻');

-- ----------------------------
-- Table structure for t_land
-- ----------------------------
DROP TABLE IF EXISTS `t_land`;
CREATE TABLE `t_land` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_land
-- ----------------------------
INSERT INTO `t_land` VALUES ('1', '黄土地');
INSERT INTO `t_land` VALUES ('2', '棕土地');
INSERT INTO `t_land` VALUES ('3', '红土地');
INSERT INTO `t_land` VALUES ('4', '黑土地');

-- ----------------------------
-- Table structure for t_phase
-- ----------------------------
DROP TABLE IF EXISTS `t_phase`;
CREATE TABLE `t_phase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seedId` int(11) DEFAULT NULL,
  `phase` int(11) DEFAULT NULL,
  `title` varchar(24) DEFAULT NULL,
  `growthTime` int(11) DEFAULT NULL,
  `chance` double DEFAULT NULL,
  `width` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `offsetX` double DEFAULT NULL,
  `offsetY` double DEFAULT NULL,
  `statusId` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_phase
-- ----------------------------
INSERT INTO `t_phase` VALUES ('4', '1', '1', '草莓一阶段', '20', '1', '114', '90', '49', '171', '1');
INSERT INTO `t_phase` VALUES ('5', '1', '2', '草莓二阶段', '30', '0.6', '102', '102', '46', '172', '2');
INSERT INTO `t_phase` VALUES ('9', '1', '3', '草莓三阶段', '40', '0.5', '102', '102', '46', '172', '2');
INSERT INTO `t_phase` VALUES ('10', '1', '4', '草莓四阶段', '40', '0.3', '102', '102', '46', '172', '2');
INSERT INTO `t_phase` VALUES ('11', '1', '5', '草莓五阶段', '10', '0.2', '102', '102', '46', '172', '3');
INSERT INTO `t_phase` VALUES ('12', '14', '1', '西瓜一阶段', '10', '1', '102', '102', '61', '183', '1');
INSERT INTO `t_phase` VALUES ('13', '14', '2', '西瓜二阶段', '12', '0.8', '124', '118', '54', '162', '2');
INSERT INTO `t_phase` VALUES ('14', '14', '3', '西瓜三阶段', '12', '0.6', '162', '109', '43', '149', '2');
INSERT INTO `t_phase` VALUES ('15', '14', '4', '西瓜四阶段', '16', '0.5', '147', '102', '51', '163', '2');
INSERT INTO `t_phase` VALUES ('16', '14', '5', '西瓜五阶段', '12', '0.4', '114', '117', '37', '151', '3');
INSERT INTO `t_phase` VALUES ('17', '1', '0', '草莓零阶段', '10', '0.8', '114', '90', '49', '171', '1');
INSERT INTO `t_phase` VALUES ('18', '1', '6', '草莓六阶段', '0', '0', '114', '90', '49', '171', '4');
INSERT INTO `t_phase` VALUES ('19', '14', '0', '西瓜零阶段', '10', '0.8', '114', '90', '49', '171', '1');
INSERT INTO `t_phase` VALUES ('20', '14', '6', '西瓜六阶段', '0', '0', '114', '90', '49', '171', '4');
INSERT INTO `t_phase` VALUES ('21', '13', '0', '葡萄0阶段', '20', '0.8', '102', '102', '50', '174', '1');
INSERT INTO `t_phase` VALUES ('22', '13', '1', '葡萄1阶段', '20', '0.8', '102', '102', '54', '174', '2');
INSERT INTO `t_phase` VALUES ('23', '13', '2', '葡萄2阶段', '25', '0.7', '102', '102', '49', '157', '2');
INSERT INTO `t_phase` VALUES ('24', '13', '3', '葡萄3阶段', '30', '0.6', '102', '102', '58', '146', '2');
INSERT INTO `t_phase` VALUES ('25', '13', '4', '葡萄4阶段', '30', '0.4', '102', '102', '51', '152', '2');
INSERT INTO `t_phase` VALUES ('26', '13', '5', '葡萄5阶段', '30', '0.3', '102', '102', '52', '146', '3');
INSERT INTO `t_phase` VALUES ('27', '13', '6', '葡萄6阶段', '0', '0', '102', '102', '57', '152', '4');
INSERT INTO `t_phase` VALUES ('28', '7', '0', '西红柿0阶段', '20', '0.8', '102', '102', '43', '170', '1');
INSERT INTO `t_phase` VALUES ('29', '7', '1', '西红柿1阶段', '20', '0.8', '102', '102', '60', '174', '2');
INSERT INTO `t_phase` VALUES ('30', '7', '2', '西红柿2阶段', '20', '0.7', '102', '102', '63', '159', '2');
INSERT INTO `t_phase` VALUES ('31', '7', '3', '西红柿3阶段', '25', '0.5', '102', '102', '58', '165', '2');
INSERT INTO `t_phase` VALUES ('32', '7', '4', '西红柿4阶段', '30', '0.4', '102', '102', '59', '154', '2');
INSERT INTO `t_phase` VALUES ('33', '7', '5', '西红柿5阶段', '30', '0.3', '106', '106', '51', '144', '3');
INSERT INTO `t_phase` VALUES ('34', '7', '6', '西红柿6阶段', '0', '0', '102', '102', '53', '160', '4');
INSERT INTO `t_phase` VALUES ('35', '6', '0', '茄子0阶段', '20', '0.8', '102', '102', '50', '177', '1');
INSERT INTO `t_phase` VALUES ('36', '6', '1', '茄子1阶段', '30', '0.8', '102', '102', '55', '162', '1');
INSERT INTO `t_phase` VALUES ('37', '6', '2', '茄子2阶段', '30', '0.6', '102', '102', '46', '165', '2');
INSERT INTO `t_phase` VALUES ('38', '6', '3', '茄子3阶段', '30', '0.6', '102', '102', '52', '164', '2');
INSERT INTO `t_phase` VALUES ('39', '6', '4', '茄子4阶段', '30', '0.5', '102', '102', '49', '167', '2');
INSERT INTO `t_phase` VALUES ('40', '6', '5', '茄子5阶段', '30', '0.4', '102', '102', '55', '168', '3');
INSERT INTO `t_phase` VALUES ('41', '6', '6', '茄子6阶段', '0', '0', '102', '102', '53', '169', '4');
INSERT INTO `t_phase` VALUES ('42', '8', '0', '豆荚0阶段', '25', '0.8', '102', '102', '46', '171', '1');
INSERT INTO `t_phase` VALUES ('43', '8', '1', '豆芽1阶段', '30', '0.8', '102', '102', '44', '154', '2');
INSERT INTO `t_phase` VALUES ('44', '8', '2', '豆芽2阶段', '30', '0.7', '102', '102', '52', '157', '2');
INSERT INTO `t_phase` VALUES ('45', '8', '3', '豆芽3阶段', '30', '0.6', '102', '102', '50', '160', '2');
INSERT INTO `t_phase` VALUES ('46', '8', '4', '豆芽4阶段', '30', '0.6', '102', '102', '52', '161', '2');
INSERT INTO `t_phase` VALUES ('47', '8', '5', '豆芽5阶段', '30', '0.4', '102', '102', '53', '166', '3');
INSERT INTO `t_phase` VALUES ('48', '8', '6', '豆芽6阶段', '0', '0', '102', '102', '51', '168', '4');
INSERT INTO `t_phase` VALUES ('49', '9', '0', '辣椒0阶段', '30', '0.8', '102', '102', '47', '174', '1');
INSERT INTO `t_phase` VALUES ('50', '9', '1', '辣椒1阶段', '30', '0.8', '102', '102', '48', '169', '2');
INSERT INTO `t_phase` VALUES ('51', '9', '2', '辣椒2阶段', '30', '0.6', '102', '102', '47', '173', '2');
INSERT INTO `t_phase` VALUES ('52', '9', '3', '辣椒3阶段', '34', '0.4', '102', '102', '51', '172', '2');
INSERT INTO `t_phase` VALUES ('53', '9', '4', '辣椒4阶段', '36', '0.4', '102', '102', '49', '165', '2');
INSERT INTO `t_phase` VALUES ('54', '9', '5', '辣椒5阶段', '36', '0.3', '102', '102', '53', '172', '3');
INSERT INTO `t_phase` VALUES ('55', '9', '6', '辣椒6阶段', '0', '0', '102', '102', '53', '168', '4');

-- ----------------------------
-- Table structure for t_plant
-- ----------------------------
DROP TABLE IF EXISTS `t_plant`;
CREATE TABLE `t_plant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `phaseId` int(11) DEFAULT NULL,
  `landIndex` int(11) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `landId` int(11) DEFAULT NULL,
  `nowSeason` int(11) DEFAULT '0',
  `worm` tinyint(4) DEFAULT '0',
  `reduce` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=279 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_plant
-- ----------------------------
INSERT INTO `t_plant` VALUES ('247', '1', null, '2', '0', '3', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('248', '1', null, '1', '0', '2', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('249', '1', null, '0', '0', '1', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('250', '1', '18', '4', '0', '1', '1', '1', '4');
INSERT INTO `t_plant` VALUES ('251', '1', null, '5', '0', '2', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('252', '1', null, '8', '0', '1', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('253', '1', null, '6', '0', '3', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('254', '1', null, '3', '0', '4', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('255', '1', null, '9', '0', '2', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('256', '1', null, '7', '0', '4', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('257', '1', null, '10', '0', '3', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('258', '1', null, '11', '0', '4', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('259', '1', '18', '4', '0', '1', '1', '1', '5');
INSERT INTO `t_plant` VALUES ('260', '1', null, '5', '0', '2', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('261', '1', null, '6', '0', '3', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('262', '1', '18', '8', '0', '1', '2', '1', '5');
INSERT INTO `t_plant` VALUES ('263', '1', null, '3', '0', '4', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('264', '1', null, '7', '0', '4', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('265', '1', '18', '4', '0', '1', '1', '1', '1');
INSERT INTO `t_plant` VALUES ('266', '2', null, '0', '0', '1', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('267', '2', null, '1', '0', '2', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('268', '2', null, '2', '0', '3', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('269', '2', null, '3', '0', '4', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('270', '2', null, '4', '0', '1', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('271', '2', null, '6', '0', '3', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('272', '2', null, '5', '0', '2', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('273', '2', null, '7', '0', '4', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('274', '2', null, '7', '0', '4', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('275', '2', null, '11', '0', '4', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('276', '2', null, '10', '0', '3', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('277', '2', null, '9', '0', '2', '0', '0', '0');
INSERT INTO `t_plant` VALUES ('278', '2', null, '8', '0', '1', '0', '0', '0');

-- ----------------------------
-- Table structure for t_repository
-- ----------------------------
DROP TABLE IF EXISTS `t_repository`;
CREATE TABLE `t_repository` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `seedId` int(11) NOT NULL,
  `num` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_repository
-- ----------------------------
INSERT INTO `t_repository` VALUES ('1', '2', '4', '22');
INSERT INTO `t_repository` VALUES ('2', '1', '5', '17');
INSERT INTO `t_repository` VALUES ('3', '1', '4', '11');
INSERT INTO `t_repository` VALUES ('4', '3', '4', '2');
INSERT INTO `t_repository` VALUES ('5', '3', '5', '5');
INSERT INTO `t_repository` VALUES ('6', '3', '6', '2');
INSERT INTO `t_repository` VALUES ('7', '2', '7', '10');
INSERT INTO `t_repository` VALUES ('8', '1', '6', '11');
INSERT INTO `t_repository` VALUES ('9', '3', '8', '14');
INSERT INTO `t_repository` VALUES ('10', '2', '6', '7');
INSERT INTO `t_repository` VALUES ('11', '1', '7', '9');
INSERT INTO `t_repository` VALUES ('12', '1', '8', '10');
INSERT INTO `t_repository` VALUES ('13', '1', '9', '10');
INSERT INTO `t_repository` VALUES ('14', '1', '10', '25');
INSERT INTO `t_repository` VALUES ('15', '2', '5', '7');
INSERT INTO `t_repository` VALUES ('16', '2', '8', '6');
INSERT INTO `t_repository` VALUES ('17', '2', '10', '15');
INSERT INTO `t_repository` VALUES ('18', '2', '9', '10');
INSERT INTO `t_repository` VALUES ('19', '3', '10', '9');

-- ----------------------------
-- Table structure for t_seed
-- ----------------------------
DROP TABLE IF EXISTS `t_seed`;
CREATE TABLE `t_seed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seedId` int(11) NOT NULL,
  `name` varchar(15) DEFAULT NULL,
  `season` int(4) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `experience` int(11) DEFAULT NULL,
  `harvestTime` int(11) DEFAULT NULL,
  `harvestNum` int(8) DEFAULT NULL,
  `seedPurPrice` int(11) DEFAULT NULL,
  `fruitPrice` int(11) DEFAULT NULL,
  `landId` int(11) DEFAULT NULL,
  `integral` int(11) DEFAULT NULL,
  `tip` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_seed
-- ----------------------------
INSERT INTO `t_seed` VALUES ('4', '1', '草莓', '2', '1', '1', '10', '50', '3', '4', '2', '1', '10', 'strawberry、拉丁学名：Fragaria × ananassa Duch.），多年生草本植物。');
INSERT INTO `t_seed` VALUES ('5', '14', '西瓜', '1', '1', '1', '10', '50', '1', '2', '4', '1', '10', '蔷薇科、桃属植物。落叶小乔木；叶为窄椭圆形至披针形');
INSERT INTO `t_seed` VALUES ('6', '13', '葡萄', '3', '1', '2', '10', '50', '2', '6', '3', '2', '20', '一年生蔓生藤本；茎、枝粗壮，具明显的棱');
INSERT INTO `t_seed` VALUES ('7', '6', '茄子', '1', '1', '2', '10', '50', '3', '4', '2', '2', '12', '小枝多为紫色（野生的往往有皮刺），渐老则毛被逐渐脱落');
INSERT INTO `t_seed` VALUES ('8', '8', '豆荚', '1', '1', '3', '10', '50', '3', '3', '2', '3', '13', '是豆科植物特有的果实类型，属于单果中的干果中的裂果的一种');
INSERT INTO `t_seed` VALUES ('9', '7', '西红柿', '2', '1', '3', '10', '50', '3', '3', '2', '4', '12', '西红柿，学名叫番茄，是茄科番茄属中以成熟多汁浆果为产品的草木植物。我国栽培的番茄是从国外引种的');
INSERT INTO `t_seed` VALUES ('10', '9', '辣椒', '2', '1', '4', '10', '50', '3', '3', '2', '4', '10', '辣椒，别名：牛角椒、长辣椒、菜椒、灯笼椒，拉丁文名：Capsicum annuum L.，为木兰纲、茄科、辣椒属一年或有限多年生草本植物。');

-- ----------------------------
-- Table structure for t_status
-- ----------------------------
DROP TABLE IF EXISTS `t_status`;
CREATE TABLE `t_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_status
-- ----------------------------
INSERT INTO `t_status` VALUES ('1', '发芽期');
INSERT INTO `t_status` VALUES ('2', '生长期');
INSERT INTO `t_status` VALUES ('3', '成熟期');
INSERT INTO `t_status` VALUES ('4', '枯草期');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `head` varchar(50) DEFAULT NULL,
  `username` varchar(16) DEFAULT NULL,
  `nickname` varchar(16) DEFAULT NULL,
  `experience` int(11) DEFAULT NULL,
  `integral` int(11) DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', '1545120190527.jpg', '刘备', '玄德', '1814', '2005', '756');
INSERT INTO `t_user` VALUES ('2', '5852220190527.jpg', '关羽', '云长', '736', '835', '407');
INSERT INTO `t_user` VALUES ('3', '9598420190508.jpg', '曹操', '孟德', '200', '100', '67');
