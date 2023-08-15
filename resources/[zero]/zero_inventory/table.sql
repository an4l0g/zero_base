use zero_roleplay;

create table inventory(
	slots json not null,
    user_id int not null,
    weight int not null,
    bag_type varchar(30) not null,
    primary key(user_id, bag_type)
)