create database chuyen_doi_erd_sang_mo_hinh_quan_he;
use chuyen_doi_erd_sang_mo_hinh_quan_he;
create table phieu_xuat (
soPx int primary key auto_increment,
ngayXuat date not null
);
create table vat_tu (
maVtu int primary key auto_increment,
tenVtu varchar(100) not null
);
create table phieu_nhap (
soPn int primary key auto_increment,
ngayNhap date not null
);
create table nha_cc (
maNcc int primary key auto_increment,
tenNcc varchar(50) not null,
diaChi varchar(1000),
sdt varchar(10)
);
create table don_dh (
soDh int primary key auto_increment,
ngayDh date not null,
maNcc int,
foreign key (maNcc) references nha_cc(maNcc)
);
create table chi_tiet_phieu_xuat (
soPx int not null,
dgXuat int not null,
slXuat int not null,
primary key (soPx, dgXuat),
foreign key (soPx) references phieu_xuat(soPx),
foreign key (dgXuat) references vat_tu(maVtu)
);
create table chi_tiet_phieu_thu (
soPn int not null,
dgNhap int not null,
slNhap int not null,
primary key (soPn, dgNhap),
foreign key (soPn) references phieu_nhap(soPn),
foreign key (dgNhap) references vat_tu(maVtu)
);
create table chi_tiet_dat_hang (
soDh int not null,
dgDatHang int not null,
slDatHang int not null, 
primary key (soDh, dgDatHang),
foreign key (soDh) references don_dh(soDh),
foreign key (dgDatHang) references vat_tu(maVtu)
);
-- drop database chuyen_doi_erd_sang_mo_hinh_quan_he;