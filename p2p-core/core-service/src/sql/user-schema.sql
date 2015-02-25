drop table if exists sys_user;
drop table if exists sys_app;
drop table if exists sys_user_app_roles;
drop table if exists sys_org;
drop table if exists sys_resource;
drop table if exists sys_role;
drop table if exists sys_area;
drop table if exists sys_bank_info;

create table sys_user (
  id bigint auto_increment  comment 'id',
  org_id bigint  comment '隶属组织id',
  uname varchar(50)  comment '用户名',
  email varchar(50)  comment 'email',
  mobile varchar(15)  comment '手机号',
  pwd varchar(60)  comment '密码',
  salt varchar(100)  comment '盐',
  locked bool default false  comment '是否锁定',
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP  comment '创建时间',
  constraint pk_sys_user primary key(id)
) charset=utf8 ENGINE=InnoDB  comment='管理人员表';
create unique index idx_su_username on sys_user(username);
create index idx_su_org_id on sys_user(org_id);


create table sys_app (
  id bigint auto_increment comment 'id',
  app_name varchar(100) comment '应用名称',
  app_key varchar(100) comment '应用key',
  app_secret varchar(100) comment '应用secret',
  available bool default true comment '可用否',
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP  comment '创建时间',
  constraint pk_sys_app primary key(id)
) charset=utf8 ENGINE=InnoDB  comment='平台应用管理表';
create unique index idx_sys_app_app_key on sys_app(app_key);

create table sys_user_app_roles (
  id bigint auto_increment comment 'id',
  user_id bigint comment '用户id',
  app_id bigint comment '应用id',
  role_ids varchar(100) comment '角色id集',
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP  comment '创建时间',
  constraint pk_sys_user_app_roles primary key(id)
) charset=utf8 ENGINE=InnoDB comment='用户应用角色关系表';
create unique index idx_sys_UAR_ids on sys_user_app_roles(user_id, app_id);

create table sys_org (
  id bigint auto_increment comment '隶属组织id',
  org_name varchar(100) comment '组织名',
  parent_id bigint comment '上级id',
  parent_ids varchar(100) comment '上级id集',
  available bool default true comment '可用否',
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP  comment '创建时间',
  constraint pk_sys_organization primary key(id)
) charset=utf8 ENGINE=InnoDB  comment='管理组织信息表';
create index idx_sys_organization_parent_id on sys_organization(parent_id);
create index idx_sys_organization_parent_ids on sys_organization(parent_ids);

create table sys_resource (
  id bigint auto_increment comment 'id',
  res_name varchar(100) comment '资源名称',
  res_type bigint comment '资源类型,参见sys_dict中type=res_type,9001:link,9002:static image,9003:static html,9009:others',
  url varchar(200) comment '资源链接',
  parent_id bigint comment '上级id',
  parent_ids varchar(100) comment '上级id集合',
  permission varchar(100) comment '所需权限',
  available bool default true comment '可用否',
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP  comment '创建时间',
  constraint pk_sys_resource primary key(id)
) charset=utf8 ENGINE=InnoDB  comment='资源表';
create index idx_sys_resource_parent_id on sys_resource(parent_id);
create index idx_sys_resource_parent_ids on sys_resource(parent_ids);

create table sys_role (
  id bigint auto_increment comment 'id',
  role varchar(100) comment '角色名',
  description varchar(100) comment '角色描述',
  resource_ids varchar(100) comment '资源集',
  available bool default true comment '可用否',
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP  comment '创建时间',
  constraint pk_sys_role primary key(id)
) charset=utf8 ENGINE=InnoDB  comment='角色表';
create index idx_sys_role_resource_ids on sys_role(resource_ids);


CREATE TABLE sys_area (
  id BIGINT NOT NULL AUTO_INCREMENT COMMENT '编号',
  parent_id BIGINT NOT NULL COMMENT '父级编号',
  parent_ids VARCHAR(255)  NOT NULL COMMENT '所有父级编号',
  area_code VARCHAR(100)  DEFAULT NULL COMMENT '区域编码',
  area_name VARCHAR(100)  NOT NULL COMMENT '区域名称',
  area_type BIGINT  DEFAULT 0 COMMENT '区域类型,见sys_dict中type=area_type（8001：国家；8002：省份、直辖市；8003：地市；8004：区县）',
  remarks VARCHAR(255)  DEFAULT NULL COMMENT '备注信息',
  available bool default true COMMENT '可用否',
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (id),
  KEY sys_area_parent_id (parent_id) USING BTREE,
  KEY sys_area_parent_ids (parent_ids) USING BTREE,
  KEY sys_area_del_flag (del_flag) USING BTREE
) ENGINE=INNODB COMMENT='区域表';

create table sys_bank_info (
  id BIGINT AUTO_INCREMENT COMMENT 'id',
  bank_name VARCHAR(100) COMMENT '银行名称',
  bank_code BIGINT COMMENT '银行代码',
  branch_name VARCHAR(100) COMMENT '分支名称',
  available bool default true comment '可用否',
  province_name VARCHAR(30) COMMENT '省',
  city_name VARCHAR(30) COMMENT '市',
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  CONSTRAINT pk_sys_bank_info PRIMARY KEY(id)
) CHARSET=utf8 ENGINE=INNODB  COMMENT='银行字典表';
create index idx_sys_bank_info_code ON sys_bank_info(bank_code);

create table sys_dict (
  id bigint auto_increment comment 'id',
  label varchar(50) comment '标签名',
  value bigint comment '值',
  type varchar(20) comment '类型',
  description varchar(50) comment '描述',
  sort bigint comment '排序值',
  available bool default true comment '可用否',
  CONSTRAINT pk_sys_dict PRIMARY KEY(id)
) CHARSET=utf8 ENGINE=INNODB  COMMENT='系统字典表';
create index idx_sys_dict_value ON sys_dict(value);
