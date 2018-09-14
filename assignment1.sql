CREATE DATABASE jmb;
\c jmb; 

CREATE TABLE Sailor(
	sid INTEGER PRIMARY KEY,
	sname VARCHAR(20),
	rating INTEGER,
	age INTEGER
);

CREATE TABLE Boat(
	bid INTEGER PRIMARY KEY,
	bname VARCHAR(15),
	color VARCHAR(15)
);

CREATE TABLE Reserves(
	sid INTEGER REFERENCES Sailor(sid),
	bid INTEGER REFERENCES Boat(bid),
	day VARCHAR(10),
	PRIMARY KEY(sid, bid)
);

INSERT INTO Sailor
VALUES
    (22,'Dustin',7,45),
    (29,'Brutus',1,33),
    (31,'Lubber',8,55),
    (32,'Andy',8,25),
    (58,'Rusty',10,35),
    (64,'Horatio',7,35),
    (71,'Zorba',10,16),
    (74,'Horatio',9,35),
    (85,'Art',3,25),
    (95,'Bob',3,63);

INSERT INTO Boat VALUES
	(101, 'Interlake', 'blue'),
	(102, 'Sunset',  'red'),
	(103, 'Clipper', 'green'),
	(104, 'Marine',  'red');

INSERT INTO Reserves VALUES
    (22, 101, 'Monday'),
	(22,  102, 'Tuesday'),
	(22,  103, 'Wednesday'),
	(31,  102, 'Thursday'),
	(31,  103, 'Friday'),
	(31,  104, 'Saturday'),
	(64,  101, 'Sunday'),
	(64,  102, 'Monday'),
	(74,  102, 'Saturday');

-- Queries

-- P1

-- P3
-- A) 
SELECT rating FROM Sailor;

-- B)
SELECT bid, color FROM Boat;

-- C) 
SELECT sname FROM Sailor WHERE age < 30 AND age > 15;

-- D)
SELECT b.bname FROM Boat b INNER JOIN Reserves r ON r.bid = b.bid WHERE r.day = 'Saturday' or r.day = 'Sunday';

-- E)
SELECT s.sname FROM Sailor s WHERE s.sid IN
	(SELECT r.sid FROM Reserves r INNER JOIN Boat b ON r.bid = b.bid
	WHERE b.color = 'red' OR b.color = 'green');
	
-- F)
--(SELECT s.sname FROM Sailor s 
--	WHERE s.sid IN
--		(SELECT r.sid FROM Reserves r 
--		INNER JOIN Boat b ON r.bid = b.bid 
--		WHERE b.color = 'red' AND b.bid NOT IN
--			(SELECT bid FROM Boat WHERE b.color = 'green' OR b.color = 'blue')));
			
			
\c postgres;
--drop database jmb;
			
	
	
	






















