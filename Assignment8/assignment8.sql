--1
CREATE TABLE IF NOT EXISTS A(x int);
INSERT INTO A VALUES (1),(2),(3),(4);

--3
CREATE TABLE IF NOT EXISTS G(source int, target int);
INSERT INTO G VALUES (1,2),(1,3),(2,3),(2,4),(3,7),(7,4),(4,5),(4,6),(7,6);

--4
CREATE TABLE documents(doc int PRIMARY KEY, words text[]);
					   
INSERT INTO documents VALUES 
	(1, ARRAY['A', 'B', 'C']),
	(2, ARRAY['B', 'C', 'D']),
	(3, ARRAY['A', 'E']),
	(4, ARRAY['B', 'B', 'A', 'D']),
	(5, ARRAY['E', 'F']),
	(6, ARRAY['A', 'D', 'G']),
	(7, ARRAY['C','B', 'A']),
	(8, ARRAY['B', 'A']);					  

--5
CREATE TABLE IF NOT EXISTS partSubpart (pid int, sid int, quantity int, PRIMARY KEY (pid, sid));
CREATE TABLE IF NOT EXISTS basicPart (pid int, weight int, PRIMARY KEY (pid));
CREATE TABLE IF NOT EXISTS tempWeight(id int, t int);

INSERT INTO partSubpart values (1, 2, 4),(1, 3, 1),(3, 4, 1),(3, 5, 2), (3, 6, 3),(6, 7, 2),(6, 8, 3);
INSERT INTO basicPart values (2, 5),(4, 50),(5, 3),(7, 6),(8, 10);

\qecho 'problem 1'
CREATE OR REPLACE FUNCTION superSetsOfSet(x int[])
	RETURNS TABLE(supersetsofset int[]) AS 
$$
DECLARE
    remaining int[];
    i int[];
    l int;
BEGIN
    remaining := ARRAY((SELECT * FROM A an) EXCEPT (SELECT UNNEST(x)) ORDER BY x); 
	DROP TABLE IF EXISTS ret;
    CREATE TABLE ret(subset int[]);
    INSERT INTO ret VALUES (x);
    FOR l IN (SELECT UNNEST(remaining))
        LOOP
            FOR i IN SELECT * FROM ret r
                LOOP
                    IF l NOT IN (SELECT UNNEST(i)) THEN
                        INSERT INTO ret VALUES (
							array_append(i, l)
						);
                    END IF;
                END LOOP;
        END LOOP;
    RETURN QUERY SELECT * FROM ret r ORDER BY CARDINALITY(r.subset);
END;
$$ language plpgsql;

SELECT supersetsofset('{}');
											   
\qecho 'problem 2'
CREATE OR REPLACE FUNCTION connectedByEvenLengthPath()
    RETURNS TABLE(index int, node int) AS 
$$
DECLARE 
BEGIN
	DROP TABLE IF EXISTS evenpaths;
	DROP TABLE IF EXISTS oddpaths;
	CREATE TABLE evenpaths(source int, target int);
	CREATE TABLE oddpaths(source int, target int);
	INSERT INTO oddpaths SELECT * FROM G;
	INSERT INTO evenpaths SELECT o.source, g1.target FROM G g1, oddpaths o WHERE o.target = g1.source;
	RETURN QUERY SELECT * FROM evenpaths;
END;
$$ LANGUAGE plpgsql;
											   
CREATE OR REPLACE FUNCTION connectedByOddLengthPath()
    RETURNS TABLE(index int, node int) AS 
$$
DECLARE 
BEGIN
	RETURN QUERY SELECT * FROM G EXCEPT SELECT * FROM connectedByEvenLengthPath();								   
END;
$$ LANGUAGE plpgsql;
--DROP TABLE G
--CREATE TABLE IF NOT EXISTS G(source int, target int);
--INSERT INTO G VALUES (1,2),(2,3),(3,4),(4,5);
SELECT * FROM connectedByEvenLengthPath()
SELECT * FROM connectedByOddLengthPath()								   
											   
\qecho 'problem 3'
CREATE OR REPLACE FUNCTION topologicalSort()
    RETURNS TABLE(index int, node int) AS 
$$
DECLARE 
	cur int;
	current_index int := 1;
BEGIN
	DROP TABLE IF EXISTS G_copy;
	DROP TABLE IF EXISTS sorted;
	DROP TABLE IF EXISTS In_degree;

    CREATE TABLE In_degree(vertex int, degree int);
	CREATE TABLE G_copy(source int, target int);
	CREATE TABLE sorted (index int, node int);

	INSERT INTO G_copy SELECT * FROM G;
																 
    WHILE (SELECT COUNT(*) FROM G_Copy) > 0
	LOOP
    	INSERT INTO In_degree SELECT target, COUNT(target) FROM G_copy GROUP BY target;
		SELECT INTO cur source FROM G_copy EXCEPT SELECT vertex FROM In_degree;

		INSERT INTO sorted SELECT current_index, cur;
		current_index := current_index + 1;
    	DELETE FROM G_copy WHERE source = cur;
		DELETE FROM In_degree;
	END LOOP;
	RETURN QUERY SELECT * FROM sorted;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM topologicalSort();
											   
\qecho 'Problem 4'
CREATE OR REPLACE FUNCTION document(doc int, words text[])
	RETURNS TABLE(word_set text[]) AS 
$$
	-- I didn't have time to do this but if I did I'd use the power set to get all possible lists and see if a list is in that.
BEGIN
END;
$$ LANGUAGE plpgsql;
																			  
\qecho 'Problem 5'
CREATE OR REPLACE FUNCTION aggregatedWeight(part int)
	RETURNS int AS
$$
DECLARE 
	subPart int;
	quantity int;
	r int;
	total int;
BEGIN
	IF (SELECT NOT EXISTS(SELECT 1 FROM partSubpart WHERE pid = part)) 
		THEN RETURN (SELECT p.weight FROM basicPart p WHERE p.pid = part);
	END IF;

	INSERT INTO TempWeight (SELECT p.sid,p.quantity FROM partSubpart p WHERE p.pid = part);

	SELECT COUNT(*) INTO r FROM partSubpart WHERE pid = part;

	total := 0;
	while(r>0)
	LOOP
		SELECT t INTO quantity FROM tempWeight;
	
		SELECT id INTO subPart from tempWeight;

		DELETE FROM tempWeight WHERE id = subPart AND t = quantity;

		total := total + (quantity * (SELECT * FROM aggregatedWeight(subPart)));

		r := r-1;
	END LOOP;
	RETURN total;
END;
$$ LANGUAGE plpgsql;
SELECT * FROM basicpart;
SELECT * FROM aggregatedweight(1);
SELECT * FROM aggregatedweight(3);
SELECT q.pid, aggregatedweight(q.pid) FROM (SELECT pid FROM partsubpart UNION SELECT pid FROM basicpart) q ORDER BY 1;

\qecho 'problem 6'	
CREATE OR REPLACE FUNCTION djikstra(s int) RETURNS TABLE(target int, dist int) AS 
$$
DECLARE
    max_int int := 999999;
BEGIN
	CREATE TABLE results (vertex int, distance int);
  	INSERT INTO results SELECT src, 0 FROM G WHERE src = s;
	INSERT INTO results SELECT src, max_int FROM G WHERE src <> s;
END;
$$ LANGUAGE plpgsql;											 
				  
															 
DROP TABLE IF EXISTS G;
DROP TABLE A;
DROP TABLE partSubPart;
DROP TABLE basicPart;
DROP TABLE tempWeight;
																	 
																	 