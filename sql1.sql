 -- create database studentdb; 
 -- use studentdb; 
 
Create Table if not exists Student (
	StudentID int, 
	Name varchar(255),
    DOB varchar(255)
);

Create table if not exists Student_Course (
	StudentID int,
	CourseName varchar(255),
	Subject varchar(255)
);

Insert into Student (StudentID, Name, DOB)
Values ('15', 'Salina', 2005-11-14);

Insert into Student_Course (StudentID, CourseName, Subject)
Values ('05', 'BScSE', 'Principle');