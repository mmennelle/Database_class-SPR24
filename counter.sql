SELECT 'Employee: ' || COUNT(*) AS Cnt FROM Employee
UNION
SELECT 'Position: ' || COUNT(*) AS Cnt FROM Position2
UNION
SELECT 'Course: ' || COUNT(*) AS Cnt FROM Course
UNION
SELECT 'Address: ' || COUNT(*) AS Cnt FROM Address
UNION
SELECT 'Timecard: ' || COUNT(*) AS Cnt FROM Timecard
UNION
SELECT 'Enrollment: ' || COUNT(*) AS Cnt FROM Enrollment
UNION
SELECT 'Requirement: ' || COUNT(*) AS Cnt FROM Requirement
UNION
SELECT 'Prereq: ' || COUNT(*) AS Cnt FROM Prereq;


