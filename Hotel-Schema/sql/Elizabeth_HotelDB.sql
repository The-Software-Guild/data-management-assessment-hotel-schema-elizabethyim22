drop database if exists ElizabethHotelDB;
create database ElizabethHotelDB;
use ElizabethHotelDB;

create table guests(
guestId int auto_increment,
fName varchar(25),
lName varchar(25) not null,
address varchar(50),
city varchar(25),
state varchar(10),
zip int,
phone varchar(25),
constraint pk_guests
	primary key (guestId)
);

create table roomtype(
roomtypeId int auto_increment not null,
type varchar(10) not null,
standardOcc int,
maxOcc int,
extraPerson varchar(10),
constraint pk_roomtype 
	primary key (roomtypeId)
);

create table room (
roomNum int auto_increment not null,
roomtypeId int not null,
ADAAccess varchar(10),
amenities varchar(50),
basePrice decimal(7,2),
constraint pk_room
	primary key (roomNum),
constraint fk_room_roomtype
	foreign key(roomtypeId) 
    references roomtype(roomtypeId)
);

create table reservations(
reservationId int auto_increment not null,
guestId int not null,
adults int,
children int,
checkIn date not null,
checkOut date not null,
total decimal(7,2),
constraint pk_reservations 
	primary key (reservationId),
constraint fk_reservations_guest
	foreign key (guestId)
    references guests(guestId)
);

create table roomRes(
roomNum int not null,
reservationId int not null,
constraint pk_roomRes 
	primary key (roomNum, reservationId),
constraint fk_roomRes_room
	foreign key(roomNum)
    references room(roomNum),
constraint fk_roomRes_reservations
	foreign key(reservationId)
    references reservations(reservationId)
);