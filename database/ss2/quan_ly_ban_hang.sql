create database quan_ly_ban_hang;
use quan_ly_ban_hang;
create table customer (
cID varchar(50) primary key,
cName varchar(50) not null,
cAge smallint
);
create table `table` (
oID varchar(50) primary key,
cID varchar(50) not null,
oDate date not null,
oTotalPrice int not null,
foreign key(cID) references customer(cID) 
);
create table product (
pID varchar(50) primary key,
pName varchar(100) not null,
pPrice int not null
);
create table order_detail (
oID varchar(50) not null,
pID varchar(50) not null,
odQTY int not null,
primary key(oID, pID),
foreign key(oID) references `table`(oID),
foreign key(pID) references product(pID)
);