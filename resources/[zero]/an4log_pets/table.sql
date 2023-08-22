use db;

create table an4log_pets(
	pet_type varchar(50) not null,
    pet_name varchar(50) not null,
    hunger int not null,
    thirst int not null,
    variation int not null,
    is_dead boolean not null,
    user_id int unsigned not null,
    primary key(pet_type, user_id)
)