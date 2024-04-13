ALTER TABLE Employee ADD TotalHoursWOrked NUMBER DEFAULT 0;

CREATE OR REPLACE TRIGGER UpdatedHours
BEFORE INSERT ON Timecard
FOR EACH ROW 

DECLARE
    Total_Hours NUMBER;
    Max_Hours CONSTANT NUMBER := 160;
    
BEGIN
    SELECT TotalHoursWorked INTO Total_Hours
    FROM Employee
    WHERE e_id = :NEW.t_empid;

    IF Total_hours + :NEW.t_hours > Max_Hours THEN

        RAISE_APPLICATION_ERROR(-20200, 'Employee NUM' || :NEW.t_empid || 'Has exceeded hour limit.');
    ELSE
        UPDATE Employee
        SET TotalHoursWorked = Total_Hours + :NEW.t_hours
        WHERE e_id = :NEW.t_empid;
    END IF;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20201, 'No such employee exists with ID #' || :NEW.t_empid);
END UpdatedHours;
/

--TimeCard delete
DELETE FROM Timecard;
UPDATE Employee SET TotalHoursWorked = 0;

--insert test. Dont forget to resubmit all records!
INSERT INTO Timecard VALUES('E002', '30-MAR-24', 6.94);
INSERT INTO Timecard VALUES('E021', '30-MAR-24', 4.36);

--total hourse check
SELECT E_ID, E_Name, TotalHoursWorked FROM Employee ORDER BY E_ID;

--Timecard count
SELECT COUNT(*) FROM Timecard;

SHOW ERRORS TRIGGER MPMENNEL.UPDATEDHOURS;


