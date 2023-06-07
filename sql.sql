create database zero_roleplay;
use zero_roleplay;

create table zero_users(
    id int unsigned auto_increment not null,
    whitelist tinyint not null,
    banned tinyint not null,
    garages int not null,
    houses int not null,
    last_login datetime not null,
    ip varchar(15) not null,
    primary key(id)
);

create table zero_user_ids (
    identifier varchar(100) not null,
    user_id int unsigned not null,
    primary key(user_id)
);

create table zero_user_groups (
    user_id int unsigned not null,
    groupId varchar(50) not null,
    gradeId varchar(50) not null,
    active tinyint not null,
    primary key(user_id, groupId)
);

create table zero_user_identities (
    user_id int unsigned not null,
    registration varchar(8) not null,
    phone varchar(7) not null,
    firstname varchar(50) not null,
    lastname varchar(50) not null,
    age int unsigned not null,
    primary key(user_id)
);

create table zero_user_moneys (
    user_id int unsigned not null,
    wallet int unsigned not null,
    bank int unsigned not null,
    paypal int unsigned not null,
    coins int unsigned not null,
    primary key(user_id)
);

create table zero_srv_data (
    dkey varchar(100) not null,
    dvalue json not null,
    primary key(dkey)
);

create table zero_user_data (
    user_id int unsigned not null,
    dkey varchar(100) not null,
    dvalue json not null,
    primary key(user_id)
);

create table zero_creation(
  user_id int unsigned not null,
  controller tinyint not null,
  user_character json not null,
  primary key(user_id)
);

create table zero_inventory(
	slots json not null,
    user_id int not null,
    weight int not null,
    bag_type varchar(30) not null,
    primary key(user_id, bag_type)
)