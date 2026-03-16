# Transaction
#1. Create a database named BankDB
# and create a table account with the fields: account_id,
# account_holder, balance.

create database BankDB;
use BankDB;

Create Table accounts(
account_id int primary key,
account_holder varchar (100),
balance decimal(10,2)
);

INSERT INTO accounts (account_id, account_holder, balance)
VALUES
(1, 'Ria Shakya', 5000.00),
(2, 'Salina Shrastha', 8200.50),
(3, 'Alisha Shakya', 12000.75),
(4, 'Binita Manandhar', 4500.00),
(5, 'Kiran Adhikari', 9300.00),
(6, 'Anita Gurung', 6700.50);

# Write a transaction that transfers Rs. 5000 from Ria's account to alisha's account.
start transaction;
update accounts 
set balance = balance - 5000
where account_id = 1;

update accounts 
set balance = balance + 5000
where account_id = 3;
commit;
select * from accounts;
# write a transaction that transfers Rs. 10000 from Salina's account to Binita's account and demonstrate the use of ROLLBACK.
start transaction;
update accounts 
set balance = balance - 10000
where account_id = 2;

update accounts 
set balance = balance + 10000
where account_id = 4;
rollback;

# write a transaction that demonstrates the use of SAVEPOINT while uploading account balances.
start transaction;
update accounts
set balance = balance - 2000
where account_id = 1;
savepoint sp1;
update accounts set balance = balance + 2000
where account_id = 2 ;
rollback to sp1;
commit;

# TRIGGER
create table employees (
emp_id int primary key,
name varchar (100),
salary decimal (10,2)
);

#2. Create another table salary_log to recpord employee salary changes with Fields: log_id, emp_id, old_salary, new_salary, updated_at.
Create table salary_log(
log_id int auto_increment primary key, 
emp_id int, 
old_salary decimal(10,2), 
new_salary decimal(10,2), 
updated_at timestamp default current_timestamp
);

# Create a BEFORE INSERT on employees that prevents inserting employees whose salary is less tha 10000
Delimiter $$
create trigger check_salary
before insert on employees
for each row
begin
if new.salary < 10000 then
signal sqlstate '45000'
set message_text = "salary must be atleast 10000";
end if ;
end $$
Delimiter ;

#Create a AFTER UPDATE on employees that records salary change into the salary_log table.
Delimiter $$
create trigger log_salary_update
after update on employees
for each row
begin
insert into salary_log (emp_id, old_salary, new_salary)
values (old.emp_id, old.salary, new.salary);
end $$
Delimiter ;

# stored Procedure
DELIMITER $$
CREATE PROCEDURE getEmployees()
BEGIN
SELECT * FROM employees;
END $$
DELIMITER ;
CALL getEmployees();

#Create a stored procedure that inserts a new employee into the employees table using paramaters
Delimiter $$
create procedure addEmployee(
IN p_id int,
IN p_name varchar(100),
IN p_salary decimal (10,2)
)
begin
insert into employees values(p_id, p_name, p_salary);
end $$
Delimiter ;
call addEmployee (6, 'Hari', 20000);

#3. Create a store procedure that update the salary of an employee based on employee ID.
Delimiter $$
create procedure updateSalary(
in p_id int,
in new_salary decimal(10,2)
)
begin
update employees
set salary = new_salary
where emp_id = p_id;
end $$
Delimiter ;
call updatesalary (1,30000);

#4. Create a stored procedure that transfers money between two accounts using a transaction.
Delimiter $$
create procedure transferMoney(
in from_account int,
to_account int,
in amount decimal
)
begin
start transaction;
update accounts 
set balance = balance - 5000
where account_id = 1;

update accounts 
set balance = balance + 5000
where account_id = 3;
commit;
end $$
Delimiter ;
call transferMoney(1,3,5000);

