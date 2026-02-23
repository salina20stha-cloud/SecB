-- create database newdb;
-- use newdb;

create table if not exists DEPT (
	DEPTNo int primary key,
    DNAME varchar(10),
    LOC varchar(4)
);

select * from DEPT;

Rename table DEPT to DEPARTMENT;

Alter table Department 
add PINCODE int not null default 0 ;

Alter table DEPARTMENT
change DNAME DEPT_NAME varchar(20);

Alter table DEPARTMENT
modify LOC char(20);

drop table DEPARTMENT;