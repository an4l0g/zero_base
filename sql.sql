create database zero_roleplay;
use zero_roleplay;

create table users(
    id int unsigned auto_increment not null,
    whitelist tinyint not null,
    banned tinyint not null,
    last_login datetime not null,
    ip varchar(15) not null,
    primary key(id)
);

create table fine(
	id int unsigned auto_increment not null,
    user_id int not null,
    fine_reason varchar(50) not null,
    fine_value int not null,
    fine_time varchar(50) not null,
    fine_description text not null,
    primary key(id)
);

create table pix(
	user_id int unsigned not null,
    chave varchar(10) not null,
    primary key(user_id)
);

create table user_ids (
    identifier varchar(100) not null,
    user_id int unsigned not null,
    primary key(identifier)
);

create table user_groups (
    user_id int unsigned not null,
    groupId varchar(50) not null,
    gradeId varchar(50) not null,
    active tinyint not null,
    primary key(user_id, groupId)
);

create table user_identities (
    user_id int unsigned not null,
    registration varchar(8) not null,
    phone varchar(7) not null,
    firstname varchar(50) not null,
    lastname varchar(50) not null,
    age int unsigned not null,
    primary key(user_id)
);

create table user_moneys (
    user_id int unsigned not null,
    wallet int unsigned not null,
    bank int unsigned not null,
    paypal int unsigned not null,
    coins int unsigned not null,
    primary key(user_id)
);

create table srv_data (
    dkey varchar(100) not null,
    dvalue json not null,
    primary key(dkey)
);

create table user_data (
    user_id int unsigned not null,
    dkey varchar(100) not null,
    dvalue json not null,
    primary key(user_id, dkey)
);

create table creation(
  user_id int unsigned not null,
  controller tinyint not null,
  user_character json not null,
  user_tattoo json not null,
  user_clothes json not null,
  rh varchar(3) not null,
  primary key(user_id)
);

create table homes(
    id int unsigned auto_increment not null,
    user_id int unsigned not null,
    home varchar(50) not null,
    home_owner tinyint not null,
    garages tinyint not null,
    tax varchar(20) not null,
    configs json not null,
    vip tinyint not null,
    primary key(id)
);

create table homes_garages(
    home varchar(50) not null,
    blip json not null,
    spawn json not null,
    primary key(home)
);

create table dynamic(
    user_id int unsigned not null,
    action varchar(50) not null,
    primary key(user_id, action)
);

create table inventory(
    bag_type varchar(25) not null,
    slots json not null,
    weight int not null,
    primary key(bag_type)    
);

create table hwid(
    token varchar(100) not null,
    user_id int not null,
    primary key(token, user_id)
);

create table dealership(
    car varchar(50) not null,
    stock int not null,
    primary key(car)
);

create table hospital(
    doctor_id int unsigned not null,
    service_type char(1) not null,
    patient_id int unsigned not null,
    total_price double not null,
    service_date datetime not null,
    request text,
    description text,
    primary key (doctor_id,patient_id,service_type,service_date)
);

create table relationship(
    id int unsigned auto_increment not null,
    user_1 int unsigned not null,
    user_2 int unsigned not null,
    relation varchar(50) not null,
    start_relationship varchar(50) not null,
    primary key(id)
);

create table user_vehicles (
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
);

create table spray(
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
);

create table identity(
	user_id int unsigned not null,
    url text not null,
    primary key(user_id)
);

create table clothes(
	title varchar(50) not null,
    preset json not null,
    user_id int not null,
    primary key(title, user_id)
)

create table pets(
	pet_type varchar(50) not null,
    pet_name varchar(50) not null,
    hunger int not null,
    thirst int not null,
    variation int not null,
    is_dead boolean not null,
    user_id int unsigned not null,
    primary key(pet_type, user_id)
)

create table banned_records(
    id int unsigned auto_increment not null,
    user_id int not null,
    staff_id int not null,
    ban_type varchar(50) not null,
    ban_date timestamp default current_timestamp not null,
    ban_reason varchar(50) not null,
    primary key(id)
)