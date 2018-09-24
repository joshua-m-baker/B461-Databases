CREATE DATABASE jmb;
\c jmb; 

-- Actual problems after all these definitions 

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

\c postgres;
DROP DATABASE jmb;
