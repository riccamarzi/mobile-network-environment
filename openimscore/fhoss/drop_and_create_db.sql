drop database if exists hss_db;
create database hss_db;
grant delete, insert, select, update on hss_db.* to hss@'%' identified by 'hss';

