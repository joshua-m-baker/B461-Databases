CREATE DATABASE jmb;
\c jmb; 

CREATE TABLE A(
	a INT
);

CREATE TABLE B(
	b INT
);

\echo 'Problem1' 
INSERT INTO A VALUES (1),(2),(3),(4),(5);
SELECT a AS x, SQRT(a) AS x_squared, a*a AS two_to_the_power_x, 
POWER(2,a) AS x_factorial, a!, ln(a) AS logarithm_x FROM a ;


TRUNCATE TABLE A;
INSERT INTO A VALUES (1),(2),(3);
INSERT INTO B VALUES (1),(3),(4),(5);
\echo 'Problem2' 


SELECT DISTINCT 
		NOT EXISTS(SELECT * FROM A EXCEPT (SELECT * FROM B)),
		EXISTS (SELECT * FROM A WHERE a IN 
				(SELECT a FROM A EXCEPT 
				 	(SELECT * FROM B)
				)
				OR a IN (SELECT b FROM b EXCEPT 
						 (SELECT * FROM A)
						)
					),
		NOT EXISTS (SELECT a FROM A JOIN B ON A.a=B.b)
	FROM A, B;
										   
\echo 'Problem3'
CREATE TABLE PAIR(
	x INT, 
	y INT,
	PRIMARY KEY(x,y)
);
INSERT INTO PAIR VALUES 
	(1,3),
	(2,5),
	(3,1);
				 
SELECT * FROM Pair a, Pair b WHERE
	a.x + a.y = b.x + b.y 
	AND (a.x != b.x)
	AND (a.y != b.y);

\echo 'Problem4'
--A)
SELECT DISTINCT EXISTS(SELECT * FROM A INTERSECT (SELECT * FROM B));
SELECT DISTINCT EXISTS(SELECT * FROM A JOIN B on A.a = B.b);
												  
-- B) 
SELECT NOT EXISTS (SELECT * FROM A  EXCEPT (SELECT * FROM A INTERSECT (SELECT * FROM B)));
SELECT NOT EXISTS (SELECT * FROM A WHERE a NOT IN (SELECT * FROM B));

												  
-- C) Get the intersection of the 2, then remove b and if that exists, it's false
TRUNCATE TABLE A; TRUNCATE TABLE B;
INSERT INTO A VALUES (1), (2), (3), (5);
INSERT INTO B VALUES (1),(2),(3);
SELECT NOT EXISTS (SELECT * FROM B EXCEPT (SELECT * FROM B INTERSECT (SELECT * FROM A)));
SELECT NOT EXISTS (SELECT * FROM B WHERE b NOT IN (SELECT * FROM A));
												   
-- D)
SELECT DISTINCT (EXISTS(SELECT * FROM A EXCEPT (SELECT * FROM B)) OR EXISTS(SELECT * FROM B EXCEPT (SELECT * FROM A)));
SELECT DISTINCT EXISTS(SELECT * FROM A,B WHERE a NOT IN (SELECT * FROM B) OR b NOT IN (SELECT * FROM A));
																					   
-- E)
SELECT EXISTS(																				   
	SELECT 1 FROM (SELECT COUNT(*) AS ct FROM (SELECT * FROM A INTERSECT (SELECT * FROM B))f) g 
		WHERE g.ct <= 2
); 		
SELECT EXISTS(																				   
	SELECT 1 FROM (SELECT COUNT(*) AS ct FROM (SELECT * FROM A WHERE a IN (SELECT * FROM B))f) g 
		WHERE g.ct <= 2
);
				   
-- F) I used my code from problem b, and replaced A with a view containing A U B.
CREATE TABLE C(
	c INT
);
INSERT INTO C VALUES (1), (2), (3), (4);

CREATE VIEW AuB AS (SELECT a FROM A WHERE A.a IN (SELECT b FROM B));
SELECT NOT EXISTS (SELECT * FROM AuB EXCEPT (SELECT * FROM AuB INTERSECT (SELECT * FROM C)));
SELECT NOT EXISTS (SELECT * FROM Aub WHERE a NOT IN (SELECT * FROM C));

-- G)
SELECT EXISTS((SELECT * FROM A EXCEPT (SELECT * FROM B))UNION(SELECT * FROM B EXCEPT (SELECT * FROM C)));
SELECT EXISTS((SELECT * FROM A WHERE a NOT IN (SELECT * FROM B))UNION(SELECT * FROM B WHERE b NOT IN (SELECT * FROM C)));

													 
\echo 'Problem5'
--A)
SELECT (SELECT COUNT(1) FROM(SELECT * FROM A INTERSECT (SELECT * FROM B)) f) > 0;
												  
-- B) 
SELECT (SELECT COUNT(1) FROM(SELECT * FROM A  EXCEPT (SELECT * FROM A INTERSECT (SELECT * FROM B)))f) = 0;
												  
-- C) Get the intersection of the 2, then remove b and if that exists, it's false
TRUNCATE TABLE A; TRUNCATE TABLE B;
INSERT INTO A VALUES (1),(2),(3),(5);
INSERT INTO B VALUES (1),(2),(3);
													  
SELECT (SELECT COUNT(1) FROM (SELECT * FROM B EXCEPT (SELECT * FROM B INTERSECT (SELECT * FROM A))) f)=0;
												   
-- D)
SELECT (SELECT COUNT(1) FROM 
		(SELECT * FROM A,B WHERE a NOT IN (SELECT * FROM B) OR b NOT IN (SELECT * FROM A)) f) >0;
																					   
-- E)
SELECT (SELECT COUNT(1) FROM(																				   
	SELECT 1 FROM (SELECT COUNT(*) AS ct FROM (SELECT * FROM A INTERSECT (SELECT * FROM B))f) g 
		WHERE g.ct <= 2)f) > 0;
				   
-- F)
CREATE TABLE C(
	c INT
);
INSERT INTO C VALUES (1), (2), (3), (4);

CREATE VIEW AuB AS (SELECT a FROM A WHERE A.a IN (SELECT b FROM B));
SELECT (SELECT COUNT(1) FROM(SELECT * FROM AuB EXCEPT (SELECT * FROM AuB INTERSECT (SELECT * FROM C)))f)=0;

-- G)
SELECT COUNT(((SELECT * FROM A EXCEPT (SELECT * FROM B))UNION(SELECT * FROM B EXCEPT (SELECT * FROM C))))=1;
												 
													 
DROP VIEW AuB;
DROP TABLE A;
DROP TABLE B;
DROP TABLE C;


CREATE TABLE Student(
	sid INTEGER PRIMARY KEY,
	sname VARCHAR(15)
);

CREATE TABLE Book(
	book_no INTEGER PRIMARY KEY,
	title VARCHAR(30),
	price INTEGER
);

CREATE TABLE Major(
	sid INTEGER REFERENCES Student(sid),
	major VARCHAR(15),
	PRIMARY KEY (sid, major)
);

CREATE TABLE Buys(
	sid INTEGER REFERENCES Student(sid),
	book_no INTEGER REFERENCES Book(book_no)
);

INSERT INTO Student VALUES 
    (1001, 'Jean'),
    (1002, 'Maria'),
    (1003, 'Anna'),
    (1004, 'Chin'),
    (1005, 'John'),
    (1006, 'Ryan'),
    (1007, 'Catherine'),
    (1008, 'Emma'),
    (1009, 'Jan'),
    (1010, 'Linda'),
    (1011, 'Nick'),
    (1012, 'Eric'),
    (1013, 'Lisa'),
    (1014, 'Filip'),
    (1015, 'Dirk'),
    (1016, 'Mary'),
    (1017, 'Ellen'),
    (1020, 'Greg'),
    (1022, 'Qin'),
    (1023, 'Melanie'),
    (1040, 'Pam');

INSERT INTO Major VALUES
	(1001, 'Math'),
    (1001, 'Physics'),
    (1002, 'CS'),
    (1002, 'Math'),
    (1003, 'Math'),
    (1004, 'CS'),
    (1006, 'CS'),
    (1007, 'CS'),
    (1007, 'Physics'),
    (1008, 'Physics'),
    (1009, 'Biology'),
    (1010, 'Biology'),
    (1011, 'CS'),
    (1011, 'Math'),
    (1012, 'CS'),
    (1013, 'CS'),
    (1013, 'Psychology'),
    (1014, 'Theater'),
    (1017, 'Anthropology'),
    (1022, 'CS'),
    (1015, 'Chemistry');
	
INSERT INTO Book VALUES
	(2001, 'Databases', 40),
	(2002, 'OperatingSystems', 25),
	(2003, 'Networks', 20),
	(2004, 'AI', 45),
	(2005, 'DiscreteMathematics', 20),
	(2006, 'SQL', 25),
	(2007, 'ProgrammingLanguages', 15),
	(2008, 'DataScience', 50),
	(2009, 'Calculus', 10),
	(2010, 'Philosophy', 25),
	(2012, 'Geometry', 80),
	(2013, 'RealAnalysis', 35),
	(2011, 'Anthropology', 50),
	(2014, 'Topology', 70);

INSERT INTO Buys VALUES
	(1023, 2012),
	(1023, 2014),
	(1040, 2002),
	(1001, 2002),
	(1001, 2007),
	(1001, 2009),
	(1001, 2011),
	(1001, 2013),
	(1002, 2001),
	(1002, 2002),
	(1002, 2007),
	(1002, 2011),
	(1002, 2012),
	(1002, 2013),
	(1003, 2002),
	(1003, 2007),
	(1003, 2011),
	(1003, 2012),
	(1003, 2013),
	(1004, 2006),
	(1004, 2007),
	(1004, 2008),
	(1004, 2011),
	(1004, 2012),
	(1004, 2013),
	(1005, 2007),
	(1005, 2011),
	(1005, 2012),
	(1005, 2013),
	(1006, 2006),
	(1006, 2007),
	(1006, 2008),
	(1006, 2011),
	(1006, 2012),
	(1006, 2013),
	(1007, 2001),
	(1007, 2002),
	(1007, 2003),
	(1007, 2007),
	(1007, 2008),
	(1007, 2009),
	(1007, 2010),
	(1007, 2011),
	(1007, 2012),
	(1007, 2013),
	(1008, 2007),
	(1008, 2011),
	(1008, 2012),
	(1008, 2013),
	(1009, 2001),
	(1009, 2002),
	(1009, 2011),
	(1009, 2012),
	(1009, 2013),
	(1010, 2001),
	(1010, 2002),
	(1010, 2003),
	(1010, 2011),
	(1010, 2012),
	(1010, 2013),
	(1011, 2002),
	(1011, 2011),
	(1011, 2012),
	(1012, 2011),
	(1012, 2012),
	(1013, 2001),
	(1013, 2011),
	(1013, 2012),
	(1014, 2008),
	(1014, 2011),
	(1014, 2012),
	(1017, 2001),
	(1017, 2002),
	(1017, 2003),
	(1017, 2008),
	(1017, 2012),
	(1020, 2001),
	(1020, 2012),
	(1022, 2014);

\echo 'Problem6'
-- A)
	-- i)
CREATE FUNCTION booksBoughtbyStudent(x int)
	returns table(bookno int, title VARCHAR(30), price int) AS
	$$
	SELECT b.book_no, b.title, b.price FROM Book b WHERE b.book_no IN(
		SELECT b2.book_no FROM Buys b2 WHERE b2.sid = x
	);
	$$ LANGUAGE SQL;
	-- ii)
SELECT * FROM booksBoughtbyStudent(1001);
SELECT * FROM booksBoughtbyStudent(1015);

	-- iii)
		-- A)
SELECT s.sid, s.sname FROM Student s 
	WHERE (SELECT COUNT(1) FROM booksBoughtbyStudent(s.sid) b
		   WHERE b.price < 50) = 1; 
		   
		-- B) 
SELECT s.sid, s2.sid FROM Student s, Student s2
	WHERE s.sid != s2.sid AND
	NOT EXISTS(SELECT * FROM booksBoughtbyStudent(s.sid) EXCEPT (SELECT * FROM booksBoughtbyStudent(s2.sid))
		UNION (SELECT * FROM booksBoughtbyStudent(s2.sid) EXCEPT (SELECT * FROM booksBoughtbyStudent(s.sid))));
		
-- B)
	-- i)
CREATE FUNCTION studentsWhoBoughtBook(b_no int)
	returns table(sid int, sname VARCHAR(15)) AS
	$$
		SELECT * FROM Student s WHERE s.sid IN(
			SELECT bu.sid FROM Buys bu WHERE b_no = bu.book_no	
		);
	$$ LANGUAGE SQL;

	-- ii)
SELECT * FROM studentsWhoBoughtBook(2001);
SELECT * FROM studentsWhoBoughtBook(2010);
										 
	-- iii)
CREATE VIEW sUnderThirty AS 
SELECT m.sid FROM major m
	WHERE (SELECT COUNT(1) FROM booksBoughtbyStudent(m.sid) b
		   WHERE b.price > 30) >= 1
	AND m.major = 'CS'; 

SELECT DISTINCT b.book_no FROM Book b, sUnderThirty s1, sUnderThirty s2 WHERE
	s1.sid != s2.sid 
	AND s1.sid IN (SELECT sid FROM studentsWhoBoughtBook(b.book_no))
	AND s2.sid IN (SELECT sid FROM studentsWhoBoughtBook(b.book_no));
			 
-- C) 
-- i)
SELECT m.sid, m.major FROM Major m 
	WHERE (SELECT COUNT(1) FROM booksBoughtbyStudent(m.sid) b
		   WHERE b.price > 30) >= 4; 

-- ii)
SELECT s1.sid, s2.sid FROM Student s1, Student s2 WHERE
	s1.sid != s2.sid AND 
	(SELECT SUM(b.price) FROM booksBoughtbyStudent(s1.sid) b) =
	(SELECT SUM(b.price) FROM booksBoughtbyStudent(s2.sid) b);
														 
-- iii)
-- View to hold the total spent by each cs student
CREATE FUNCTION totalSpent(s_id INT)
	RETURNS BIGINT AS 
	$$
		SELECT Sum(b.price) FROM Buys bu JOIN Book b ON bu.book_no = b.book_no
		WHERE bu.sid = s_id
			GROUP BY bu.sid;									 
	$$ LANGUAGE SQL;
														 
CREATE VIEW csBooksTotal AS 
	SELECT totalSpent(bu.sid) FROM Buys bu
		WHERE bu.sid IN (SELECT m.sid FROM Major m WHERE m.major = 'CS')
		GROUP BY bu.sid;
														 
SELECT s.sid, s.sname FROM Student s 
	WHERE totalSpent(s.sid) > (SELECT AVG(cb.totalSpent) FROM csBooksTotal cb);
														 
-- iv) 
SELECT b.book_no, b.title FROM Book b ORDER BY b.price DESC OFFSET 2 LIMIT 2;

-- v)
CREATE VIEW nonCS AS 
	SELECT DISTINCT m.sid FROM Major m WHERE m.major != 'CS' 
	EXCEPT (SELECT DISTINCT m.sid FROM Major m WHERE m.major = 'CS');								 
														 
SELECT DISTINCT b.book_no, b.title FROM Book b, Buys bu
	WHERE b.book_no = bu.book_no 
	AND bu.sid IN (SELECT m.sid FROM Major m WHERE m.major = 'CS')
	AND bu.sid NOT IN (SELECT sid FROM nonCS);

														 
-- vi)
CREATE VIEW twoCS AS 
	SELECT b.book_no FROM Book b WHERE b.book_no IN
		(SELECT bu.book_no FROM Buys bu, Buys bu2 
		 	WHERE bu.book_no = bu2.book_no 
		 	AND bu.sid != bu2.sid);

SELECT s.sid, s.sname FROM Student s
	WHERE (SELECT COUNT(*) FROM 
		   booksBoughtbyStudent(1002) b EXCEPT (SELECT * FROM twoCS) 
		  ) > 0;
													
-- vii)
SELECT DISTINCT bu.sid, bu.book_no FROM Buys bu JOIN Book b ON bu.book_no = b.book_no
	WHERE b.price < (SELECT AVG(b2.price) FROM booksBoughtbyStudent(bu.sid) b2);
														 
-- viii) 
SELECT s1.sid, s2.sid FROM Student s1, Student s2 
	WHERE s1.sid != s2.sid
	AND s1.sid IN (SELECT m2.sid FROM Major m1, Major m2 WHERE m1.sid = s2.sid AND m1.major = m2.major)
	AND (SELECT COUNT(*) FROM booksBoughtbyStudent(s1.sid)) = 
		(SELECT COUNT(*) FROM booksBoughtbyStudent(s2.sid));
												   
-- ix)
CREATE FUNCTION myCount(s1 int, s2 int) 
	RETURNS BIGINT AS 
	$$
		SELECT COUNT(*) FROM Buys b WHERE b.sid = s1 AND b.book_no NOT IN
			(SELECT b2.sid FROM Buys b2 WHERE b2.sid = s2)
	$$ LANGUAGE SQL;
												   
SELECT s1.sid, s2.sid, myCount(s1.sid, s2.sid) FROM Student s1, Student s2 
	WHERE s1.sid != s2.sid
	AND s1.sid IN (SELECT m2.sid FROM Major m1, Major m2 WHERE m1.sid = s2.sid AND m1.major = m2.major);

-- X)
SELECT b.book_no FROM Book b
	WHERE (SELECT COUNT(s.sid) FROM studentsWhoBoughtBook(b.book_no) s 
		JOIN Major m ON m.sid = s.sid WHERE m.major = 'CS'
		   		EXCEPT (SELECT m2.sid FROM Major m2 WHERE m2.major = 'CS')) = 1;


\c postgres;
DROP DATABASE jmb;
