# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.18)
# Database: 2
# Generation Time: 2017-07-29 06:28:10 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- ----------------------------
-- Table structure for `ss_node`
-- ----------------------------
create TABLE `ss_node` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '服务类型：1-SS、2-V2ray',
  `name` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '名称',
  `group_id` INT(11) NOT NULL DEFAULT '0' COMMENT '所属分组',
  `country_code` CHAR(5) NOT NULL DEFAULT 'un' COMMENT '国家代码',
  `server` VARCHAR(128) NULL DEFAULT '' COMMENT '服务器域名地址',
  `ip` CHAR(15) NULL DEFAULT '' COMMENT '服务器IPV4地址',
  `ipv6` CHAR(128) NULL DEFAULT '' COMMENT '服务器IPV6地址',
  `desc` VARCHAR(255) NULL DEFAULT '' COMMENT '节点简单描述',
  `method` VARCHAR(32) NOT NULL DEFAULT 'aes-256-cfb' COMMENT '加密方式',
  `protocol` VARCHAR(64) NOT NULL DEFAULT 'origin' COMMENT '协议',
  `protocol_param` VARCHAR(128) NULL DEFAULT '' COMMENT '协议参数',
  `obfs` VARCHAR(64) NOT NULL DEFAULT 'plain' COMMENT '混淆',
  `obfs_param` VARCHAR(255) NULL DEFAULT '' COMMENT '混淆参数',
  `traffic_rate` FLOAT NOT NULL DEFAULT '1.00' COMMENT '流量比率',
  `bandwidth` INT(11) NOT NULL DEFAULT '100' COMMENT '出口带宽，单位M',
  `traffic` INT(20) NOT NULL DEFAULT '1000' COMMENT '每月可用流量，单位G',
  `monitor_url` VARCHAR(255) NULL DEFAULT NULL COMMENT '监控地址',
  `is_subscribe` TINYINT(4) NULL DEFAULT '1' COMMENT '是否允许用户订阅该节点：0-否、1-是',
  `is_ddns` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '是否使用DDNS：0-否、1-是',
  `is_transit` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '是否中转节点：0-否、1-是',
  `ssh_port` SMALLINT(6) UNSIGNED NOT NULL DEFAULT '22' COMMENT 'SSH端口',
  `detectionType` TINYINT(4) NOT NULL DEFAULT '1' COMMENT '节点检测: 0-关闭、1-只检测TCP、2-只检测ICMP、3-检测全部',
  `compatible` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '兼容SS',
  `single` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '启用单端口功能：0-否、1-是',
  `port` varchar(50) NULL COMMENT '单端口的端口号',
  `passwd` varchar(255) NULL COMMENT '单端口的连接密码',
  `sort` INT(11) NOT NULL DEFAULT '0' COMMENT '排序值，值越大越靠前显示',
  `status` TINYINT(4) NOT NULL DEFAULT '1' COMMENT '状态：0-维护、1-正常',
  `v2_alter_id` INT(11) NOT NULL DEFAULT '16' COMMENT 'V2ray额外ID',
  `v2_port` INT(11) NOT NULL DEFAULT '0' COMMENT 'V2ray端口',
  `v2_method` VARCHAR(32) NOT NULL DEFAULT 'aes-128-gcm' COMMENT 'V2ray加密方式',
  `v2_net` VARCHAR(16) NOT NULL DEFAULT 'tcp' COMMENT 'V2ray传输协议',
  `v2_type` VARCHAR(32) NOT NULL DEFAULT 'none' COMMENT 'V2ray伪装类型',
  `v2_host` VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'V2ray伪装的域名',
  `v2_path` VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'V2ray WS/H2路径',
  `v2_tls` TINYINT(4) NOT NULL DEFAULT '0' COMMENT 'V2ray底层传输安全 0 未开启 1 开启',
  `v2_insider_port` INT(11) NOT NULL DEFAULT '10550' COMMENT 'V2ray内部端口（内部监听），v2_port为0时有效',
  `v2_outsider_port` INT(11) NOT NULL DEFAULT '443' COMMENT 'V2ray外部端口（外部覆盖），v2_port为0时有效',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_group` (`group_id`),
	INDEX `idx_sub` (`is_subscribe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='节点信息表';


-- ----------------------------
-- Table structure for `ss_node_info`
-- ----------------------------
create TABLE `ss_node_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL DEFAULT '0' COMMENT '节点ID',
  `uptime` int(11) NOT NULL COMMENT '后端存活时长，单位秒',
  `load` varchar(255) NOT NULL COMMENT '负载',
  `log_time` int(11) NOT NULL COMMENT '记录时间',
  PRIMARY KEY (`id`),
  INDEX `idx_node_id` (`node_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='节点心跳信息';


-- ----------------------------
-- Table structure for `ss_node_online_log`
-- ----------------------------
create TABLE `ss_node_online_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL COMMENT '节点ID',
  `online_user` int(11) NOT NULL COMMENT '在线用户数',
  `log_time` int(11) NOT NULL COMMENT '记录时间',
  PRIMARY KEY (`id`),
  INDEX `idx_node_id` (`node_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='节点在线信息';

-- ----------------------------
-- Table structure for `ss_node_ping`
-- ----------------------------
create TABLE `ss_node_ping` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `node_id` INT(11) NOT NULL DEFAULT '0' COMMENT '对应节点id',
  `ct` INT(11) NOT NULL DEFAULT '0' COMMENT '电信',
  `cu` INT(11) NOT NULL DEFAULT '0' COMMENT '联通',
  `cm` INT(11) NOT NULL DEFAULT '0' COMMENT '移动',
  `hk` INT(11) NOT NULL DEFAULT '0' COMMENT '香港',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_node_id` (`node_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='节点ping信息表';

-- ----------------------------
-- Table structure for `ss_node_label`
-- ----------------------------
create TABLE `ss_node_label` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `label_id` int(11) NOT NULL DEFAULT '0' COMMENT '标签ID',
  PRIMARY KEY (`id`),
  INDEX `idx_node_label` (`node_id`,`label_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='节点标签';


-- ----------------------------
-- Table structure for `user`
-- ----------------------------
create TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` text NOT NULL DEFAULT '' COMMENT '昵称',
  `email` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(64) NOT NULL DEFAULT '' COMMENT '密码',
  `port` int(11) NOT NULL DEFAULT '0' COMMENT '代理端口',
  `passwd` varchar(16) NOT NULL DEFAULT '' COMMENT '代理密码',
  `vmess_id` varchar(64) NOT NULL DEFAULT '' COMMENT 'V2Ray用户ID',
  `transfer_enable` bigint(20) NOT NULL DEFAULT '1099511627776' COMMENT '可用流量，单位字节，默认1TiB',
  `u` bigint(20) NOT NULL DEFAULT '0' COMMENT '已上传流量，单位字节',
  `d` bigint(20) NOT NULL DEFAULT '0' COMMENT '已下载流量，单位字节',
  `t` int(11) NOT NULL DEFAULT '0' COMMENT '最后使用时间',
  `ip` char(128) DEFAULT NULL COMMENT '最后连接IP',
  `enable` tinyint(4) NOT NULL DEFAULT '1' COMMENT '代理状态',
  `method` varchar(30) NOT NULL DEFAULT 'aes-256-cfb' COMMENT '加密方式',
  `protocol` varchar(30) NOT NULL DEFAULT 'origin' COMMENT '协议',
  `protocol_param` varchar(255) DEFAULT '' COMMENT '协议参数',
  `obfs` varchar(30) NOT NULL DEFAULT 'plain' COMMENT '混淆',
  `obfs_param` varchar(255) DEFAULT '' COMMENT '混淆参数',
  `speed_limit_per_con` bigint(20) NOT NULL DEFAULT '10737418240' COMMENT '单连接限速，默认10G，为0表示不限速，单位Byte',
  `speed_limit_per_user` bigint(20) NOT NULL DEFAULT '10737418240' COMMENT '单用户限速，默认10G，为0表示不限速，单位Byte',
  `wechat` varchar(30) DEFAULT '' COMMENT '微信',
  `qq` varchar(20) DEFAULT '' COMMENT 'QQ',
  `usage` VARCHAR(10) NOT NULL DEFAULT '4' COMMENT '用途：1-手机、2-电脑、3-路由器、4-其他',
  `pay_way` tinyint(4) NOT NULL DEFAULT '0' COMMENT '付费方式：0-免费、1-季付、2-月付、3-半年付、4-年付',
  `balance` int(11) NOT NULL DEFAULT '0' COMMENT '余额，单位分',
  `enable_time` date DEFAULT NULL COMMENT '开通日期',
  `expire_time` date NOT NULL DEFAULT '2099-01-01' COMMENT '过期时间',
  `ban_time` int(11) NOT NULL DEFAULT '0' COMMENT '封禁到期时间',
  `remark` text COMMENT '备注',
  `level` tinyint(4) NOT NULL DEFAULT '1' COMMENT '等级：可定义名称',
  `is_admin` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否管理员：0-否、1-是',
  `reg_ip` char(128) NOT NULL DEFAULT '127.0.0.1' COMMENT '注册IP',
  `last_login` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `referral_uid` int(11) NOT NULL DEFAULT '0' COMMENT '邀请人',
  `reset_time` datetime DEFAULT NULL COMMENT '流量重置日期，NULL表示不重置',
  `invite_num` INT NOT NULL DEFAULT '0' COMMENT '可生成邀请码数',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态：-1-禁用、0-未激活、1-正常',
  `remember_token` varchar(256) DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `unq_email` (`email`),
  INDEX `idx_search` (`enable`, `status`, `port`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户';


LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

insert into `user` (`id`, `username`, `email`, `password`, `port`, `passwd`, `vmess_id`, `transfer_enable`, `u`, `d`, `t`, `enable`, `method`, `protocol`, `obfs`, `obfs_param`, `wechat`, `qq`, `usage`, `pay_way`, `balance`, `enable_time`, `expire_time`, `remark`, `is_admin`, `reg_ip`, `status`, `created_at`, `updated_at`)
VALUES (1,'管理员','test@test.com','$2y$10$ryMdx5ejvCSdjvZVZAPpOuxHrsAUY8FEINUATy6RCck6j9EeHhPfq',10000,'@123', 'c6effafd-6046-7a84-376e-b0429751c304', 1099511627776,0,0,0,1,'aes-256-cfb','origin','plain',0,'','',1,3,0.00,'2017-01-01','2099-01-01',NULL,1,'127.0.0.1',1,now(),now());

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;


-- ----------------------------
-- Table structure for `level`
-- ----------------------------
create TABLE `level` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` int(11) NOT NULL DEFAULT '1' COMMENT '等级',
  `level_name` varchar(100) NOT NULL DEFAULT '' COMMENT '等级名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='等级';


-- ----------------------------
-- Records of `level`
-- ----------------------------
insert into `level` VALUES (1, '1', '普通用户');
insert into `level` VALUES (2, '2', 'VIP1');
insert into `level` VALUES (3, '3', 'VIP2');
insert into `level` VALUES (4, '4', 'VIP3');


-- ----------------------------
-- Table structure for `user_traffic_log`
-- ----------------------------
create TABLE `user_traffic_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `u` int(11) NOT NULL DEFAULT '0' COMMENT '上传流量',
  `d` int(11) NOT NULL DEFAULT '0' COMMENT '下载流量',
  `node_id` int(11) NOT NULL DEFAULT '0' COMMENT '节点ID',
  `rate` float NOT NULL COMMENT '流量比例',
  `traffic` varchar(32) NOT NULL COMMENT '产生流量',
  `log_time` int(11) NOT NULL COMMENT '记录时间',
  PRIMARY KEY (`id`),
  INDEX `idx_user_node_time` (`user_id`, `node_id`, `log_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户流量日志';


-- ----------------------------
-- Table structure for `ss_config`
-- ----------------------------
drop table IF EXISTS `ss_config`;
create TABLE `ss_config` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL DEFAULT '' COMMENT '配置名' COLLATE 'utf8mb4_unicode_ci',
  `type` TINYINT(4) NOT NULL DEFAULT '1' COMMENT '类型：1-加密方式、2-协议、3-混淆',
  `is_default` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '是否默认：0-不是、1-是',
  `sort` INT(11) NOT NULL DEFAULT '0' COMMENT '排序：值越大排越前',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通用配置';

-- ----------------------------
-- Records of `ss_config`
-- ----------------------------
insert into `ss_config` VALUES ('1', 'none', '1', '0', '0');
insert into `ss_config` VALUES ('2', 'rc4', '1', '0', '0');
insert into `ss_config` VALUES ('3', 'rc4-md5', '1', '0', '0');
insert into `ss_config` VALUES ('4', 'rc4-md5-6', '1', '0', '0');
insert into `ss_config` VALUES ('5', 'bf-cfb', '1', '0', '0');
insert into `ss_config` VALUES ('6', 'aes-128-cfb', '1', '0', '0');
insert into `ss_config` VALUES ('7', 'aes-192-cfb', '1', '0', '0');
insert into `ss_config` VALUES ('8', 'aes-256-cfb', '1', '1', '0');
insert into `ss_config` VALUES ('9', 'aes-128-ctr', '1', '0', '0');
insert into `ss_config` VALUES ('10', 'aes-192-ctr', '1', '0', '0');
insert into `ss_config` VALUES ('11', 'aes-256-ctr', '1', '0', '0');
insert into `ss_config` VALUES ('12', 'camellia-128-cfb', '1', '0', '0');
insert into `ss_config` VALUES ('13', 'camellia-192-cfb', '1', '0', '0');
insert into `ss_config` VALUES ('14', 'camellia-256-cfb', '1', '0', '0');
insert into `ss_config` VALUES ('15', 'salsa20', '1', '0', '0');
insert into `ss_config` VALUES ('16', 'xsalsa20', '1', '0', '0');
insert into `ss_config` VALUES ('17', 'chacha20', '1', '0', '0');
insert into `ss_config` VALUES ('18', 'xchacha20', '1', '0', '0');
insert into `ss_config` VALUES ('19', 'chacha20-ietf', '1', '0', '0');
insert into `ss_config` VALUES ('20', 'chacha20-ietf-poly1305', '1', '0', '0');
insert into `ss_config` VALUES ('21', 'chacha20-poly1305', '1', '0', '0');
insert into `ss_config` VALUES ('22', 'xchacha-ietf-poly1305', '1', '0', '0');
insert into `ss_config` VALUES ('23', 'aes-128-gcm', '1', '0', '0');
insert into `ss_config` VALUES ('24', 'aes-192-gcm', '1', '0', '0');
insert into `ss_config` VALUES ('25', 'aes-256-gcm', '1', '0', '0');
insert into `ss_config` VALUES ('26', 'sodium-aes-256-gcm', '1', '0', '0');
insert into `ss_config` VALUES ('27', 'origin', '2', '1', '0');
insert into `ss_config` VALUES ('28', 'auth_sha1_v4', '2', '0', '0');
insert into `ss_config` VALUES ('29', 'auth_aes128_md5', '2', '0', '0');
insert into `ss_config` VALUES ('30', 'auth_aes128_sha1', '2', '0', '0');
insert into `ss_config` VALUES ('31', 'auth_chain_a', '2', '0', '0');
insert into `ss_config` VALUES ('32', 'auth_chain_b', '2', '0', '0');
insert into `ss_config` VALUES ('33', 'plain', '3', '1', '0');
insert into `ss_config` VALUES ('34', 'http_simple', '3', '0', '0');
insert into `ss_config` VALUES ('35', 'http_post', '3', '0', '0');
insert into `ss_config` VALUES ('36', 'tls1.2_ticket_auth', '3', '0', '0');
insert into `ss_config` VALUES ('37', 'tls1.2_ticket_fastauth', '3', '0', '0');
insert into `ss_config` VALUES ('38', 'auth_chain_c', '2', '0', '0');
insert into `ss_config` VALUES ('39', 'auth_chain_d', '2', '0', '0');
insert into `ss_config` VALUES ('40', 'auth_chain_e', '2', '0', '0');
insert into `ss_config` VALUES ('41', 'auth_chain_f', '2', '0', '0');


-- ----------------------------
-- Table structure for `config`
-- ----------------------------
create TABLE `config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '配置名',
  `value` TEXT NULL COMMENT '配置值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统配置';


-- ----------------------------
-- Records of config
-- ----------------------------
insert into `config` VALUES ('1', 'is_rand_port', 0);
insert into `config` VALUES ('2', 'is_user_rand_port', 0);
insert into `config` VALUES ('3', 'invite_num', 3);
insert into `config` VALUES ('4', 'is_register', 1);
insert into `config` VALUES ('5', 'is_invite_register', 2);
insert into `config` VALUES ('6', 'website_name', 'SSRPanel');
insert into `config` VALUES ('7', 'is_reset_password', 1);
insert into `config` VALUES ('8', 'reset_password_times', 3);
insert into `config` VALUES ('9', 'website_url', 'https://www.ssrpanel.com');
insert into `config` VALUES ('10', 'referral_type', 0);
insert into `config` VALUES ('11', 'active_times', 3);
insert into `config` VALUES ('12', 'is_checkin', 1);
insert into `config` VALUES ('13', 'min_rand_traffic', 10);
insert into `config` VALUES ('14', 'max_rand_traffic', 500);
insert into `config` VALUES ('15', 'wechat_qrcode', '');
insert into `config` VALUES ('16', 'alipay_qrcode', '');
insert into `config` VALUES ('17', 'traffic_limit_time', 1440);
insert into `config` VALUES ('18', 'referral_traffic', 1024);
insert into `config` VALUES ('19', 'referral_percent', 0.2);
insert into `config` VALUES ('20', 'referral_money', 100);
insert into `config` VALUES ('21', 'referral_status', 1);
insert into `config` VALUES ('22', 'default_traffic', 1024);
insert into `config` VALUES ('23', 'traffic_warning', 0);
insert into `config` VALUES ('24', 'traffic_warning_percent', 80);
insert into `config` VALUES ('25', 'expire_warning', 0);
insert into `config` VALUES ('26', 'expire_days', 15);
insert into `config` VALUES ('27', 'reset_traffic', 1);
insert into `config` VALUES ('28', 'default_days', 7);
insert into `config` VALUES ('29', 'subscribe_max', 3);
insert into `config` VALUES ('30', 'min_port', 10000);
insert into `config` VALUES ('31', 'max_port', 20000);
insert into `config` VALUES ('32', 'is_captcha', 0);
insert into `config` VALUES ('33', 'is_traffic_ban', 1);
insert into `config` VALUES ('34', 'traffic_ban_value', 10);
insert into `config` VALUES ('35', 'traffic_ban_time', 60);
insert into `config` VALUES ('36', 'is_clear_log', 1);
insert into `config` VALUES ('37', 'is_node_offline', 0);
insert into `config` VALUES ('38', 'webmaster_email', '');
insert into `config` VALUES ('39', 'is_notification', 0);
insert into `config` VALUES ('40', 'server_chan_key', '');
insert into `config` VALUES ('41', 'is_subscribe_ban', 1);
insert into `config` VALUES ('42', 'subscribe_ban_times', 20);
insert into `config` VALUES ('43', 'codepay_url', '');
insert into `config` VALUES ('44', 'codepay_id', '');
insert into `config` VALUES ('45', 'codepay_key', '');
insert into `config` VALUES ('46', 'is_free_code', 0);
insert into `config` VALUES ('47', 'is_forbid_robot', 0);
insert into `config` VALUES ('48', 'subscribe_domain', '');
insert into `config` VALUES ('49', 'auto_release_port', 1);
insert into `config` VALUES ('50', 'website_callback_url', '');
insert into `config` VALUES ('51', 'youzan_client_id', '');
insert into `config` VALUES ('52', 'youzan_client_secret', '');
insert into `config` VALUES ('53', 'kdt_id', '');
insert into `config` VALUES ('54', 'initial_labels_for_user', '');
insert into `config` VALUES ('55', 'website_analytics', '');
insert into `config` VALUES ('56', 'website_customer_service', '');
insert into `config` VALUES ('57', 'register_ip_limit', 5);
insert into `config` VALUES ('58', 'is_email_filtering', '0');
insert into `config` VALUES ('59', 'is_push_bear', 0);
insert into `config` VALUES ('60', 'push_bear_send_key', '');
insert into `config` VALUES ('61', 'push_bear_qrcode', '');
insert into `config` VALUES ('62', 'is_ban_status', 0);
insert into `config` VALUES ('63', 'is_namesilo', 0);
insert into `config` VALUES ('64', 'namesilo_key', '');
insert into `config` VALUES ('65', 'website_logo', '');
insert into `config` VALUES ('66', 'website_home_logo', '');
insert into `config` VALUES ('67', 'nodes_detection', 0);
insert into `config` VALUES ('68', 'detection_check_times', 3);
insert into `config` VALUES ('69', 'is_forbid_china', 0);
insert into `config` VALUES ('70', 'is_forbid_oversea', 0);
insert into `config` VALUES ('71', 'AppStore_id', 0);
insert into `config` VALUES ('72', 'AppStore_password', 0);
insert into `config` VALUES ('73', 'is_activate_account', 0);
insert into `config` VALUES ('74', 'node_daily_report', 0);
insert into `config` VALUES ('75', 'mix_subscribe', 0);
insert into `config` VALUES ('76', 'rand_subscribe', 0);
insert into `config` VALUES ('77', 'is_custom_subscribe', 0);
insert into `config` VALUES ('78', 'is_AliPay', 0);
insert into `config` VALUES ('79', 'is_QQ', 0);
insert into `config` VALUES ('80', 'is_WeChat', 0);
insert into `config` VALUES ('81', 'alipay_key', '');
insert into `config` VALUES ('82', 'alipay_private_key', '');
insert into `config` VALUES ('83', 'alipay_public_key', '');
insert into `config` VALUES ('84', 'alipay_transport', 'http');
insert into `config` VALUES ('85', 'alipay_currency', 'USD');
insert into `config` VALUES ('86', 'is_f2fpay', 0);
insert into `config` VALUES ('87', 'f2fpay_app_id', '');
insert into `config` VALUES ('88', 'f2fpay_private_key', '');
insert into `config` VALUES ('89', 'f2fpay_public_key', '');
insert into `config` VALUES ('90', 'website_security_code', '');
insert into `config` VALUES ('91', 'subject_name', '');
insert into `config` VALUES ('92', 'geetest_id', '');
insert into `config` VALUES ('93', 'geetest_key', '');
insert into `config` VALUES ('94', 'google_captcha_sitekey', '');
insert into `config` VALUES ('95', 'google_captcha_secret', '');
insert into `config` VALUES ('96', 'user_invite_days', 7);
insert into `config` VALUES ('97', 'admin_invite_days', 7);
insert into `config` VALUES ('98', 'offline_check_times', '');
insert into `config` VALUES ('99', 'payjs_mch_id', '');
insert into `config` VALUES ('100', 'payjs_key', '');
insert into `config` VALUES ('101', 'maintenance_mode', '0');
insert into `config` VALUES ('102', 'maintenance_time', '');
insert into `config` VALUES ('103', 'maintenance_content', '');
insert into `config` VALUES ('104', 'bark_key', '');
insert into `config` VALUES ('105', 'hcaptcha_secret', '');
insert into `config` VALUES ('106', 'hcaptcha_sitekey', '');

-- ----------------------------
-- Table structure for `article`
-- ----------------------------
create TABLE `article` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '标题',
  `author` varchar(50) DEFAULT '' COMMENT '作者',
  `summary` varchar(255) DEFAULT '' COMMENT '简介',
  `logo` varchar(255) DEFAULT '' COMMENT 'LOGO',
  `content` text COMMENT '内容',
  `type` tinyint(4) DEFAULT '1' COMMENT '类型：1-文章、2-公告、3-购买说明、4-使用教程',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章';


-- ----------------------------
-- Records of `article`
-- ----------------------------
insert into article(title, author, content, type, sort)
values('购买说明', '管理员', '<h4>购买流程：</h4><ol class=" list-paddingleft-2"><li><p>第一步：先购买基础套餐。</p></li><li><p>第二步：按需求，选择是否购买流量包。</p></li></ol><h4>基础套餐：</h4><ol class=" list-paddingleft-2"><li><p>在套餐生效的时间内，您将获得「套餐对应的网络速度」、「套餐内相应的流量」及其它特权。</p></li><li><p>基础套餐每月将会重置一次流量，重置日为购买日。</p></li><li><p>如在套餐未到期的情况下购买新套餐，则会导致旧套餐的所有配置立即失效，新套餐的配置立即生效。</p></li></ol><h4>流量包：</h4><ol class=" list-paddingleft-2"><li><p>当您在基础套餐重置日之前将流量耗尽，您可以选择购买流量包解燃眉之急。</p></li><li><p>流量包只在固定时间内增加可用流量，不会更改账户的配置，并且即时生效可以多个叠加。</p></li></ol>', '3', '0'), ('使用教程_Mac', '管理员', '<li> <a href=\"clients/ShadowsocksX-NG-R8-1.4.6.dmg\" target=\"_blank\">点击此处</a>下载客户端并启动 </li>\r\n<li> 点击状态栏纸飞机 -> 服务器 -> 编辑订阅 </li>\r\n<li> 点击窗口左下角 “+”号 新增订阅，完整复制本页上方“订阅服务”处地址，将其粘贴至“订阅地址”栏，点击右下角“OK” </li>\r\n<li> 点击纸飞机 -> 服务器 -> 手动更新订阅 </li>\r\n<li> 点击纸飞机 -> 服务器，选定合适服务器 </li>\r\n<li> 点击纸飞机 -> 打开Shadowsocks </li>\r\n<li> 点击纸飞机 -> PAC自动模式 </li>\r\n<li> 点击纸飞机 -> 代理设置->从 GFW List 更新 PAC </li>\r\n<li> 打开系统偏好设置 -> 网络，在窗口左侧选定显示为“已连接”的网络，点击右下角“高级...” </li>\r\n<li> 切换至“代理”选项卡，勾选“自动代理配置”和“不包括简单主机名”，点击右下角“好”，再次点击右下角“应用” </li>', '4', '1'), ('使用教程_Windows', '管理员', '<li> <a href=\"clients/ShadowsocksR-win.zip\" target=\"_blank\">点击此处</a>下载客户端并启动 </li>\r\n<li> 运行 ShadowsocksR 文件夹内的 ShadowsocksR.exe </li>\r\n<li> 右击桌面右下角状态栏（或系统托盘）纸飞机 -> 服务器订阅 -> SSR服务器订阅设置 </li>\r\n<li> 点击窗口左下角 “Add” 新增订阅，完整复制本页上方 “订阅服务” 处地址，将其粘贴至“网址”栏，点击“确定” </li>\r\n<li> 右击纸飞机 -> 服务器订阅 -> 更新SSR服务器订阅（不通过代理） </li>\r\n<li> 右击纸飞机 -> 服务器，选定合适服务器 </li>\r\n<li> 右击纸飞机 -> 系统代理模式 -> PAC模式 </li>\r\n<li> 右击纸飞机 -> PAC -> 更新PAC为GFWList </li>\r\n<li> 右击纸飞机 -> 代理规则 -> 绕过局域网和大陆 </li>\r\n<li> 右击纸飞机，取消勾选“服务器负载均衡” </li>', '4', '2'), ('使用教程_Linux', '管理员', '<li> <a href=\"clients/Shadowsocks-qt5-3.0.1.zip\" target=\"_blank\">点击此处</a>下载客户端并启动 </li>\r\n<li> 单击状态栏小飞机，找到服务器 -> 编辑订阅，复制黏贴订阅地址 </li>\r\n<li> 更新订阅设置即可 </li>', '4', '3'), ('使用教程_iOS', '管理员', '<li> 请从站长处获取 App Store 账号密码 </li>\r\n<li> 打开 Shadowrocket，点击右上角 “+”号 添加节点，类型选择 Subscribe </li>\r\n<li> 完整复制本页上方 “订阅服务” 处地址，将其粘贴至 “URL”栏，点击右上角 “完成” </li>\r\n<li> 左划新增的服务器订阅，点击 “更新” </li>\r\n<li> 选定合适服务器节点，点击右上角连接开关，屏幕上方状态栏出现“VPN”图标 </li>\r\n<li> 当进行海外游戏时请将 Shadowrocket “首页” 页面中的 “全局路由” 切换至 “代理”，并确保“设置”页面中的“UDP”已开启转发 </li>', '4', '4'), ('使用教程_Android', '管理员', '<li> <a href=\"clients/ShadowsocksRR-3.5.1.1.apk\" target=\"_blank\">点击此处</a>下载客户端并启动 </li>\r\n<li> 单击左上角的shadowsocksR进入配置文件页，点击右下角的“+”号，点击“添加/升级SSR订阅”，完整复制本页上方“订阅服务”处地址，填入订阅信息并保存 </li>\r\n<li> 选中任意一个节点，返回软件首页 </li>\r\n<li> 在软件首页处找到“路由”选项，并将其改为“绕过局域网及中国大陆地址” </li>\r\n<li> 点击右上角的小飞机图标进行连接，提示是否添加（或创建）VPN连接，点同意（或允许） </li>', '4', '5'), ('使用教程_Games', '管理员', '<li> <a href=\"clients/SSTap-beta-setup-1.0.9.7.zip\" target=\"_blank\">点击此处</a>下载客户端并安装 </li>\r\n<li> 打开 SSTap，选择 <i class=\"fa fa-cog\"></i> -> SSR订阅 -> SSR订阅管理，添加订阅地址 </li>\r\n<li> 添加完成后，再次选择 <i class=\"fa fa-cog\"></i> - SSR订阅 - 手动更新SSR订阅，即可同步节点列表。</li>\r\n<li> 在代理模式中选择游戏或「不代理中国IP」，点击「连接」即可加速。</li>\r\n<li> 需要注意的是，一旦连接成功，客户端会自动缩小到任务栏，可在设置中关闭。</li>', '4', '6');


-- ----------------------------
-- Table structure for `invite`
-- ----------------------------
create TABLE `invite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '邀请人ID',
  `fuid` int(11) NOT NULL DEFAULT '0' COMMENT '受邀人ID',
  `code` char(32) NOT NULL COMMENT '邀请码',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '邀请码状态：0-未使用、1-已使用、2-已过期',
  `dateline` datetime DEFAULT NULL COMMENT '有效期至',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='邀请码表';


-- ----------------------------
-- Table structure for `label`
-- ----------------------------
create TABLE `label` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '名称',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='标签';


-- ----------------------------
-- Records of `label`
-- ----------------------------
insert into `label` VALUES ('1', '电信', '0');
insert into `label` VALUES ('2', '联通', '0');
insert into `label` VALUES ('3', '移动', '0');
insert into `label` VALUES ('4', '教育网', '0');
insert into `label` VALUES ('5', '其他网络', '0');
insert into `label` VALUES ('6', '免费体验', '0');


-- ----------------------------
-- Table structure for `verify`
-- ----------------------------
create TABLE `verify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` TINYINT NOT NULL DEFAULT '1' COMMENT '激活类型：1-自行激活、2-管理员激活',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `token` varchar(32) NOT NULL COMMENT '校验token',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态：0-未使用、1-已使用、2-已失效',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='账号激活邮件地址';


-- ----------------------------
-- Table structure for `verify_code`
-- ----------------------------
create TABLE `verify_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(128) NOT NULL COMMENT '用户邮箱',
  `code` char(6) NOT NULL COMMENT '验证码',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态：0-未使用、1-已使用、2-已失效',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='注册激活验证码';


-- ----------------------------
-- Table structure for `ss_group`
-- ----------------------------
create TABLE `ss_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '分组名称',
  `level` tinyint(4) NOT NULL DEFAULT '1' COMMENT '分组级别',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='节点分组';


-- ----------------------------
-- Table structure for `ss_group_node`
-- ----------------------------
create TABLE `ss_group_node` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL DEFAULT '0' COMMENT '分组ID',
  `node_id` int(11) NOT NULL DEFAULT '0' COMMENT '节点ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='分组节点关系表';


-- ----------------------------
-- Table structure for `goods`
-- ----------------------------
create TABLE `goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sku` varchar(15) NOT NULL DEFAULT '' COMMENT '商品服务SKU',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '商品名称',
  `logo` varchar(255) NOT NULL DEFAULT '' COMMENT '商品图片地址',
  `traffic` bigint(20) NOT NULL DEFAULT '0' COMMENT '商品内含多少流量，单位MiB',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '商品类型：1-流量包、2-套餐、3-余额充值',
  `price` int(11) NOT NULL DEFAULT '0' COMMENT '售价，单位分',
  `renew` int(11) NOT NULL DEFAULT '0' COMMENT '流量重置价格，单位分',
  `period` int(11) NOT NULL DEFAULT '0' COMMENT '流量自动重置周期',
  `info` varchar(255) DEFAULT '' COMMENT '商品',
  `desc` varchar(255) DEFAULT '' COMMENT '商品描述',
  `days` int(11) NOT NULL DEFAULT '30' COMMENT '有效期',
  `invite_num` int(11) NOT NULL DEFAULT '0' COMMENT '赠送邀请码数',
  `limit_num` int(11) NOT NULL DEFAULT '0' COMMENT '限购数量，默认为0不限购',
  `color` VARCHAR(50) NOT NULL DEFAULT 'green' COMMENT '商品颜色',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `is_hot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否热销：0-否、1-是',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：0-下架、1-上架',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品';


-- ----------------------------
-- Table structure for `coupon`
-- ----------------------------
create TABLE `coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '优惠券名称',
  `logo` varchar(255) NOT NULL DEFAULT '' COMMENT '优惠券LOGO',
  `sn` varchar(50) NOT NULL DEFAULT '' COMMENT '优惠券码',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '类型：1-现金券、2-折扣券、3-充值券',
  `usage` tinyint(4) NOT NULL DEFAULT '1' COMMENT '用途：1-仅限一次性使用、2-可重复使用',
  `amount` bigint(20) NOT NULL DEFAULT '0' COMMENT '金额，单位分',
  `discount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '折扣',
  `rule` bigint(20) NOT NULL DEFAULT '0' COMMENT '使用限制，单位分',
  `available_start` int(11) NOT NULL DEFAULT '0' COMMENT '有效期开始',
  `available_end` int(11) NOT NULL DEFAULT '0' COMMENT '有效期结束',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：0-未使用、1-已使用、2-已失效',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `unq_sn` (`sn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='优惠券';


-- ----------------------------
-- Table structure for `coupon_log`
-- ----------------------------
create TABLE `coupon_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coupon_id` int(11) NOT NULL DEFAULT '0' COMMENT '优惠券ID',
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品ID',
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '订单ID',
  `desc` varchar(50) NOT NULL DEFAULT '' COMMENT '备注',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='优惠券使用日志';


-- ----------------------------
-- Table structure for `order`
-- ----------------------------
create TABLE `order` (
  `oid` int(11) NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(20) NOT NULL DEFAULT '' COMMENT '订单编号',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作人',
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品ID',
  `coupon_id` int(11) NOT NULL DEFAULT '0' COMMENT '优惠券ID',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `origin_amount` int(11) NOT NULL DEFAULT '0' COMMENT '订单原始总价，单位分',
  `amount` int(11) NOT NULL DEFAULT '0' COMMENT '订单总价，单位分',
  `expire_at` datetime DEFAULT NULL COMMENT '过期时间',
  `is_expire` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否已过期：0-未过期、1-已过期',
  `pay_way` tinyint(4) NOT NULL DEFAULT '1' COMMENT '支付方式：1-余额支付、2-有赞云支付',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '订单状态：-1-已关闭、0-待支付、1-已支付待确认、2-已完成',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '最后一次更新时间',
  PRIMARY KEY (`oid`),
  INDEX `idx_order_search` (`user_id`, `goods_id`, `is_expire`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单';

-- ----------------------------
-- Table structure for `ticket`
-- ----------------------------
create TABLE `ticket` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态：0-待处理、1-已处理未关闭、2-已关闭',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='工单';


-- ----------------------------
-- Table structure for `ticket_reply`
-- ----------------------------
create TABLE `ticket_reply` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` int(11) NOT NULL DEFAULT '0' COMMENT '工单ID',
  `user_id` int(11) NOT NULL COMMENT '回复人ID',
  `content` text NOT NULL COMMENT '回复内容',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='工单回复';


-- ----------------------------
-- Table structure for `user_balance_log`
-- ----------------------------
create TABLE `user_balance_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '账号ID',
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '订单ID',
  `before` int(11) NOT NULL DEFAULT '0' COMMENT '发生前余额，单位分',
  `after` int(11) NOT NULL DEFAULT '0' COMMENT '发生后金额，单位分',
  `amount` int(11) NOT NULL DEFAULT '0' COMMENT '发生金额，单位分',
  `desc` varchar(255) DEFAULT '' COMMENT '操作描述',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户余额变动日志';


-- ----------------------------
-- Table structure for `user_traffic_modify_log`
-- ----------------------------
create TABLE `user_traffic_modify_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '发生的订单ID',
  `before` bigint(20) NOT NULL DEFAULT '0' COMMENT '操作前流量',
  `after` bigint(20) NOT NULL DEFAULT '0' COMMENT '操作后流量',
  `desc` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户流量变动日志';


-- ----------------------------
-- Table structure for `referral_apply`
-- ----------------------------
create TABLE `referral_apply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `before` int(11) NOT NULL DEFAULT '0' COMMENT '操作前可提现金额，单位分',
  `after` int(11) NOT NULL DEFAULT '0' COMMENT '操作后可提现金额，单位分',
  `amount` int(11) NOT NULL DEFAULT '0' COMMENT '本次提现金额，单位分',
  `link_logs` text NOT NULL DEFAULT '' COMMENT '关联返利日志ID，例如：1,3,4',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态：-1-驳回、0-待审核、1-审核通过待打款、2-已打款',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='提现申请';


-- ----------------------------
-- Table structure for `referral_log`
-- ----------------------------
create TABLE `referral_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `ref_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '推广人ID',
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联订单ID',
  `amount` int(11) NOT NULL DEFAULT '0' COMMENT '消费金额，单位分',
  `ref_amount` int(11) NOT NULL DEFAULT '0' COMMENT '返利金额',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态：0-未提现、1-审核中、2-已提现',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='消费返利日志';


-- ----------------------------
-- Table structure for `notification_log`
-- ----------------------------
create TABLE `notification_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` TINYINT(4) NOT NULL DEFAULT '1' COMMENT '类型：1-邮件、2-serverChan、3-Bark',
  `address` VARCHAR(255) NOT NULL COMMENT '收信地址',
  `title` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '标题',
  `content` TEXT NOT NULL COMMENT '内容',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态：-1发送失败、0-等待发送、1-发送成功',
  `error` text COMMENT '发送失败抛出的异常信息',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通知投递记录';


-- ----------------------------
-- Table structure for `sensitive_words`
-- ----------------------------
create TABLE `sensitive_words` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `type` TINYINT(4) NOT NULL DEFAULT '1' COMMENT '类型：1-黑名单、2-白名单',
  `words` VARCHAR(50) NOT NULL DEFAULT '' COMMENT '敏感词',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='敏感词';


-- ----------------------------
-- Records of `sensitive_words`
-- ----------------------------
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'chacuo.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'chacuo.net');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', '1766258.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', '3202.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', '4057.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', '4059.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'a7996.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'bccto.me');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'bnuis.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'chaichuang.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'cr219.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'cuirushi.org');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'dawin.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'jiaxin8736.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'lakqs.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'urltc.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', '027168.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', '10minutemail.net');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', '11163.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', '1shivom.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'auoie.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'bareed.ws');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'bit-degree.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'cjpeg.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'cool.fr.nf');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'courriel.fr.nf');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'disbox.net');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'disbox.org');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'fidelium10.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'get365.pw');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'ggr.la');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'grr.la');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'guerrillamail.biz');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'guerrillamail.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'guerrillamail.de');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'guerrillamail.net');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'guerrillamail.org');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'guerrillamailblock.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'hubii-network.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'hurify1.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'itoup.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'jetable.fr.nf');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'jnpayy.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'juyouxi.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'mail.bccto.me');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'www.bccto.me');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'mega.zik.dj');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'moakt.co');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'moakt.ws');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'molms.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'moncourrier.fr.nf');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'monemail.fr.nf');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'monmail.fr.nf');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'nomail.xl.cx');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'nospam.ze.tc');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'pay-mon.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'poly-swarm.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'sgmh.online');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'sharklasers.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'shiftrpg.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'spam4.me');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'speed.1s.fr');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'tmail.ws');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'tmails.net');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'tmpmail.net');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'tmpmail.org');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'travala10.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'yopmail.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'yopmail.fr');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'yopmail.net');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'yuoia.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'zep-hyr.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'zippiex.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'lrc8.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', '1otc.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'emailna.co');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'mailinator.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'nbzmr.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'awsoo.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'zhcne.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', '0box.eu');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'contbay.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'damnthespam.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'kurzepost.de');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'objectmail.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'proxymail.eu');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'rcpt.at');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'trash-mail.at');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'trashmail.at');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'trashmail.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'trashmail.io');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'trashmail.me');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'trashmail.net');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'wegwerfmail.de');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'wegwerfmail.net');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'wegwerfmail.org');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'nwytg.net');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'despam.it');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'spambox.us');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'spam.la');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'mytrashmail.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'mt2014.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'mt2015.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'thankyou2010.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'trash2009.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'mt2009.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'trashymail.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'tempemail.net');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'slopsbox.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'mailnesia.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'ezehe.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'tempail.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'newairmail.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'temp-mail.org');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'linshiyouxiang.net');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'zwoho.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'mailboxy.fun');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'crypto-net.club');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'guerrillamail.info');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'pokemail.net');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'odmail.cn');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'hlooy.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'ozlaq.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', '666email.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'linshiyou.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'linshiyou.pl');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'woyao.pl');
insert into `sensitive_words` (`type`, `words`) VALUES ('1', 'yaowo.pl');
insert into `sensitive_words` (`type`, `words`) VALUES ('2', 'qq.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('2', '163.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('2', '126.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('2', '189.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('2', 'sohu.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('2', 'gmail.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('2', 'outlook.com');
insert into `sensitive_words` (`type`, `words`) VALUES ('2', 'icloud.com');


-- ----------------------------
-- Table structure for `user_subscribe`
-- ----------------------------
create TABLE `user_subscribe` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `code` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '订阅地址唯一识别码',
  `times` int(11) NOT NULL DEFAULT '0' COMMENT '地址请求次数',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：0-禁用、1-启用',
  `ban_time` int(11) NOT NULL DEFAULT '0' COMMENT '封禁时间',
  `ban_desc` varchar(50) NOT NULL DEFAULT '' COMMENT '封禁理由',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id`, `status`),
  INDEX `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户订阅';


-- ----------------------------
-- Records of `user_subscribe`
-- ----------------------------
insert into `user_subscribe` (`id`, `user_id`, `code`) VALUES ('1', '1', 'SsXa1');


-- ----------------------------
-- Table structure for `user_subscribe_log`
-- ----------------------------
create TABLE `user_subscribe_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sid` int(11) DEFAULT NULL COMMENT '对应user_subscribe的id',
  `request_ip` char(128) DEFAULT NULL COMMENT '请求IP',
  `request_time` datetime DEFAULT NULL COMMENT '请求时间',
  `request_header` text COMMENT '请求头部信息',
  PRIMARY KEY (`id`),
  INDEX `sid` (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户订阅访问日志';


-- ----------------------------
-- Table structure for `user_traffic_daily`
-- ----------------------------
create TABLE `user_traffic_daily` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `node_id` int(11) NOT NULL DEFAULT '0' COMMENT '节点ID，0表示统计全部节点',
  `u` bigint(20) NOT NULL DEFAULT '0' COMMENT '上传流量',
  `d` bigint(20) NOT NULL DEFAULT '0' COMMENT '下载流量',
  `total` bigint(20) NOT NULL DEFAULT '0' COMMENT '总流量',
  `traffic` varchar(255) DEFAULT '' COMMENT '总流量（带单位）',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  INDEX `idx_user_node` (`user_id`,`node_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户每日流量统计';


-- ----------------------------
-- Table structure for `user_traffic_hourly`
-- ----------------------------
create TABLE `user_traffic_hourly` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `node_id` int(11) NOT NULL DEFAULT '0' COMMENT '节点ID，0表示统计全部节点',
  `u` bigint(20) NOT NULL DEFAULT '0' COMMENT '上传流量',
  `d` bigint(20) NOT NULL DEFAULT '0' COMMENT '下载流量',
  `total` bigint(20) NOT NULL DEFAULT '0' COMMENT '总流量',
  `traffic` varchar(255) DEFAULT '' COMMENT '总流量（带单位）',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  INDEX `idx_user_node` (`user_id`,`node_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户每小时流量统计';


-- ----------------------------
-- Table structure for `node_traffic_daily`
-- ----------------------------
create TABLE `ss_node_traffic_daily` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL DEFAULT '0' COMMENT '节点ID',
  `u` bigint(20) NOT NULL DEFAULT '0' COMMENT '上传流量',
  `d` bigint(20) NOT NULL DEFAULT '0' COMMENT '下载流量',
  `total` bigint(20) NOT NULL DEFAULT '0' COMMENT '总流量',
  `traffic` varchar(255) DEFAULT '' COMMENT '总流量（带单位）',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  INDEX `idx_node_id` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='节点每日流量统计';


-- ----------------------------
-- Table structure for `node_traffic_hourly`
-- ----------------------------
create TABLE `ss_node_traffic_hourly` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL DEFAULT '0' COMMENT '节点ID',
  `u` bigint(20) NOT NULL DEFAULT '0' COMMENT '上传流量',
  `d` bigint(20) NOT NULL DEFAULT '0' COMMENT '下载流量',
  `total` bigint(20) NOT NULL DEFAULT '0' COMMENT '总流量',
  `traffic` varchar(255) DEFAULT '' COMMENT '总流量（带单位）',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  INDEX `idx_node_id` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='节点每小时流量统计';


-- ----------------------------
-- Table structure for `user_ban_log`
-- ----------------------------
create TABLE `user_ban_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `minutes` int(11) NOT NULL DEFAULT '0' COMMENT '封禁账号时长，单位分钟',
  `desc` varchar(255) NOT NULL DEFAULT '' COMMENT '操作描述',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态：0-未处理、1-已处理',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户封禁日志';


-- ----------------------------
-- Table structure for `user_label`
-- ----------------------------
create TABLE `user_label` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `label_id` int(11) NOT NULL DEFAULT '0' COMMENT '标签ID',
  PRIMARY KEY (`id`),
  INDEX `idx_user_label` (`user_id`,`label_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户标签';


-- ----------------------------
-- Table structure for `goods_label`
-- ----------------------------
create TABLE `goods_label` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `goods_id` INT(11) NOT NULL DEFAULT '0' COMMENT '商品ID',
  `label_id` INT(11) NOT NULL DEFAULT '0' COMMENT '标签ID',
  PRIMARY KEY (`id`),
  INDEX `idx_goods_label` (`goods_id`, `label_id`)
) ENGINE=InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品标签';


-- ----------------------------
-- Table structure for `country`
-- ----------------------------
create TABLE `country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '名称',
  `code` varchar(10) NOT NULL DEFAULT '' COMMENT '代码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='国家代码';


-- ----------------------------
-- Records of `country`
-- ----------------------------
insert into `country` VALUES ('1', '澳大利亚', 'au');
insert into `country` VALUES ('2', '巴西', 'br');
insert into `country` VALUES ('3', '加拿大', 'ca');
insert into `country` VALUES ('4', '瑞士', 'ch');
insert into `country` VALUES ('5', '中国', 'cn');
insert into `country` VALUES ('6', '德国', 'de');
insert into `country` VALUES ('7', '丹麦', 'dk');
insert into `country` VALUES ('8', '埃及', 'eg');
insert into `country` VALUES ('9', '法国', 'fr');
insert into `country` VALUES ('10', '希腊', 'gr');
insert into `country` VALUES ('11', '香港', 'hk');
insert into `country` VALUES ('12', '印度尼西亚', 'id');
insert into `country` VALUES ('13', '爱尔兰', 'ie');
insert into `country` VALUES ('14', '以色列', 'il');
insert into `country` VALUES ('15', '印度', 'in');
insert into `country` VALUES ('16', '伊拉克', 'iq');
insert into `country` VALUES ('17', '伊朗', 'ir');
insert into `country` VALUES ('18', '意大利', 'it');
insert into `country` VALUES ('19', '日本', 'jp');
insert into `country` VALUES ('20', '韩国', 'kr');
insert into `country` VALUES ('21', '墨西哥', 'mx');
insert into `country` VALUES ('22', '马来西亚', 'my');
insert into `country` VALUES ('23', '荷兰', 'nl');
insert into `country` VALUES ('24', '挪威', 'no');
insert into `country` VALUES ('25', '纽西兰', 'nz');
insert into `country` VALUES ('26', '菲律宾', 'ph');
insert into `country` VALUES ('27', '俄罗斯', 'ru');
insert into `country` VALUES ('28', '瑞典', 'se');
insert into `country` VALUES ('29', '新加坡', 'sg');
insert into `country` VALUES ('30', '泰国', 'th');
insert into `country` VALUES ('31', '土耳其', 'tr');
insert into `country` VALUES ('32', '台湾', 'tw');
insert into `country` VALUES ('33', '英国', 'uk');
insert into `country` VALUES ('34', '美国', 'us');
insert into `country` VALUES ('35', '越南', 'vn');
insert into `country` VALUES ('36', '波兰', 'pl');
insert into `country` VALUES ('37', '哈萨克斯坦', 'kz');
insert into `country` VALUES ('38', '乌克兰', 'ua');
insert into `country` VALUES ('39', '罗马尼亚', 'ro');
insert into `country` VALUES ('40', '阿联酋', 'ae');
insert into `country` VALUES ('41', '南非', 'za');
insert into `country` VALUES ('42', '缅甸', 'mm');
insert into `country` VALUES ('43', '冰岛', 'is');
insert into `country` VALUES ('44', '芬兰', 'fi');
insert into `country` VALUES ('45', '卢森堡', 'lu');
insert into `country` VALUES ('46', '比利时', 'be');
insert into `country` VALUES ('47', '保加利亚', 'bg');
insert into `country` VALUES ('48', '立陶宛', 'lt');
insert into `country` VALUES ('49', '哥伦比亚', 'co');
insert into `country` VALUES ('50', '澳门', 'mo');
insert into `country` VALUES ('51', '肯尼亚', 'ke');
insert into `country` VALUES ('52', '捷克', 'cz');
insert into `country` VALUES ('53', '摩尔多瓦', 'md');
insert into `country` VALUES ('54', '西班牙', 'es');
insert into `country` VALUES ('55', '巴基斯坦', 'pk');
insert into `country` VALUES ('56', '葡萄牙', 'pt');
insert into `country` VALUES ('57', '匈牙利', 'hu');
insert into `country` VALUES ('58', '阿根廷', 'ar');


-- ----------------------------
-- Table structure for `payment`
-- ----------------------------
create TABLE `payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `oid` int(11) DEFAULT NULL COMMENT '本地订单ID',
  `amount` int(11) NOT NULL DEFAULT '0' COMMENT '金额，单位分',
  `qr_code` text COLLATE utf8mb4_unicode_ci COMMENT '支付二维码',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '状态：-1-支付失败、0-等待支付、1-支付成功',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='支付单';


-- ----------------------------
-- Table structure for `payment_callback`
-- ----------------------------
create TABLE `payment_callback` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` varchar(50) DEFAULT NULL,
  `yz_id` varchar(50) DEFAULT NULL,
  `kdt_id` varchar(50) DEFAULT NULL,
  `kdt_name` varchar(50) DEFAULT NULL,
  `mode` tinyint(4) DEFAULT NULL,
  `msg` text,
  `sendCount` int(11) DEFAULT NULL,
  `sign` varchar(32) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `test` tinyint(4) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `version` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='有赞云回调日志';


-- ----------------------------
-- Table structure for `marketing`
-- ----------------------------
create TABLE `marketing` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` TINYINT(4) NOT NULL COMMENT '类型：1-邮件群发、2-订阅渠道群发',
  `receiver` TEXT NOT NULL COMMENT '接收者' COLLATE 'utf8mb4_unicode_ci',
  `title` VARCHAR(255) NOT NULL COMMENT '标题' COLLATE 'utf8mb4_unicode_ci',
  `content` TEXT NOT NULL COMMENT '内容' COLLATE 'utf8mb4_unicode_ci',
  `error` VARCHAR(255) NULL COMMENT '错误信息' COLLATE 'utf8mb4_unicode_ci',
  `status` TINYINT(4) NOT NULL COMMENT '状态：-1-失败、0-待发送、1-成功',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='营销';


-- ----------------------------
-- Table structure for `user_login_log`
-- ----------------------------
create TABLE `user_login_log` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL DEFAULT '0',
  `ip` CHAR(128) NOT NULL,
  `country` CHAR(20) NOT NULL,
  `province` CHAR(20) NOT NULL,
  `city` CHAR(20) NOT NULL,
  `county` CHAR(20) NOT NULL,
  `isp` CHAR(20) NOT NULL,
  `area` CHAR(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户登录日志';


-- ----------------------------
-- Table structure for `ss_node_ip`
-- ----------------------------
create TABLE `ss_node_ip` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL DEFAULT '0' COMMENT '节点ID',
  `user_id` INT(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `port` int(11) NOT NULL DEFAULT '0' COMMENT '端口',
  `type` char(10) NOT NULL DEFAULT 'tcp' COMMENT '类型：all、tcp、udp',
  `ip` text COMMENT '连接IP：每个IP用,号隔开',
  `created_at` int(11) NOT NULL DEFAULT '0' COMMENT '上报时间',
  PRIMARY KEY (`id`),
  KEY `idx_port` (`port`),
  KEY `idx_node` (`node_id`),
  KEY `idx_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户连接IP';


-- ----------------------------
-- Table structure for `rule`
-- ----------------------------
create TABLE `rule` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `type` char(20) NOT NULL DEFAULT '0' COMMENT '类型：reg-正则表达式、domain-域名、ip-IP、protocol-协议',
  `name` VARCHAR(100) NOT NULL COMMENT '规则描述',
  `pattern` TEXT NOT NULL COMMENT '规则值',
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='审计规则';


-- ----------------------------
-- Records of `rule`
-- ----------------------------
insert into `rule` (`id`, `type`, `name`, `pattern`, `created_at`, `updated_at`) VALUES
  (1, 'reg', '360', '(.*\.||)(^360|0360|1360|3600|360safe|^so|qhimg|qhmsg|^yunpan|qihoo|qhcdn|qhupdate|360totalsecurity|360shouji|qihucdn|360kan|secmp)\.(cn|com|net)', '2019-07-19 15:04:11', '2019-07-19 15:04:11'),
  (2, 'reg', '腾讯管家', '(\.guanjia\.qq\.com|qqpcmgr|QQPCMGR)', '2019-07-19 15:04:11', '2019-07-19 15:04:11'),
  (3, 'reg', '金山毒霸', '(.*\.||)(rising|kingsoft|duba|xindubawukong|jinshanduba)\.(com|net|org)', '2019-07-19 15:04:11', '2019-07-19 15:04:11'),
  (4, 'reg', '暗网相关', '(.*\.||)(netvigator|torproject)\.(cn|com|net|org)', '2019-07-19 15:04:11', '2019-07-19 15:04:11'),
  (5, 'reg', '百度定位', '(api|ps|sv|offnavi|newvector|ulog\\.imap|newloc|tracknavi)(\\.map|)\\.(baidu|n\\.shifen)\\.com', '2019-07-19 15:05:06', '2019-07-19 15:05:06'),
  (6, 'reg', '法轮功类', '(.*\\.||)(dafahao|minghui|dongtaiwang|dajiyuan|falundata|shenyun|tuidang|epochweekly|epochtimes|ntdtv|falundafa|wujieliulan|zhengjian)\\.(org|com|net)', '2019-07-19 15:05:46', '2019-07-19 15:05:46'),
  (7, 'reg', 'BT扩展名', '(torrent|\\.torrent|peer_id=|info_hash|get_peers|find_node|BitTorrent|announce_peer|announce\\.php\\?passkey=)', '2019-07-19 15:06:07', '2019-07-19 15:06:07'),
  (8, 'reg', '邮件滥发', '((^.*\@)(guerrillamail|guerrillamailblock|sharklasers|grr|pokemail|spam4|bccto|chacuo|027168)\.(info|biz|com|de|net|org|me|la)|Subject|HELO|SMTP)', '2019-07-19 15:06:20', '2019-07-19 15:06:20'),
  (9, 'reg', '迅雷下载', '(.?)(xunlei|sandai|Thunder|XLLiveUD)(.)', '2019-07-19 15:06:31', '2019-07-19 15:06:31'),
  (10, 'reg', '大陆应用', '(.*\\.||)(qq|163|sohu|sogoucdn|sogou|uc|58|taobao)\\.(org|com|net|cn)', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
  (11, 'reg', '大陆银行', '(.*\\.||)(icbc|ccb|boc|bankcomm|abchina|cmbchina|psbc|cebbank|cmbc|pingan|spdb|citicbank|cib|hxb|bankofbeijing|hsbank|tccb|4001961200|bosc|hkbchina|njcb|nbcb|lj-bank|bjrcb|jsbchina|gzcb|cqcbank|czbank|hzbank|srcb|cbhb|cqrcb|grcbank|qdccb|bocd|hrbcb|jlbank|bankofdl|qlbchina|dongguanbank|cscb|hebbank|drcbank|zzbank|bsb|xmccb|hljrcc|jxnxs|gsrcu|fjnx|sxnxs|gx966888|gx966888|zj96596|hnnxs|ahrcu|shanxinj|hainanbank|scrcu|gdrcu|hbxh|ynrcc|lnrcc|nmgnxs|hebnx|jlnls|js96008|hnnx|sdnxs)\\.(org|com|net|cn)', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
  (12, 'reg', '台湾银行', '(.*\\.||)(firstbank|bot|cotabank|megabank|tcb-bank|landbank|hncb|bankchb|tbb|ktb|tcbbank|scsb|bop|sunnybank|kgibank|fubon|ctbcbank|cathaybk|eximbank|bok|ubot|feib|yuantabank|sinopac|esunbank|taishinbank|jihsunbank|entiebank|hwataibank|csc|skbank)\\.(org|com|net|tw)', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
  (13, 'reg', '大陆第三方支付', '(.*\\.||)(alipay|baifubao|yeepay|99bill|95516|51credit|cmpay|tenpay|lakala|jdpay)\\.(org|com|net|cn)', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
  (14, 'reg', '台湾特供', '(.*\.||)(visa|mycard|mastercard|gov|gash|beanfun|bank|line)\.(org|com|net|cn|tw|jp|kr)', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
  (15, 'reg', '涉政治类', '(.*\\.||)(shenzhoufilm|secretchina|renminbao|aboluowang|mhradio|guangming|zhengwunet|soundofhope|yuanming|zhuichaguoji|fgmtv|xinsheng|shenyunperformingarts|epochweekly|tuidang|shenyun|falundata|bannedbook)\\.(org|com|net)', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for `rule_group`
-- ----------------------------
create TABLE `rule_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) DEFAULT '1' COMMENT '模式：1-阻断、2-仅放行',
  `name` varchar(255) DEFAULT NULL COMMENT '分组名称',
  `rules` text COMMENT '关联的规则ID，多个用,号分隔',
  `nodes` text COMMENT '关联的节点ID，多个用,号分隔',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='审计规则分组';


-- ----------------------------
-- Records of `rule_group`
-- ----------------------------
insert into `rule_group` (`id`, `type`, `name`, `rules`, `nodes`, `created_at`, `updated_at`) VALUES
(1, 1, '默认', '1,2,3,4,5,6,7,8,9,10,11,12,13,14', NULL, '2019-10-26 15:29:48', '2019-10-26 15:29:48');


-- ----------------------------
-- Table structure for `rule_group_node`
-- ----------------------------
create TABLE `device` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `type` TINYINT(4) NOT NULL DEFAULT '1' COMMENT '类型：0-兼容、1-Shadowsocks(R)、2-V2Ray',
  `platform` TINYINT(4) NOT NULL DEFAULT '1' COMMENT '所属平台：0-其他、1-iOS、2-Android、3-Mac、4-Windows、5-Linux',
  `name` VARCHAR(50) NOT NULL COMMENT '设备名称',
  `status` TINYINT(4) NOT NULL DEFAULT '1' COMMENT '状态：0-禁止订阅、1-允许订阅',
  `header` VARCHAR(100) NOT NULL COMMENT '请求时头部的识别特征码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='设备型号表';


-- ----------------------------
-- Records of `device`
-- ----------------------------
insert into `device` (`id`, `type`, `platform`, `name`, `status`, `header`) VALUES
  (1, 1, 1, 'Quantumult', 1, 'Quantumult'),
  (2, 1, 1, 'Shadowrocket', 1, 'Shadowrocket'),
  (3, 1, 3, 'ShadowsocksX-NG-R', 1, 'ShadowsocksX-NG-R'),
  (4, 1, 1, 'Pepi', 1, 'Pepi'),
  (5, 1, 1, 'Potatso 2', 1, 'Potatso'),
  (6, 1, 1, 'Potatso Lite', 1, 'Potatso'),
  (7, 1, 4, 'ShadowsocksR', 1, 'ShadowsocksR'),
  (8, 2, 4, 'V2RayW', 1, 'V2RayW'),
  (9, 2, 4, 'V2RayN', 1, 'V2RayN'),
  (10, 2, 4, 'V2RayS', 1, 'V2RayS'),
  (11, 2, 4, 'Clash for Windows', 1, 'Clash'),
  (12, 2, 3, 'V2RayX', 1, 'V2RayX'),
  (13, 2, 3, 'V2RayU', 1, 'V2RayU'),
  (14, 2, 3, 'V2RayC', 1, 'V2RayC'),
  (15, 2, 3, 'ClashX', 1, 'ClashX'),
  (16, 2, 1, 'Kitsunebi', 1, 'Kitsunebi'),
  (17, 2, 1, 'Kitsunebi Lite', 1, 'Kitsunebi'),
  (18, 2, 1, 'i2Ray', 1, 'i2Ray'),
  (19, 2, 2, 'BifrostV', 1, 'BifrostV'),
  (20, 2, 2, 'V2RayNG', 1, 'V2RayNG'),
  (21, 2, 2, 'ShadowsocksR', 1, 'okhttp'),
  (22, 2, 2, 'SSRR', 1, 'okhttp');


-- ----------------------------
-- Records of `failed_jobs`
-- ----------------------------
create TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='失败任务';


-- ----------------------------
-- Records of `jobs`
-- ----------------------------
create TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='任务';


-- ----------------------------
-- Records of `migrations`
-- ----------------------------
create TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='迁移';


/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
