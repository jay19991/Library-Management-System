/*Select query for Equijoin*/

SELECT L_STUDENT.FNAME || ',' || L_STUDENT.LNAME STUDENT ,
       L_STAFF.FNAME || ',' || L_STAFF.LNAME STAFF,
       L_STUDENT.deptid,L_STAFF.DEPTID 
FROM L_STUDENT , L_STAFF
WHERE l_student.deptid = l_staff.deptid;

/*Queries for Multiple Joins */

SELECT * FROM L_DEPARTMENT;