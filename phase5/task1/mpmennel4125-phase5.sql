--1. Find all positions (the names) with a salary greater than $95,000
SELECT p_salary AS "1.Position with salary greater than $95,000."
FROM position2
WHERE p_salary > 95000;

--2. [2 pts] Find all employees that do not have a position.
SELECT *
FROM employee
WHERE positionid IS NULL;

--3. [2 pts] Find the average hours submitted by employee E001 to their timecards.
SELECT ROUND(AVG(t_hours),2) AS "3. Average hours submitted by employee E001."
FROM timecard
WHERE t_empid = 'E001';

--4. [2 pts] Find all employee's born in August. Sort the output by the employee name. Hint:remember the LIKE operator.
SELECT e_name AS "4. Employees born in August", e_dob  
FROM employee
WHERE e_dob LIKE '%AUG%'
ORDER BY e_name;

--5. [2 pts] Find the minimum and maximum salaries amongst all positions. Use only a singlequery that returns a single row (ex. $60000, $100000).
SELECT '$' || MIN(p_salary) AS "5 .MIN SALARY", '$' || MAX(p_salary) AS "MAXSALARY"
FROM position2;

--6. [2 pts] Find all 4000-level courses. Hint: remember the LIKE operator.
SELECT c_id AS "6. 4000-LEVEL"
FROM course
WHERE c_id LIKE '%4___';

--7. [2 pts] Find the number of timecards for E018 with hours between 5 and 7 (inclusive).
SELECT COUNT(t_empid) AS "7. Number of timecards with hours between 5 and 7."
FROM timecard
WHERE t_empid = 'E018'
AND t_hours BETWEEN 5 AND 7;


--8. [4 pts] Find the name of the position with the highest salary. Do not harcode any salaries -you must use SQL without assuming you know the current database snapshot.
SELECT p_name AS "8. Highest Salary Position"
FROM position2
WHERE p_salary = (SELECT MAX(p_salary) FROM position2);

--9. [4 pts] Find the employee timecards with the submitted hours greater than the averageoverall hours + 75% (i.e., greater than 1.75 * average hours.). Do not hardcode any hours orother values – you must use SQL without assuming you know the current database snapshot.
SELECT t_empid AS "9. Employees who have hours greater than the average + 75%."
FROM timecard
WHERE t_hours > (SELECT 1.75 * AVG(t_hours) FROM timecard);
