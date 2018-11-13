\echo '============================'
\qecho 'Problem 1' 
create or replace function setunion(A anyarray, B anyarray)
    returns anyarray as
$$ select ARRAY( 
    select unnest(A)
        union
    select unnest(B));
$$ language sql;

\qecho 'A)'
create or replace function setintersection(A anyarray, B anyarray)
    returns anyarray as
$$ select ARRAY( 
    select unnest(A)
        intersect
    select unnest(B));
$$ language sql;

\qecho 'B)'
create or replace function setdifference(A anyarray, B anyarray)
    returns anyarray as
$$ select ARRAY( 
    select unnest(A)
        -
    select unnest(B));
$$ language sql;

CREATE OR REPLACE FUNCTION memberof(x anyelement, A anyarray)
    returns boolean AS 
$$
    SELECT x = SOME(A);
$$ language sql;

\qecho '============================'
\qecho 'Problem 2'
CREATE OF REPLACE VIEW student_books AS
    SELECT s.sid AS sid, array (
            SELECT t.bookno FROM Buys t
                WHERE t.sid = s.sid
                ORDER BY bookno
        ) AS books 
        FROM Student s ORDER BY sid
;

\qecho 'A)'
CREATE OR REPLACE VIEW book_students AS
    SELECT b.bookno AS bookno, array (
        SELECT t.sid FROM Buys t
            WHERE t.bookno = b.bookno
            ORDER BY bookno
    ) AS students
    FROM Books b ORDER BY bookno
;

\qecho 'B)'
CREATE OR REPLACE book_citedbooks AS
    SELECT b.bookno AS bookno, array (
        SELECT c.cited_book_no FROM Cites c
            WHERE c.bookno = b.bookno
            ORDER BY bookno
    ) AS citedbooks 
    FROM Books b ORDER BY bookno
;

\qecho 'C)'
CREATE OR REPLACE book_citingbooks AS
    SELECT b.bookno AS bookno, array (
        SELECT c.bookno FROM Cites c
            WHERE c.cited_book_no = b.bookno
            ORDER BY bookno
    ) AS citedbooks 
    FROM Books b ORDER BY bookno
;

\qecho 'D)'
CREATE OR REPLACE major_students AS 
    SELECT m.major AS major, array (
        SELECT s.sid FROM Student s
            WHERE s.sid = m.sid
            ORDER BY sid
    ) AS students
    FROM major m ORDER BY major
;

\qecho 'E)'
CREATE OR REPLACE student_majors AS 
    SELECT s.sid AS sid, array (
        SELECT m.major FROM Major m 
            WHERE m.sid = s.sid 
            ORDER BY major 
    ) AS majors
    FROM Student s ORDER BY sid
;

\qecho '============================'
\qecho 'Problem 3'

\qecho 'A)'
SELECT * FROM student_books 
    WHERE cardinality(books) = 2 

\qecho 'B)'
WITH books1001 AS (
    SELECT sid, books FROM student_books
        WHERE sid = 1001)
SELECT sb.sid FROM student_books 
    WHERE cardinality(setdifference(sb, books1001)=0


\qecho 'J)'
SELECT bs.bookNo, setintersection(cs.sid,bs.students) as students
    FROM book_students bs, (
        SELECT MS.Students AS SID FROM major_students MS
            WHERE MS.Major = 'CS'
        ) CS
;

