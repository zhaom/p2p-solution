drop table if exists member;
drop table if exists member_account;
drop table if exists member_realname_auth;
drop table if exists member_base_info;
drop table if exists member_card_info;
drop table if exists member_job_info;

CREATE TABLE member (
  id BIGINT NOT NULL AUTO_INCREMENT COMMENT '会员标识ID',
  email VARCHAR(50) DEFAULT NULL COMMENT '邮箱',
  uname VARCHAR(50) DEFAULT NULL COMMENT '用户名',
  pwd VARCHAR(60) DEFAULT NULL COMMENT '密码',
  -- trade_pwd VARCHAR(60) DEFAULT NULL COMMENT '交易密码',
  mobile_phone VARCHAR(15) DEFAULT NULL COMMENT '手机号码',
  purpose BIGINT DEFAULT 1 COMMENT '意向；参见sys_dict中type=member_purpose,1001:投资，1002:贷款',
  source BIGINT DEFAULT NULL COMMENT '客户来源；参见sys_dict中type=member_source,1201：web，1202：app，1203：wechat，1204：其它',
  province BIGINT DEFAULT 0 COMMENT '省份或者直辖市',
  city BIGINT DEFAULT 0 COMMENT '城市',
  is_agree bool default true  comment '是否同意（条款）',
  auth_id BIGINT DEFAULT 0 COMMENT '实名认证ID',
  locked bool default false COMMENT '是否锁定',
  is_withhold bool default true COMMENT '是否代扣',
  auth_state BIGINT DEFAULT 0 COMMENT '会员认证状态，参见sys_dict中type=member_auth_state，1301:,1302:,',
  rank BIGINT DEFAULT 0 comment '会员级别，参见sys_dict中type=member_rank，1401:1402:1403 ',
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  constraint pk_member primary key(id),
  UNIQUE KEY idx_member_mobile_phone (mobile_phone) USING BTREE,
  UNIQUE KEY idx_member_uname (uname) USING BTREE
) ENGINE=INNODB CHARSET=utf8 COMMENT='会员注册表信息';

CREATE TABLE member_account (
  id BIGINT NOT NULL AUTO_INCREMENT COMMENT '标识ID',
  m_id BIGINT COMMENT '会员标识ID',
  uname varchar(50) comment '用户名',
  ma_type bigint comment '账户类型，参见sys_dict中type=ma_type，2001：可用金额，2002：冻结，2003：利息，2004：活动金，2005：奖金，2006：积分',
  amount DECIMAL(18,2) DEFAULT 0.00 COMMENT '可用金额',
  available bool default true comment '可用否',
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  constraint pk_member_account primary key(id),
  CONSTRAINT idx_ma_mid FOREIGN KEY (m_id) REFERENCES member (id)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='用户账户信息表';
create index idx_ma_m_id on member_account(m_id);
create index idx_ma_uname on member_account(uname);

create table member_account_log (
  id bigint auto_increment comment '标识ID',
  m_id bigint comment '会员标识ID',
  uname varchar(50) comment '用户名',
  ma_id bigint comment '会员账户id标识',
  log_type bigint comment '账户变动类型',
  log_amount DECIMAL(18,2) DEFAULT 0.00 comment '发生额',
  balance DECIMAL(18,2) DEFAULT 0.00 comment '余额',
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  created_uid bigint comment '创建者id',
  constraint pk_member_account_log primary key(id)
)ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='用户账户流水表';
create index idx_mal_m_id on member_account_log(m_id);
create index idx_mal_ma_id on member_account_log(ma_id);
create index idx_mal_uname on member_account_log(uname);

CREATE TABLE member_card_info (
  id BIGINT NOT NULL AUTO_INCREMENT COMMENT '标识ID',
  m_id BIGINT DEFAULT NULL COMMENT '会员ID标识',
  uname varchar(50) comment '用户名',
  account_name VARCHAR(20) DEFAULT NULL COMMENT '开户人',
  bank VARCHAR(50) DEFAULT NULL COMMENT '银行',
  bank_code BIGINT DEFAULT NULL COMMENT '银行代码，联行号',
  bank_province VARCHAR(30) DEFAULT NULL COMMENT '银行所在省份',
  bank_city VARCHAR(30) DEFAULT NULL COMMENT '银行所在城市',
  bank_address VARCHAR(100) DEFAULT NULL COMMENT '开户行的地址',
  bank_name VARCHAR(80) DEFAULT NULL COMMENT '开户行',
  bank_card VARCHAR(40) DEFAULT NULL,
  bind_status bool default true comment '是否绑定状态',
  is_withhold bool default false comment '是否是代扣卡',
  is_valid bool default true comment '是否有效',
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  constraint pk_member_card_info primary key(id)
) ENGINE=INNODB CHARSET=utf8 COMMENT='用户银行卡信息表';
create index idx_mci_m_id on member_card_info(m_id);
create index idx_mci_uname on member_card_info(uname);

create table member_security (
  id bigint auto_increment comment '标识ID',
  m_id bigint comment '会员标识ID',
  uname varchar(50) comment '用户名',
  auth_type bigint comment '认证类型，参考sys_dict中type=auth_type',
  auth_name varchar(100) comment '认证类型名称',
  auth_desc varchar(200) comment '认证类型描述',
  auth_result varchar(20) comment '认证结果',
  prop_name varchar(100) comment '认证属性',
  prop_value varchar(200) comment '认证属性值',
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  constraint pk_member_security primary key(id)
) charset=utf8 engine=InnoDB;
create index idx_ms_m_id on member_security(m_id);
create index idx_ms_uname on member_security(uname);

create table member_identification (
  id bigint auto_increment comment '标识ID',
  m_id bigint comment '会员标识ID',
  uname varchar(50) comment '用户名',
  iden_type bigint comment '识别类型，参考sys_dict中type=iden_type',    -- idcard,baseinfo,contactinfo,job,income,credit_report,live,house,car,marriage,edu,tech,mobile,weibo,website,wechat,mortgage,warrant
  iden_name varchar(100) comment '识别名称',
  prop_name varchar(200) comment '属性名称',
  prop_value varchar(200) comment '属性值',
  resource_id bigint comment '资源id',
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  constraint pk_member_iden primary key(id)
) charset=utf8 engine=InnoDB;
create index idx_mi_m_id on member_identification(m_id);
create index idx_mi_uname on member_identification(uname);

CREATE TABLE member_realname_auth (
  id BIGINT NOT NULL AUTO_INCREMENT COMMENT '标识ID',
  real_name VARCHAR(20) DEFAULT NULL COMMENT '姓名',
  id_card VARCHAR(20) DEFAULT NULL COMMENT '身份证号',
  remark varchar(200),DEFAULT null comment '备注',
  pic_path VARCHAR(100) DEFAULT NULL COMMENT '身份证图片路径',
  pic_suffix VARCHAR(10) DEFAULT NULL COMMENT '图片的后缀',
  pic_binary TEXT COMMENT '图片二进制内容',
  is_authed bool default false comment '是否认证成功',
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  constraint pk_member_realname_auth primary key(id)
) ENGINE=INNODB CHARSET=utf8 COMMENT='用户实名认证数据库信息表';
create index idx_mra_id_card on member_realname_auth(id_card);

/****
create table sys_biz (
  id bigint auto_incrementcomment '隶属组织id',
  code varchar(20) comment '隶属组织id',
  biz_name varchar(200) comment '隶属组织id',
  biz_addr varchar(200) comment '隶属组织id',
  biz_legal_person varchar(100) comment '隶属组织id',
  contact varchar(100) comment '隶属组织id',
  tel varchar(20) comment '隶属组织id',
  email varchar(50) comment '隶属组织id',
  user_id bigintcomment '隶属组织id',
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP  comment '创建时间',
  constraint pk_sys_biz primary key(id)
) charset=utf8 ENGINE=InnoDB;
create index idx_sys_biz_uid on sys_biz(user_id);

*************/