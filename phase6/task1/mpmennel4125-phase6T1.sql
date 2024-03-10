--1. Find the names of all employees who have at least one address.
SELECT E_Name As "1. Names of all employees with atleast one address." , A_E_address
FROM address, employee
WHERE E_ID = A_E_ID AND A_E_ADDRESS IS NOT NULL;

--2. For each employee id, list the total hours worked (from the timecards).
SELECT T_empid AS "2. Total hours per Employee ID.", SUM(T_hours) AS "Total hours worked"
FROM Timecard
GROUP BY t_empid
ORDER BY t_empid;
--3. Find the names of all employees that do not have an address.
SELECT E_Name AS "3. names of all employees with no address."
FROM employee e
LEFT JOIN address a ON e.E_ID = A_E_ID
WHERE A.A_E_ID IS NULL;
--4. Find the names of all employees that have the position 'Security Analyst'.
SELECT E_NAME AS "4. Employess with Security Analyst position.", P_NAME
FROM employee, position2
WHERE positionid = P_ID AND P_NAME = 'Security Analyst';