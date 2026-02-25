Create and select database
CREATE DATABASE IF NOT EXISTS COMPANYDB;
USE COMPANYDB;

DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS DEPARTMENT;

CREATE TABLE DEPARTMENT(
    DNAME VARCHAR(20),
    DNUMBER INT PRIMARY KEY,
    MGRSSN VARCHAR(15),
    MGRSTARTDATE DATE
);

CREATE TABLE EMPLOYEE (
    FNAME VARCHAR(20),
    MINIT CHAR(1),
    LNAME VARCHAR(15),
    SSN VARCHAR(15) PRIMARY KEY,
    BDATE DATE,
    ADDRESS VARCHAR(100),
    SEX CHAR(1),
    SALARY INT,
    SUPERSSN VARCHAR(15),
    DNO INT,
    FOREIGN KEY (DNO) REFERENCES DEPARTMENT(DNUMBER)
);

INSERT INTO DEPARTMENT (DNAME, DNUMBER, MGRSSN, MGRSTARTDATE)
VALUES
('Research', 1, '123-45-6789', '2022-01-15'),
('Human Resources', 2, '987-65-4321', '2021-06-10'),
('IT Support', 3, '456-78-9123', '2023-03-20'),
('Accounts', 5, '999-99-9999', '2024-01-01');

INSERT INTO EMPLOYEE
(FNAME, MINIT, LNAME, SSN, BDATE, ADDRESS, SEX, SALARY, SUPERSSN, DNO)
VALUES
('John', 'A', 'Smith', '111-11-1111', '1990-05-15', 'Kathmandu, Nepal', 'M', 60000, NULL, 1),
('Rita', 'B', 'Shrestha', '222-22-2222', '1995-08-20', 'Lalitpur, Nepal', 'F', 50000, '111-11-1111', 1),
('Suman', 'C', 'Thapa', '333-33-3333', '1988-03-10', 'Bhaktapur, Nepal', 'M', 55000, '111-11-1111', 2),
('Anita', 'D', 'Karki', '444-44-4444', '1992-11-25', 'Pokhara, Nepal', 'F', 48000, '333-33-3333', 2),
('Ram', 'E', 'Gurung', '555-55-5555', '1997-07-05', 'Chitwan, Nepal', 'M', 45000, '333-33-3333', 5);

SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;

#1. 10% Salary rise for research department
SELECT E.FNAME, E.LNAME,
       E.SALARY * 1.1 AS increased_salary
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DNO = D.DNUMBER
WHERE D.DNAME = 'Research';

#2. Salary statistics of human resources department sum, max, min, avg for department administration
SELECT
    SUM(E.SALARY) AS total_salary,
    MAX(E.SALARY) AS max_salary,
    MIN(E.SALARY) AS min_salary,
    AVG(E.SALARY) AS average_salary
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DNO = D.DNUMBER
WHERE D.DNAME = 'Human Resources';

#3. Employee controlled by department no 3
SELECT FNAME, LNAME
FROM EMPLOYEE
where exists (
select * from employee e
WHERE e.DNO = 3
and E.SSN = e.SSN
);

#4. departments having at least two employees
select D.DNAME, count(*) as Emp_count
from Employee E
join DEPARTMENT D ON E.DNO = D.DNAME 
HAVING COUNT(*) >=2;

#5. Employees born in 1990's (1990- 1999)
select * from EMPLOYEE
where year (BDATE) between 1955 and 1999;
