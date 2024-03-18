
--1. Retrieve the names of all positions held by more than 5 employess. Sort the output by the position name (any direction).
SELECT P_name as "1. Retrieve the names of all positions held by more than 5 employess"
FROM position2 p
JOIN Employee e ON p.p_id = e.positionid
GROUP BY p.p_name
HAVING COUNT(e.e_id) > 5
ORDER by p.p_name;
--2. Retrieve the names of all courses that have 'Data Structures' as a prerequisite.
SELECT c.c_name as "2. Retrieve the names of all courses that have 'Data Structures' as a prerequisite."
FROM course c
JOIN prereq p ON c.c_id = p.pre_c_id 
JOIN course prereq_course ON p.pre_id = prereq_course.c_id 
WHERE prereq_course.c_name = 'Data Structures';


--3. Find the employee names that have the highest paying position.
SELECT e_name as "3. Find the employee names that have the highest paying position."
FROM employee e
JOIN position2 p ON e.positionid = p.p_id
WHERE p.p_salary = (SELECT MAX(p_salary) FROM position2);

--4. Find the total number of hours worked for each position name.
SELECT p.p_name as "4. Find the total number of hours worked for each position name.", SUM(t_hours) as total_hours
FROM position2 p
JOIN employee e ON p.p_id = e.positionid
JOIN timecard wh ON e.e_id = wh.t_empid
GROUP BY p.p_name;

--5. List the total number of A's and B's for each course name. Order the output (descending) by this number.
SELECT c_name as "5. List the total number of A's and B's for each course name.", COUNT(*) as total_grades
FROM course c
JOIN Enrollment g ON c.c_id = g.enroll_c_id
WHERE g.Enroll_grade IN ('A', 'B')
GROUP BY c.c_name
ORDER BY total_grades DESC;

--6. Find the course name(s) that is/are the most common requirement for positions.

SELECT c.c_name as "6. Find the course name(s) that is/are the most common requirement for positions.", COUNT(pr.reqp_id)
FROM course c
JOIN requirement pr ON c.c_id = pr.reqc_id 
GROUP BY c.c_name
ORDER BY COUNT(pr.reqp_id) DESC;

--7. Find the employee name who worked the most hours between March 10th and 19th (inclusive)
SELECT e.e_name as "7. Find the employee name who worked the most hours between March 10th and 19th (inclusive)", SUM(tc.t_hours) AS total_hours
FROM employee e
JOIN timecard tc ON e.e_id = tc.t_empid
WHERE tc.t_date BETWEEN '10-MAR-24' AND '19-MAR-24'
GROUP BY e.e_name
ORDER BY total_hours DESC
FETCH FIRST 1 ROWS ONLY;

--8. This problem requires (no points if you don't) you to use the regular expression functionREGEXP_LIKE that we discussed in class.
-- Find all employee names where both the first name and last name begin with a vowel
SELECT e_name as "8. Find all employee names where both the first name and last name begin with a vowel"
FROM employee
WHERE REGEXP_LIKE(e_name, '^[AEIOUaeiou].*\s[AEIOUaeiou]');


