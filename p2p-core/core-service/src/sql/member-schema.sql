drop table if exists member;
drop table if exists member_account;
drop table if exists member_realname_auth;
drop table if exists member_base_info;
drop table if exists member_card_info;
drop table if exists member_job_info;

CREATE TABLE member (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '会员ID标识',
  email VARCHAR(50) DEFAULT NULL COMMENT '邮箱',
  uname VARCHAR(50) DEFAULT NULL COMMENT '用户名',
  pwd VARCHAR(60) DEFAULT NULL COMMENT '密码',
  -- trade_pwd VARCHAR(60) DEFAULT NULL COMMENT '交易密码',
  mobile_phone VARCHAR(15) DEFAULT NULL COMMENT '手机号码',
  purpose INT(11) DEFAULT '0' COMMENT '意向；1：投资；2：贷款',
  source INT(4) DEFAULT NULL COMMENT '客户来源',
  province INT(11) DEFAULT '0' COMMENT '省份或者直辖市',
  city INT(11) DEFAULT '0' COMMENT '城市',
  is_agree INT(4) DEFAULT '0' COMMENT '是否同意（条款）',
  auth_id BIGINT(20) DEFAULT '0' COMMENT '实名认证ID',
  is_locked CHAR(1) DEFAULT '0' COMMENT '是否锁定,  1:是； 0：否',
  is_withhold CHAR(1) DEFAULT '0' COMMENT '是否代扣,  1:是； 0：否',
  created_time DATETIME DEFAULT now() COMMENT '创建时间',
  auth_status INT(4) DEFAULT '0' COMMENT '会员认证状态',
  PRIMARY KEY (id),
  UNIQUE KEY idx_mobile_phone (mobile_phone) USING BTREE,
  UNIQUE KEY idx_uname (uname) USING BTREE
) ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='会员注册表信息'

CREATE TABLE member_account (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '标识ID',
  m_id BIGINT(20) DEFAULT NULL COMMENT '会员ID标识',
  usable_amount DECIMAL(18,2) DEFAULT '0.00' COMMENT '可用金额',
  frozen_amount DECIMAL(18,2) DEFAULT '0.00' COMMENT '冻结金额',
  earned_amount DECIMAL(18,2) DEFAULT '0.00' COMMENT '赚的金额(利息)',
  ext_amount DECIMAL(18,2) DEFAULT '0.00' COMMENT '扩展金额.如：做活动',
  bonus_amount DECIMAL(18,2) DEFAULT '0.00' COMMENT '用户得到的奖金',
  PRIMARY KEY (id),
  UNIQUE KEY idx_uq_mid (m_id) USING BTREE,
  CONSTRAINT idx_MA_mid FOREIGN KEY (m_id) REFERENCES member (id)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='用户账户信息表'