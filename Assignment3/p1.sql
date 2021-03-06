CREATE TABLE A(
	a INT
);

CREATE TABLE B(
	b INT
);

-- 1) 
INSERT INTO A VALUES (1),(2),(3),(4),(5);
SELECT a AS x, SQRT(a) AS x_squared, a*a AS two_to_the_power_x, 
POWER(2,a) AS x_factorial, a!, ln(a) AS logarithm_x FROM a ;


TRUNCATE TABLE A;
INSERT INTO A VALUES (1),(2),(3);
INSERT INTO B VALUES (1),(3),(4),(5);
-- 2) 


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
										   
-- 3)
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

-- 4)
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


													 
-- 5)
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
												 
													 
DROP VIEW AuB;
DROP TABLE A;
DROP TABLE B;
DROP TABLE C;
