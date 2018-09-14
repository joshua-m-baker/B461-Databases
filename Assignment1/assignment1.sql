SELECT * FROM Reserves r INNER JOIN Sailor s ON s.sid = r.sid INNER JOIN Boat b on b.bid = r.bid;
-- P1) 
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

-- P2) I made a new, simipler schema to test out the key relations
CREATE TABLE db1 (
	id INTEGER PRIMARY KEY NOT NULL,
	val INTEGER
);

CREATE TABLE db2 (
	id2 INTEGER REFERENCES db1(id),
	val VARCHAR,
	PRIMARY KEY(id2, val)
);

INSERT INTO db1 VALUES 
	(1, 34),
	(2, 15),
	(3, 92),
	(5, 4);
INSERT INTO db1 VALUES
	(6, NULL);

INSERT INTO db2 VALUES
	(1, 'val1'),
	(1, 'val2');
	
INSERT INTO db2 VALUES
	(2, 'val1'),
	(2, 'val2');

INSERT INTO db2 VALUES
	(3, NULL);
	
INSERT INTO db2 VALUES 
	(9, 'key does not exist');
	
DROP TABLE db1;
DROP TABLE db2;
SELECT * FROM db1;
INSERT INTO db2 VALUES (1, 'cascade');
DROP TABLE db1 CASCADE;


-- P3) 
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
	((SELECT r.sid FROM Reserves r INNER JOIN Boat b ON r.bid = b.bid
	WHERE b.color = 'red')
	INTERSECT (SELECT r.sid FROM Reserves r INNER JOIN Boat b ON r.bid = b.bid
	WHERE b.color = 'green'));
	
-- F)
SELECT s.sname FROM Sailor s WHERE s.sid IN
	((SELECT r.sid FROM Reserves r INNER JOIN Boat b ON r.bid = b.bid
	WHERE b.color = 'red')
	EXCEPT (SELECT r.sid FROM Reserves r INNER JOIN Boat b ON r.bid = b.bid
	WHERE b.color = 'green' or b.color = 'blue'));
			
-- G)
SELECT DISTINCT s.sname FROM Sailor s, Reserves r1, Reserves r2 WHERE
	s.sid = r1.sid AND s.sid = r1.sid AND r1.bid <> r2.bid;
			
-- H)
SELECT s.sid FROM Sailor s EXCEPT (SELECT r.sid FROM Reserves r);
			
-- I)
SELECT r1.sid, r2.sid FROM Reserves r1, Reserves r2 WHERE 
		r1.sid <> r2.sid AND r1.day = 'Saturday' AND r2.day = 'Saturday';	
			
-- J)
SELECT DISTINCT r.bid FROM Reserves r EXCEPT 
	(SELECT DISTINCT r1.bid FROM Reserves r1, Reserves r2 WHERE
	r1.bid = r2.bid AND r1.sid <> r2.sid);			
\c postgres;
drop database jmb;
