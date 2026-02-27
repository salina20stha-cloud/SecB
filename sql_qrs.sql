-- create database moviedb;
use moviedb;

create table if not exists MOVIE (
mID int,
Title varchar(255),
Year date,
Director varchar(255)
);

Insert into MOVIE (mID, Title, Year, Director) values
(1, 'Inception', '2010-07-16', 'Christopher Nolan'),
(2, 'Titanic', '1997-12-19', 'James Cameron'),
(3, 'Avatar', '2009-12-18', 'James Cameron'),
(4, 'The Dark Knight', '2008-07-18', 'Christopher Nolan'),
(5, 'Interstellar', '2014-11-07', 'Christopher Nolan'),
(6, 'Jurassic Park', '1993-06-11', 'Steven Spielberg'),
(7, 'The Matrix', '1999-03-31', 'Lana Wachowski'),
(8, 'Avengers: Endgame', '2019-04-26', 'Anthony Russo'),
(9, 'Frozen', '2013-11-27', 'Chris Buck'),
(10, 'Spider-Man: No Way Home', '2021-12-17', 'Jon Watts');

create table if not exists USER (
uID int,
Name varchar(255)
);

Insert into USER (uID, Name) values
(1, 'Aarav Sharma'),
(2, 'Sita Rai'),
(3, 'Rohan Thapa'),
(4, 'Nisha Karki'),
(5, 'Prakash Gurung'),
(6, 'Anita Shrestha'),
(7, 'Bibek Lama'),
(8, 'Pooja Adhikari'),
(9, 'Suman KC'),
(10, 'Rita Tamang');

create table if not exists RATING (
	uID int,
    mID int,
    rating int,
    ratingDate date,
    primary key (uID, mID),
    foreign key (uID) references USER(uID),
    foreign key (mID) references MOVIE(mID)
);

insert into RATING (uID, mID, rating) values
(1, 1, 5),
(2, 1, 4),
(3, 2, 5),
(4, 3, 3),
(5, 4, 5),
(6, 5, 4),
(7, 6, 3),
(8, 7, 5),
(9, 8, 4),
(10, 9, 5);

select * from MOVIE;
select * from USER;
select * from RATING;

/*#Q1 find the title and year of movies
# that were created after the year 2000.
select Title, Year from 
MOVIE where year > 2000;

#2 Find the title, mId and Rating
# of movies that were created before the year 2000, and Rating > 2
select M.title, M.mID, R.rating from
Movie M join Rating R on M.mID = R.mID
where M.year < 2000 and R.rating > 2;

#3 Sort all of the movies by descending rating
select M.title, M.mID, R.rating from
Movie M join Rating R on M.mID = R.mID
order by R.rating desc;*/

#4 Find all movies that have the exact same rating.
select mID, rating, count(*) as total
from rating group by mID, rating
having count(*) >1;

#5 Create a query that looks for a movie's ID, title, and director, but only if it has a rating above 4.
SELECT distinct M.mID, M.Title, M.Director, R.rating
FROM MOVIE M
JOIN RATING R ON M.mID = R.mID
WHERE R.rating > 4;