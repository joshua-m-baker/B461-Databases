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

CREATE TABLE Major(
	sid INTEGER REFERENCES Student(sid),
	major VARCHAR(15),
	PRIMARY KEY (sid, major)
);

CREATE TABLE Cites(
	book_no INTEGER REFERENCES Book(book_no),
	cited_book_no INTEGER REFERENCES Book(book_no),
	PRIMARY KEY (book_no, cited_book_no)
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
-- 1)
\echo 'Problem 1'
SELECT ma.sid, ma.major FROM Major ma
	WHERE ma.sid IN (
		SELECT b.sid FROM Buys b WHERE 
			b.book_no IN
				(SELECT b.book_no FROM book b WHERE
					b.price<20)
		);

-- 2)
\echo 'Problem 2'
SELECT b.book_no, b.title FROM book b WHERE
	b.book_no IN (
		SELECT cited_book_no FROM cites
	) AND 
	b.price <= 40 AND 
	b.price >= 20;
	
-- 3)
\echo 'Problem 3'
SELECT s.sid, s.sname FROM Student s WHERE
	s.sid IN (SELECT sid FROM Major WHERE major = 'CS')
	AND s.sid IN (
		SELECT sid FROM Buys WHERE Buys.book_no IN (
			SELECT b.book_no FROM Book b WHERE
				b.price > ALL(
				SELECT b2.price FROM Book b2 WHERE 
				b2.book_no IN (SELECT s.cited_book_no 
					FROM Cites s WHERE s.book_no = b.book_no
				)
			)
		)
);
	
-- 4)
\echo 'Problem 4'
SELECT b.book_no, b.title FROM book b WHERE
	b.book_no IN (
		SELECT ci.cited_book_no FROM cites ci WHERE
			ci.book_no IN (
				SELECT cited_book_no FROM cites
		)
	);

-- 5) 
\echo 'Problem 5'
SELECT b.book_no FROM Book b WHERE 
	b.price <= ALL (SELECT b2.price FROM Book b2);

-- 6)
\echo 'Problem 6'
SELECT b.book_no, b.title FROM Book b WHERE b.book_no NOT IN (
	SELECT b2.book_no FROM Book b2 WHERE b2.price < ANY (
		SELECT price FROM Book
	)
);
							   
-- 7)
\echo 'Problem 7'
CREATE VIEW notHighest AS SELECT b2.price, b2.book_no, b2.title FROM book b2 WHERE b2.price < SOME (SELECT price FROM book);
SELECT b.book_no, b.title FROM notHighest b
	WHERE b.price >= ALL (SELECT price FROM notHighest);
DROP VIEW notHighest;

-- 8) 
\echo 'Problem 8'
SELECT b.book_no FROM Book b 
	WHERE b.book_no IN(		
		SELECT DISTINCT c.book_no FROM Cites c
			WHERE c.book_no IN(
				SELECT c2.cited_book_no FROM Cites c2
			) 
			AND c.cited_book_no IN (
				SELECT b2.book_no FROM book b2 WHERE b2.price > 20
			)
	)UNION(
		SELECT b2.book_no FROM Book b2 EXCEPT(SELECT cited_book_no FROM Cites)
	);
	
-- 9) 
\echo 'Problem 9'
SELECT b.book_no, b.title FROM book b WHERE
	b.book_no IN(
		SELECT bu.book_no FROM Buys bu WHERE
			bu.sid IN (SELECT m.sid FROM Major m WHERE 
				m.major = 'Biology' OR
				m.major = 'Psychology')
	);

-- 10) (buys set minus the cs students plus the books not bought at all)
\echo 'Problem 10'
SELECT book_no FROM Buys
	EXCEPT(SELECT m.sid FROM major m WHERE
	m.major = 'CS')
	UNION(SELECT book_no FROM book EXCEPT(
		SELECT book_no FROM Buys
	)
);

-- 11)
\echo 'Problem 11'
SELECT b.book_no FROM Book b Except(
	SELECT book_no FROM Buys 
		EXCEPT (SELECT m.sid FROM major m WHERE
		m.major != 'Biology')
);
										  
-- 12) 
\echo 'Problem 12'
CREATE VIEW double_book AS SELECT DISTINCT b.book_no, b.sid FROM Buys b WHERE 
	b.sid IN (
		SELECT DISTINCT m.sid FROM Major m WHERE 
			m.major = 'CS' INTERSECT( 
			SELECT m.sid FROM Major m WHERE 
				m.major = 'Math'
		)
	);
SELECT bk.book_no, bk.title FROM Book bk
	WHERE bk.book_no IN(
		SELECT b.book_no FROM double_book b
			WHERE b.book_no IN(
				SELECT DISTINCT b2.book_no FROM double_book b2
					WHERE b2.book_no = b.book_no 
						AND b2.sid != b.sid
			)
	);
DROP VIEW double_book;

-- 13)
\echo 'Problem 13'
CREATE VIEW cs_student AS SELECT s.sid FROM Major s WHERE s.major = 'CS';
SELECT s.sid, s.sname FROM Student s 
	WHERE s.sid IN( 
	SELECT DISTINCT s.sid FROM Buys s 
		WHERE EXISTS(
			SELECT b3.book_no FROM Buys b3
				WHERE b3.sid = s.sid
				EXCEPT(
					SELECT b.book_no FROM Buys b 
						WHERE b.book_no IN(
							SELECT b2.book_no FROM Buys b2 WHERE b2.sid != b.sid	
								AND b2.sid IN (SELECT sid FROM cs_student)
								AND b.sid IN (SELECT sid FROM cs_student)
					)
				)
		)
	);
DROP VIEW cs_student;

-- 14) I couldn't get this one to work as the directions specify, but if we
-- were allowed to use COUNT, I would just check that the count of a specific 
-- sid <= 1
-- students except one that bought more than one book that costs more than 20
\echo 'Problem 14'
CREATE VIEW over_twenty AS(SELECT book_no FROM Book WHERE price > 20);
SELECT s.sid FROM Student s
	WHERE s.sid IN(
		SELECT b.sid FROM Buys b
			WHERE b.book_no IN(
					SELECT book_no FROM over_twenty
			)
	)UNION(
		SELECT s.sid FROM Student s
			WHERE s.sid NOT IN(
				SELECT b2.sid FROM Buys b2
			)
	);
DROP VIEW over_twenty;
	
	

-- 15)	
\echo 'Problem 15'					   
SELECT DISTINCT b.sid, b.book_no FROM Buys b
	WHERE b.book_no IN (
		SELECT bk.book_no FROM Book bk
			WHERE bk.price <= ALL(
				SELECT bk2.price FROM Book bk2
					WHERE bk2.book_no IN(
						SELECT bys.book_no FROM Buys bys
							WHERE bys.sid = b.sid
					)
				)
	) ORDER BY(b.sid);

\c postgres;
DROP DATABASE jmb;