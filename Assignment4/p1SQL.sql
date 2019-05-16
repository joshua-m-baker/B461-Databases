CREATE DATABASE jmb;
\c jmb; 

-- A)
SELECT s.sid, s.sname FROM Student s
	WHERE s.sid IN	
		(SELECT b.sid FROM Buys b 
			WHERE b.book_no IN
				(SELECT c.book_no FROM Cites c
			)
		 )
;
				 
-- B)
SELECT s.sid, s.sname FROM STUDENT s 
	WHERE s.sid IN
		(SELECT DISTINCT m1.sid FROM Major m1, Major m2 
			WHERE m1.sid = m2.sid 
				AND m1.major <> m2.major)
;

-- C)
SELECT DISTINCT b.sid FROM Buys b
	WHERE b.sid NOT IN
		(SELECT b1.sid FROM Buys b1, Buys b2
			WHERE b1.sid = b2.sid 
				AND b1.book_no<>b2.book_no
		)
;

-- D)
SELECT q.book_no, q.title FROM (
	SELECT b.book_no, b.title FROM Book b
		EXCEPT
	SELECT bu.book_no, b.title FROM Buys bu 
		INNER JOIN Book b ON bu.book_no = b.book_no
		WHERE bu.sid <> 1001
) q;

-- E)
SELECT DISTINCT s.sid, s.sname
	FROM Book b1, Book b2, Student s
		INNER JOIN Buys bu1 ON bu1.sid = s.sid
		INNER JOIN Buys bu2 ON bu2.sid = s.sid
	WHERE bu2.book_no <> bu1.book_no
		AND bu1.book_no = b1.book_no
		AND bu2.book_no = b2.book_no
		AND b2.price < 50
		AND b1.price < 50
;

-- F)
WITH cs AS (SELECT sid FROM Major WHERE major = 'CS')
SELECT DISTINCT b4.book_no FROM (
	(SELECT DISTINCT b.book_no, s.sid FROM Book b, Student s)
	EXCEPT 
	(SELECT DISTINCT bu.book_no, c.sid
	 	FROM Buys bu, (SELECT * FROM cs) c
			WHERE c.sid = bu.sid
	)
) b4;	
	

-- G) 
WITH E1 AS 
		(SELECT b.book_no, ci.cited_book_no, b.price
		FROM Book b INNER JOIN Cites ci ON ci.book_no = b.book_no
	),
	E2 AS 
		(SELECT E1.cited_book_no FROM E1 WHERE E1.price > 50)
SELECT DISTINCT book_no FROM Book
UNION 
SELECT DISTINCT book_no FROM E1 EXCEPT 
	SELECT DISTINCT cited_book_no FROM E2;

-- H) 
SELECT DISTINCT bu.sid, Q.bn2 
FROM Buys bu, (SELECT b1.book_no AS bn1, b2.book_no AS bn2 
		FROM Book b1, Book b2
	EXCEPT
		SELECT book_no, cited_book_no 
		FROM cites) Q
WHERE bu.book_no = Q.bn1;	

-- I)
WITH cs AS (
	SELECT DISTINCT cs.sid, book_no FROM
		(SELECT DISTINCT m.sid FROM major m
			WHERE major = 'CS') cs
		INNER JOIN Buys bu ON cs.sid = bu.sid),
bp AS (
	(SELECT b1.book_no AS b1, b2.book_no AS b2 FROM 
	 	Book b1 INNER JOIN Book b2 ON b1.book_no != b2.book_no)
	EXCEPT
		(SELECT t.bno, t.buybn FROM (
			SELECT b.book_no AS bno, c2.sid, c2.book_no AS buybn
			FROM Book b, cs c2
			EXCEPT 
			SELECT c2.book_no, c2.sid, b.book_no
			FROM cs c2, book b) t
		)
	)
SELECT bp1.b1, bp1.b2
FROM bp bp1, bp bp2
WHERE bp1.b1 = bp2.b2 AND bp1.b2 = bp2.b1;
		


-- J)
SELECT q.sid1, q.sid2 FROM (
	SELECT s1.sid AS sid1, s2.sid AS sid2 FROM Student s1, Student s2
		WHERE s1.sid <> s2.sid
		EXCEPT
		SELECT q2.sid1, q2.sid2 FROM (
			SELECT s1.sid AS sid1, s2.sid AS sid2, bu.book_no
			FROM Student s1, Student s2, Buys bu 
				WHERE s1.sid != s2.sid AND s1.sid = bu.sid
				EXCEPT
				SELECT s1.sid AS sid1, s2.sid AS sid2, bu.book_no
				FROM Student s1, Student s2, Buys bu
					WHERE s1.sid <> s2.sid AND s2.sid = bu.sid
		)q2
)q;
\c postgres;
DROP DATABASE jmb;
