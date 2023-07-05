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
  rh varchar(3) not null,
  primary key(user_id)
);

create table zero_homes(
    user_id int unsigned not null,
    home varchar(50) not null,
    home_owner tinyint not null,
    garages tinyint not null,
    tax varchar(20) not null,
    configs json not null,
    primary key(user_id)
);

create table zero_dynamic(
    user_id int unsigned not null,
    action varchar(50) not null,
    primary key(user_id, action)
);

create table zero_inventory(
    bag_type varchar(25) not null,
    slots json not null,
    weight int not null,
    primary key(bag_type)    
);

create table zero_hwid(
    token varchar(100) not null,
    user_id int not null,
    primary key(token, user_id)
);

create table zero_user_vehicles (
    user_id int unsigned not null,
    vehicle varchar(50) not null, 
    plate varchar(8) not null, 
    chassis varchar(50) not null, 
    detained int unsigned not null, 
    service tinyint not null,
    ipva varchar(50) not null,
    rented varchar(50) not null,
    state json not null,
    custom json not null,
    primary key(user_id, vehicle, plate, chassis)
)

create table zero_spray(
	id int unsigned auto_increment not null,
    config json not null,
    created_at timestamp not null default current_timestamp(),
    primary key(id)
)

create table zero_spray(
    id int unsigned auto_increment not null,
    interior tinyint not null,
    x float(8, 4) not null,
    y float(8, 4) not null,
    z float(8, 4) not null,
    rx float(8, 4) not null,
    ry float(8, 4) not null,
    rz float(8, 4) not null,
    scale float(8, 4) not null,
    spray_text varchar(10) not null,
    font varchar(32) not null,
    color int not null,
    created_at timestamp not null default current_timestamp(),
    primary key(id)
)