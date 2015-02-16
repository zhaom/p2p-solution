drop table if exists sys_user;
drop table if exists sys_app;
drop table if exists sys_user_app_roles;
drop table if exists sys_org;
drop table if exists sys_resource;
drop table if exists sys_role;
drop table if exists sys_area;
drop table if exists sys_bank_info;

/********--
create table sessions (
  id varchar(200),
  session varchar(2000),
  constraint pk_sessions primary key(id)
) charset=utf8 ENGINE=InnoDB;
--
****/
create table sys_user (
  id bigint auto_increment  comment "id",
  org_id bigint  comment "隶属组织id",
  user_name varchar(100)  comment "用户名",
  email varchar(100)  comment "email",
  mobile varchar(15)  comment "手机号",
  password varchar(100)  comment "密码",
  salt varchar(100)  comment "盐",
  -- invest_state int  comment "",
  -- loan_state int  comment "隶属组织id",
  -- credit_rate int  comment "隶属组织id",
  locked bool default false  comment "是否锁定",
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP  comment "创建时间",
  constraint pk_sys_user primary key(id)
) charset=utf8 ENGINE=InnoDB  comment='管理人员表';
create unique index idx_su_username on sys_user(username);
create index idx_su_org_id on sys_user(org_id);

/*******
create table sys_user_security (
  id bigint auto_incrementcomment "隶属组织id",
  user_id bigintcomment "隶属组织id",
  auth_type varchar(10) comment "隶属组织id",
  auth_name varchar(100) comment "隶属组织id",
  auth_desc varchar(200) comment "隶属组织id",
  auth_result varchar(20) comment "隶属组织id",
  prop_name varchar(100) comment "隶属组织id",
  prop_value varchar(200) comment "隶属组织id",
  created_time datetimecomment "隶属组织id",
  last_update_time datetimecomment "隶属组织id",
  constraint pk_sys_user_security primary key(id)
) charset=utf8 engine=InnoDB;
create index idx_sus_user_id on sys_user_security(user_id);

create table sys_user_identification (
  id bigint auto_incrementcomment "隶属组织id",
  user_id bigintcomment "隶属组织id",
  iden_type intcomment "隶属组织id",    //idcardcomment "隶属组织id",baseinfocomment "隶属组织id",contactinfocomment "隶属组织id",jobcomment "隶属组织id",incomecomment "隶属组织id",credit_reportcomment "隶属组织id",livecomment "隶属组织id",housecomment "隶属组织id",carcomment "隶属组织id",marriagecomment "隶属组织id",educomment "隶属组织id",techcomment "隶属组织id",mobilecomment "隶属组织id",weibocomment "隶属组织id",websitecomment "隶属组织id",wechatcomment "隶属组织id",mortgagecomment "隶属组织id",warrant
  iden_name varchar(100) comment "隶属组织id",
  prop_name varchar(200) comment "隶属组织id",
  prop_value varchar(200) comment "隶属组织id",
  resource_id bigintcomment "隶属组织id",
  created_time datetimecomment "隶属组织id",
  constraint pk_sui primary key(id)
) charset=utf8 engine=InnoDB;
create index idx_sui_user_id on sys_user_identification(user_id);
*******************/
create table sys_app (
  id bigint auto_increment comment "id",
  app_name varchar(100) comment "应用名称",
  app_key varchar(100) comment "应用key",
  app_secret varchar(100) comment "应用secret",
  available bool default false comment "可用否",
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP  comment "创建时间",
  constraint pk_sys_app primary key(id)
) charset=utf8 ENGINE=InnoDB  comment='平台应用管理表';
create unique index idx_sys_app_app_key on sys_app(app_key);

create table sys_user_app_roles (
  id bigint auto_increment comment "id",
  user_id bigint comment "用户id",
  app_id bigint comment "应用id",
  role_ids varchar(100) comment "角色id集",
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP  comment "创建时间",
  constraint pk_sys_user_app_roles primary key(id)
) charset=utf8 ENGINE=InnoDB comment='用户应用角色关系表';
create unique index idx_sys_UAR_ids on sys_user_app_roles(user_id, app_id);


create table sys_org (
  id bigint auto_increment comment "隶属组织id",
  org_name varchar(100) comment "组织名",
  parent_id bigint comment "上级id",
  parent_ids varchar(100) comment "上级id集",
  available bool default false comment "可用否",
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP  comment "创建时间",
  constraint pk_sys_organization primary key(id)
) charset=utf8 ENGINE=InnoDB  comment='管理组织信息表';
create index idx_sys_organization_parent_id on sys_organization(parent_id);
create index idx_sys_organization_parent_ids on sys_organization(parent_ids);


create table sys_resource (
  id bigint auto_increment comment "id",
  res_name varchar(100) comment "资源名称",
  res_type varchar(50) comment "资源类型",
  url varchar(200) comment "资源链接",
  parent_id bigint comment "上级id",
  parent_ids varchar(100) comment "上级id集合",
  permission varchar(100) comment "所需权限",
  available bool default false comment "可用否",
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP  comment "创建时间",
  constraint pk_sys_resource primary key(id)
) charset=utf8 ENGINE=InnoDB  comment='资源表';
create index idx_sys_resource_parent_id on sys_resource(parent_id);
create index idx_sys_resource_parent_ids on sys_resource(parent_ids);

create table sys_role (
  id bigint auto_increment comment "id",
  role varchar(100) comment "角色名",
  description varchar(100) comment "角色描述",
  resource_ids varchar(100) comment "资源集",
  available bool default false comment "可用否",
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP  comment "创建时间",
  constraint pk_sys_role primary key(id)
) charset=utf8 ENGINE=InnoDB  comment='角色表';
create index idx_sys_role_resource_ids on sys_role(resource_ids);

/***
create table sys_area (
  id bigint auto_increment comment "id",
  parent_id bigint comment "上级id",
  parent_ids varchar(100) comment "上级id集",
  area_code char(6) comment "编码",
  area_name varchar(100) comment "名称",
  available bool default false comment "可用否",
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP  comment "创建时间",
  constraint pk_sys_area primary key(id)
) charset=utf8 ENGINE=InnoDB  comment='地区字典表';
create index idx_sys_area_parent_id on sys_area(parent_id);
***/

CREATE TABLE sys_area (
  id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  parent_id BIGINT(20) NOT NULL COMMENT '父级编号',
  parent_ids VARCHAR(255) COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  area_code VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT '区域编码',
  area_name VARCHAR(100) COLLATE utf8_bin NOT NULL COMMENT '区域名称',
  type CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '区域类型（1：国家；2：省份、直辖市；3：地市；4：区县）',
  create_date DATETIME DEFAULT NULL COMMENT '创建时间',
  remarks VARCHAR(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  del_flag CHAR(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (id),
  KEY sys_area_parent_id (parent_id) USING BTREE,
  KEY sys_area_parent_ids (parent_ids) USING BTREE,
  KEY sys_area_del_flag (del_flag) USING BTREE
) ENGINE=INNODB AUTO_INCREMENT=494 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='区域表'

create table sys_bank_info (
  id BIGINT AUTO_INCREMENT COMMENT "id",
  bank_name VARCHAR(100) COMMENT "银行名称",
  bank_code BIGINT COMMENT "银行代码",
  branch_name VARCHAR(100) COMMENT "分支名称",
  STATUS INT COMMENT "状态",
  province_name VARCHAR(30) COMMENT "省",
  city_name VARCHAR(30) COMMENT "市",
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP  COMMENT "创建时间",
  CONSTRAINT pk_sys_bank_info PRIMARY KEY(id)
) CHARSET=utf8 ENGINE=INNODB  COMMENT='银行字典表';
create index idx_sys_bank_info_code ON sys_bank_info(bank_code);

/****
create table sys_biz (
  id bigint auto_incrementcomment "隶属组织id",
  code varchar(20) comment "隶属组织id",
  biz_name varchar(200) comment "隶属组织id",
  biz_addr varchar(200) comment "隶属组织id",
  biz_legal_person varchar(100) comment "隶属组织id",
  contact varchar(100) comment "隶属组织id",
  tel varchar(20) comment "隶属组织id",
  email varchar(50) comment "隶属组织id",
  user_id bigintcomment "隶属组织id",
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP  comment "创建时间",
  constraint pk_sys_biz primary key(id)
) charset=utf8 ENGINE=InnoDB;
create index idx_sys_biz_uid on sys_biz(user_id);

*************/