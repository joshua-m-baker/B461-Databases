CREATE DATABASE jmb;
\c jmb; 

CREATE TABLE Student(
	sid INTEGER PRIMARY KEY,
	sname VARCHAR(15)
);

CREATE TABLE Book(
	book_no INTEGER PRIMARY KEY,
	title VARCHAR(30),
	price INTEGER
);

CREATE TABLE Cites(
	book_no INTEGER REFERENCES Book(book_no),
	cited_book_no INTEGER REFERENCES Book(book_no),
	PRIMARY KEY (book_no, cited_book_no)
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
INSERT INTO Cites VALUES
    (2012, 2001),
    (2008, 2011),
    (2008, 2012),
    (2001, 2002),
    (2001, 2007),
    (2002, 2003),
    (2003, 2001),
    (2003, 2004),
    (2003, 2002),
    (2010, 2001),
    (2010, 2002),
    (2010, 2003),
    (2010, 2004),
    (2010, 2005),
    (2010, 2006),
    (2010, 2007),
    (2010, 2008),
    (2010, 2009),
    (2010, 2011),
    (2010, 2013),
    (2010, 2014);


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

-- P1 
-- Original Query
\qecho '==========================================='
\qecho 'Problem 1 - Original'
SELECT DISTINCT s.sid, s.sname, b.book_no, b.title FROM 
    Student s CROSS JOIN book b
    INNER JOIN buys t ON(
        (s.sname = 'Eric' OR s.sname = 'Anna') AND
        s.sid = t.sid AND
        b.price > 20 AND
        t.book_no=b.book_no
);

-- Replace cross join with inner join
SELECT DISTINCT s.sid, s.sname, b.book_no, b.title FROM 
    book b
    INNER JOIN buys t ON(
        b.price > 20 AND
        t.book_no=b.book_no
	)
	INNER JOIN Student s ON(
		(s.sname = 'Eric' OR s.sname = 'Anna') AND
        s.sid = t.sid 
);

-- Replace inner join with natural join since it's faster
SELECT DISTINCT q3.sid, q3.sname, b.book_no, b.title FROM 
    book b
    INNER JOIN buys t ON(
        b.price > 20 AND
        t.book_no=b.book_no
	)
	NATURAL JOIN (SELECT s.sid, s.sname FROM Student s WHERE s.sname = 'Eric' OR s.sname = 'Anna') q3;

-- Replace OR with UNION
SELECT DISTINCT q3.sid, q3.sname, b.book_no, b.title FROM 
    book b
    INNER JOIN buys t ON(
        b.price > 20 AND
        t.book_no=b.book_no
	)
	NATURAL JOIN (
		(SELECT s.sid, s.sname FROM Student s WHERE s.sname = 'Eric')
		UNION 
		(SELECT s.sid, s.sname FROM Student s WHERE s.sname = 'Anna')
	) q3;

-- Translate inner join to natural join
\qecho '********************************'
\qecho 'P1 - FINAL'
SELECT DISTINCT b.book_no, b.title, q2.sid, q2.sname FROM Book b NATURAL JOIN
        (SELECT DISTINCT t.book_no,t.sid, q1.sname FROM Buys t NATURAL JOIN (
			(SELECT s.sid, s.sname FROM Student s WHERE s.sname = 'Eric')
            UNION 
            (SELECT s.sid, s.sname FROM Student s WHERE s.sname = 'Anna')
        )q1
    )q2 WHERE b.price > 20
;
\qecho '==========================================='

-- P2
\qecho '==========================================='
\qecho 'Problem 2 - Original'
SELECT DISTINCT s.sid FROM 
    Student s CROSS JOIN book b
    INNER JOIN buys t ON(
        (s.sname = 'Eric' OR s.sname = 'Anna') AND
        s.sid = t.sid AND
        b.price > 20 AND
        t.book_no=b.book_no
);

-- Mostly the same as p1, just less info needs to be passed along
\qecho '********************************'
\qecho 'Problem 2 - FINAL'
SELECT DISTINCT q3.sid FROM
    (SELECT DISTINCT q2.sid FROM Book b NATURAL JOIN
        (SELECT DISTINCT t.book_no,t.sid, q1.sname FROM Buys t NATURAL JOIN (
			(SELECT s.sid, s.sname FROM Student s WHERE s.sname = 'Eric')
            UNION 
            (SELECT s.sid, s.sname FROM Student s WHERE s.sname = 'Anna')
        )q1
    )q2 WHERE b.price > 20
)q3;
\qecho '==========================================='

-- P3
-- Original Query 
\qecho '==========================================='
\qecho 'Problem 3 - Original'
SELECT DISTINCT s.sid, b1.price as b1_price, b2.price as b2_price FROM 
	(SELECT s.sid FROM student s WHERE s.sname <> 'Eric') s
	CROSS JOIN book b2
	INNER JOIN book b1 ON (b1.book_no <> b2.book_no AND b1.price > 60 AND b2.price >= 50)
	INNER JOIN buys t1 ON (t1.book_no = b1.book_no AND t1.sid = s.sid)
	INNER JOIN buys t2 ON (t2.book_no = b2.book_no AND t2.sid = s.sid);

-- push book conditions down by selecting only from smaller book table
SELECT DISTINCT s.sid, q1.price as b1_price, q2.price as b2_price FROM 
	(SELECT s.sid FROM student s WHERE s.sname <> 'Eric') s
	CROSS JOIN (SELECT * FROM Book b2 WHERE b2.price >= 50)q2
	INNER JOIN (SELECT * FROM Book b1 WHERE b1.price > 60)q1 ON (q1.book_no <> q2.book_no)
	INNER JOIN buys t1 ON (t1.book_no = q1.book_no AND t1.sid = s.sid)
	INNER JOIN buys t2 ON (t2.book_no = q2.book_no AND t2.sid = s.sid);

-- remove buys t2 inner join
SELECT DISTINCT s.sid, q1.price as b1_price, q2.price as b2_price FROM 
	(SELECT s.sid FROM student s WHERE s.sname <> 'Eric') s
	CROSS JOIN (SELECT * FROM Book b2 WHERE b2.price >= 50) q2
	NATURAL JOIN (
		SELECT * FROM buys t2 NATURAL JOIN (SELECT * FROM buys t1) q
	)q3
	INNER JOIN (SELECT * FROM Book b1 WHERE b1.price > 60) q1 ON (q1.book_no <> q2.book_no)
	INNER JOIN buys t1 ON (t1.book_no = q1.book_no AND t1.sid = s.sid);

-- Remove the cross and 1 inner join. I don't see any way possible to remove the other inner join
\qecho '*******************************'
\qecho 'Problem 3 - FINAL'
SELECT DISTINCT s.sid, q4.price AS b1_price, q2.price AS b2_price FROM 
	(SELECT s.sid FROM student s WHERE s.sname <> 'Eric') s
	NATURAL JOIN (
		SELECT DISTINCT q1.price, q1.book_no, t1.sid FROM buys t1 
			NATURAL JOIN (SELECT b.book_no, b.price FROM Book b WHERE b.price >= 50) q1
	) q2 
	INNER JOIN (
		SELECT DISTINCT q3.price, q3.book_no, t2.sid FROM buys t2
			NATURAL JOIN (SELECT b.book_no, b.price FROM Book b WHERE b.price > 60) q3
	)q4 ON (s.sid = q4.sid AND q4.book_no <> q2.book_no);
\qecho '==========================================='

-- P4
\qecho '==========================================='
\qecho 'Problem 4 - Original'
SELECT q.sid FROM (
	SELECT s.sid, s.sname FROM Student s
	EXCEPT 
	SELECT s.sid, s.sname FROM Student s
		INNER JOIN Buys t on (s.sid = t.sid)
		INNER JOIN Book b on (t.book_no = b.book_no and b.price > 50)	 
) q;

-- Remove inner join  FINAL
\qecho '********************************'
\qecho 'Problem 4 - FINAL'
SELECT q.sid FROM (
	SELECT s.sid FROM Student s
	EXCEPT 
	SELECT t.sid FROM Buys t NATURAL JOIN (
		SELECT b.book_no FROM Book b WHERE b.price > 50
	)q1
) q;
\qecho '==========================================='

-- P5
\qecho '==========================================='
\qecho 'Problem 5 - Original'
SELECT q.sid, q.sname FROM
	(SELECT s.sid, s.sname, 2007 AS bookno FROM student s 
	 CROSS JOIN book b 
	 INTERSECT select s.sid, s.sname, b.book_no FROM
		 student s CROSS JOIN book b INNER JOIN buys t ON (
			 s.sid = t.sid AND t.book_no = b.book_no AND b.price < 25
		 )
	) q;
	
-- Remove intersect
SELECT DISTINCT q.sid, q.sname FROM (
	SELECT DISTINCT s.sid, s.sname FROM Student s NATURAL JOIN ( 
		SELECT DISTINCT t.sid FROM buys t NATURAL JOIN (
			 SELECT DISTINCT b.book_no FROM Book b WHERE b.book_no = 2007 AND b.price < 25
		)q1
	)q2
)q;

-- Remove unnecessary SELECT
SELECT DISTINCT s.sid, s.sname FROM Student s NATURAL JOIN ( 
	SELECT DISTINCT t.sid FROM buys t NATURAL JOIN (
		 SELECT DISTINCT b.book_no FROM Book b WHERE b.book_no = 2007 AND b.price < 25
	)q1
)q2;

-- Remove inner AND  FINAL
\qecho '********************************'
\qecho 'Problem 5 - FINAL'
SELECT DISTINCT s.sid, s.sname FROM Student s NATURAL JOIN ( 
	SELECT DISTINCT t.sid FROM buys t NATURAL JOIN (
		SELECT DISTINCT q3.book_no FROM (
			SELECT DISTINCT b.book_no FROM Book b WHERE b.price < 25
		)q3 WHERE q3.book_no = 2007 
	)q2
)q1;
\qecho '==========================================='

-- P6
\qecho '==========================================='
\qecho 'Problem 6 - Original'
SELECT DISTINCT q.book_no FROM   
	(SELECT s.sid, s.sname, b.book_no, b.title FROM
	 	student s CROSS JOIN book b
	 EXCEPT 
	 SELECT s.sid, s.sname, b.book_no, b.title 
	 FROM student s 
	 	CROSS JOIN book b 
	 	INNER JOIN buys t ON (s.sid = t.sid AND t.book_no = b.book_no AND b.price <20)
	) q;

-- Remove book inner join and cross join
SELECT DISTINCT q.book_no FROM   
	(SELECT s.sid, s.sname, b.book_no, b.title FROM
	 	student s CROSS JOIN book b
	 EXCEPT 
	 (SELECT s.sid, s.sname, q1.book_no, q1.title
	 FROM student s 
	 	NATURAL JOIN buys t NATURAL JOIN (SELECT * FROM Book b WHERE b.price < 20) q1
	 )
	)q;

-- Second students table is unnecessary  FINAL
\qecho '********************************'
\qecho 'Problem 6 - FINAL'
SELECT DISTINCT q.book_no FROM (
	SELECT s.sid, b.book_no FROM
	 	student s CROSS JOIN book b
	 EXCEPT 
	 (SELECT t.sid, q1.book_no
	 FROM buys t NATURAL JOIN (SELECT b.book_no FROM Book b WHERE b.price < 20) q1
	 )
)q;
\qecho '==========================================='
	
\c postgres;
DROP DATABASE jmb;

	
