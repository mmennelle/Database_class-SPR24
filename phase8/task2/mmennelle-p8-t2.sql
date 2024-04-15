CREATE OR REPLACE PROCEDURE ReportCard(employee_id IN VARCHAR2) IS
    employee_name VARCHAR2(100);
    course_code VARCHAR2(20);
    course_title VARCHAR2(100);
    received_grade CHAR(100); -- had to set this to 100 because the table was created with 100byte space for this field.
    grade_points NUMBER;
    total_grade_points NUMBER := 0;
    course_counter NUMBER := 0;
    calculated_gpa FLOAT;

    CURSOR course_details_cursor IS
        SELECT c.c_id, c.c_name, e.enroll_grade
        FROM course c, enrollment e
        WHERE c.c_id = e.enroll_c_id
        AND e.enroll_e_id = employee_id;

BEGIN
    --DBMS_OUTPUT.ENABLE(buffer_size => NULL);    
    
    SELECT e_name INTO employee_name
    FROM employee
    WHERE e_id = employee_id;

    OPEN course_details_cursor;
    FETCH course_details_cursor INTO course_code, course_title, received_grade;
    received_grade := TRIM(received_grade);
    IF course_details_cursor%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('No report card to generate!');
        CLOSE course_details_cursor;
        RETURN;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Report Card for ' || employee_id || ': ' || employee_name);
        DBMS_OUTPUT.PUT_LINE(RPAD('CourseID', 12) || RPAD('Course Name', 50) || 'Grade');
        DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
    END IF;

    LOOP
        EXIT WHEN course_details_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(RPAD(course_code, 12) || RPAD(course_title, 50) || received_grade);
        grade_points := CASE received_grade
                            WHEN 'A' THEN 4
                            WHEN 'B' THEN 3
                            WHEN 'C' THEN 2
                            WHEN 'D' THEN 1
                            ELSE 0
                        END;
        total_grade_points := total_grade_points + grade_points;
        course_counter := course_counter + 1;
        FETCH course_details_cursor INTO course_code, course_title, received_grade;
    END LOOP;
    CLOSE course_details_cursor;


    IF course_counter > 0 THEN
        calculated_gpa := total_grade_points / course_counter;
        DBMS_OUTPUT.PUT_LINE('Total GPA:    ' || TO_CHAR(calculated_gpa, '0.00'));
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No report card to generate!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END ReportCard;

call ReportCard('E111');

call ReportCard('E003');

call ReportCard('E020');