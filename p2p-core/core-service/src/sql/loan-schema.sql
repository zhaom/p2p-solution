drop table if exists loan;
drop table if exists loan_return;
drop table if exists loan_return_flow;
drop table if exists loan_return_pay;
drop table if exists loan_interest;
drop table if exists loan_interest_flow;
drop table if exists loan_warrant;
drop table if exists loan_audit_flow;

create table loan (
  id bigint auto_increment comment '借款标示id',
  loan_title varchar(200) comment '借款标题',
  m_id bigint comment '借款人会员id',
  uname varchar(50) comment '借款人会员名',
  loan_type bigint  comment '类别，参考sys_dict中type=loan_type',
  cate_name varchar(50) comment '类别名称',
  loan_amount decimal(18,2) comment '借款金额',
  real_amount decimal(18,2) comment '实际金额',
  found_ratio int comment '成标比率',
  biz_id bigint comment '单位标示id',
  biz_name varchar(200) comment '单位名称',
  apply_date datetime comment '申请用款日期',
  collect_begin_date datetime comment '开始募集日期',
  collect_term_date datetime comment '结束募集日期',
  real_found_date datetime comment '实际成标日期',
  state bigint comment '状态，参考sys_dict中type=loan_state',
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  created_by_uid bigint,
  constraint pk_loan primary key(id)
) charset=utf8 ENGINE=InnoDB comment '借款信息表';
create index idx_loan_m_id on loan(m_id);
create index idx_loan_biz_id on loan(biz_id);
create index idx_loan_cu_id on loan(created_by_uid);

create table loan_refund_stat (
  loan_id bigint comment '借款标示id',
  refund_type bigint comment '还款类型，参考sys_dict中type=loan_refund_type',
  total_phase int comment '总期数',
  cur_phase int comment '当前期',
  first_refund_date datetime comment '首次还款日期',
  next_refund_date datetime comment '下次还款日期',
  last_refund_date datetime comment '最近还款日期',
  term_refund_date datetime comment '末次还款日期',
  returned_principal decimal(18,2) comment '已还本金',
  returned_interest decimal(18,2) comment '已还利息',
  surplus_principal decimal(10,2) comment '剩余本金',
  surplus_interest decimal(10,2) comment '剩余利息',
  state bigint comment '状态，参考sys_dict中type=loan_return_state',
  created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  constraint pk_loan_return primary key(loan_id)
) charset=utf8 ENGINE=InnoDB comment '借款还款总表';

create table loan_refund_detail (
  id bigint auto_increment,
  loan_id bigint,
  expect_amount decimal(10,2),
  amount decimal(10,2),
  expect_principal decimal(10,2),
  principal decimal(10,2),
  expect_interest decimal(10,2),
  interest decimal(10,2),
  expect_date date,
  real_date date,
  state varchar(20),
  created_time timestamp ,
  last_update_time timestamp,
  remark varchar(200),
  constraint pk_loan_rf primary key(id)
) charset=utf8 ENGINE=InnoDB;
create index idx_loan_rf_loan_id on loan_return_flow(loan_id);

create table loan_return_pay (
  id bigint auto_increment,
  loan_id bigint,
  loan_rf_id bigint,
  user_id bigint,
  amount decimal(10,2),
  state varchar(20),
  return_method varchar(20),
  created_time timestamp ,
  constraint pk_loan_return_pay primary key(id)
) charset=utf8 ENGINE=InnoDB;
create index idx_lrp_loan_id on loan_return_pay(loan_id);
create index idx_lrp_loan_rf_id on loan_return_pay(loan_rf_id);
create index idx_lrp_user_id on loan_return_pay(user_id);

create table loan_interest (
  loan_id bigint,
  interest_lifecycle_type varchar(20),
  begin_interest_date date,
  term_interest_date date,
  interest_rate decimal(10,2),
  state varchar(20),
  created_time timestamp,
  constraint pk_loan_interest primary key(loan_id)
) charset=utf8 ENGINE=InnoDB;

create table loan_interest_flow (
  id bigint auto_increment,
  loan_id bigint,
  expect_amount decimal(10,2),
  expect_date date,
  state varchar(20),
  created_time timestamp ,
  constraint pk_loan_if primary key(id)
) charset=utf8 ENGINE=InnoDB;
create index idx_loan_if_loan_id on loan_interest_flow(loan_id);

create table loan_warrant (
  id bigint auto_increment,
  loan_id bigint,
  warrant_type varchar(20),
  warrant_desc varchar(200),
  warrant_url varchar(200),
  state varchar(20),
  created_time timestamp ,
  created_by_user_id bigint,
  remark varchar(200),
  constraint pk_loan_warrant primary key(id)
) charset=utf8 ENGINE=InnoDB;
create index idx_lw_loan_id on loan_warrant(loan_id);
create index idx_lw_user_id on loan_warrant(created_by_user_id);

create table loan_audit_flow (
  id bigint auto_increment,
  loan_id bigint,
  current_user_id bigint,
  next_user_id bigint,
  next_role_id bigint,
  note varchar(400),
  audit_result varchar(20),
  created_time timestamp ,
  constraint pk_loan_af primary key(id)
) charset=utf8 ENGINE=InnoDB;
create index idx_laf_loan_id on loan_audit_flow(loan_id);
create index idx_laf_cuser_id on loan_audit_flow(current_user_id);
create index idx_laf_nrole_id on loan_audit_flow(next_role_id);