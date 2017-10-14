/*Queries for 'Single-row Subqueries' using two-tables*/
SELECT LNAME,FNAME,DEPTID,BIRTHDATE,emailid,regi_date
FROM L_STUDENT
WHERE DEPTID = (SELECT DEPTID 
                FROM L_DEPARTMENT
                WHERE UPPER(DEPTNAME) = 'COMPUTER SCIENCE'
                );
                
SELECT LNAME,FNAME,DEPTID,BIRTHDATE,emailid,regi_date
FROM L_STUDENT
WHERE DEPTID = (SELECT DEPTID 
                FROM L_DEPARTMENT
                WHERE UPPER(DEPTNAME) = 'AUTOMOBILE'
                );       
                
/*Queries for 'Single-row Subqueries' using one table*/    

SELECT LNAME,FNAME,DEPTID,BIRTHDATE,emailid,regi_date,mobilenum
FROM L_STUDENT
WHERE CURRENTYEAR >= (SELECT CURRENTYEAR
                FROM L_STUDENT
                WHERE CURRENTYEAR = '4th Year'
                ); 

SELECT LNAME,FNAME,DEPTID,BIRTHDATE,emailid,regi_date,mobilenum
FROM L_STUDENT
WHERE REGI_DATE >= (SELECT REGI_DATE
                FROM L_STUDENT
                WHERE REGI_DATE = '24-MAR-14'
                ); 
                
/* Subquery with != operator */ 

SELECT LNAME,FNAME,DEPTID,BIRTHDATE,emailid,regi_date,USER_TYPE
FROM L_STUDENT
WHERE DEPTID != (SELECT DEPTID
                 FROM L_STUDENT
                 WHERE LNAME = 'Soni'
                ); 

SELECT LNAME,FNAME,DEPTID,BIRTHDATE,emailid,regi_date,USER_TYPE
FROM L_STUDENT
WHERE DEPTID != (SELECT DEPTID
                 FROM L_STUDENT
                 WHERE FNAME = 'Bhumit'
                ); 

/* Subquery to three levels */

SELECT ISSUENUM , ISSUE_DATE , BOOKNUM , DEPTID
FROM L_ISSUEDETAILS
WHERE DEPTID = (SELECT DEPTID
                FROM L_STAFF
                WHERE STAFFID =
                      (SELECT STAFFID
                       FROM L_STUDENT
                       WHERE FNAME = 'Bhumit'
                       )
                );
                
/* Creating table using Subquery*/ 

CREATE TABLE TEMP_S
AS 
SELECT STUDENTID,LNAME,FNAME,DEPTID
FROM L_STUDENT
WHERE DEPTID = 'D101';

DESC TEMP_S;

SELECT * FROM TEMP_S;

/* INSERT USING A SUBQUERY */
 
INSERT INTO TEMP_S(STUDENTID,LNAME,FNAME)
SELECT STUDENTID,LNAME,FNAME
FROM L_STUDENT
WHERE DEPTID = 'D104';

SELECT * FROM TEMP_S;

/* Update using a SubQuery */

UPDATE L_AUTHOR
SET PHONE = '902-348-6297'
WHERE AUTHOR_ID = (SELECT AUTHOR_ID
                 FROM L_BOOK
                 WHERE BOOKTITLE = 'ECONOMICS');
                 
UPDATE TEMP_S
SET ( LNAME , FNAME , DEPTID) =
     (SELECT LNAME , FNAME , DEPTID
      FROM L_ISSUEDETAILS
      WHERE  BOOKNUM = '904');
 
SELECT * FROM TEMP_S;  

/* DELETE using a subquery */

DELETE FROM TEMP_S
WHERE DEPTID = (SELECT DEPTID
                FROM TEMP_S
                WHERE LNAME = 'Soni');
              
/* Subquery with IN operator */

SELECT STUDENTID, LNAME , FNAME , STAFFID
FROM L_STUDENT
WHERE STAFFID IN (SELECT STAFFID
                  FROM L_STAFF
                  WHERE DEPTID = 'D101');
                 
/* Subquery with >ANY operator */

SELECT STUDENTID , LNAME , FNAME , CURRENTYEAR
FROM L_STUDENT
WHERE CURRENTYEAR >ANY
  (SELECT CURRENTYEAR FROM L_STUDENT WHERE STAFFID = '22')
  AND STAFFID <> 22;

SELECT STUDENTID , LNAME , FNAME , CURRENTYEAR
FROM L_STUDENT
WHERE CURRENTYEAR >ANY
  (SELECT CURRENTYEAR FROM L_STUDENT WHERE STAFFID = '22')
  AND STAFFID <> 33;
  
/* Subquery with <ALL operator */

SELECT STUDENTID , LNAME , FNAME , STAFFID
FROM L_STUDENT
WHERE STAFFID <ALL
    (SELECT AVG(STAFFID) FROM L_STUDENT GROUP BY DEPTID);
    
/* Query for Top-4 DEPTID */

SELECT ROWNUM , BOOKNUM , BOOKTITLE , DEPTID
FROM (SELECT BOOKNUM , BOOKTITLE , DEPTID
      FROM L_BOOK
      ORDER BY DEPTID DESC)
WHERE ROWNUM <= 4;


  