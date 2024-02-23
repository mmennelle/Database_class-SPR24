DROP TABLE Address;
DROP TABLE Timecard;
DROP TABLE Enrollment;
DROP TABLE Employee;
DROP TABLE Requirement;
DROP TABLE Position2;
DROP TABLE Prerequisite;
DROP TABLE Course;


CREATE TABLE Position2(
    P_ID NUMBER,
    P_Name VARCHAR(255),
    P_Salary NUMBER,
    CONSTRAINT PK_Position PRIMARY KEY(P_ID)
);

CREATE TABLE Employee(
    E_ID NUMBER,
    E_Name VARCHAR(255),
    E_Dob DATE,
    PositionID NUMBER,
    CONSTRAINT PK_Employee PRIMARY KEY(E_ID),
    CONSTRAINT FK_Employee FOREIGN KEY(PositionID) REFERENCES Position2(P_ID)
);
CREATE TABLE Timecard(
    T_EmpID NUMBER,
    T_Date DATE,
    T_Hours NUMBER,
    CONSTRAINT TimecardPK PRIMARY KEY (T_EmpID,T_Date),
    CONSTRAINT TimecardFK FOREIGN KEY (T_EmpID) REFERENCES Employee(E_ID)
);

CREATE TABLE Address(
    A_E_ID NUMBER,
    A_E_Address VARCHAR(255),
    CONSTRAINT AddressPK PRIMARY KEY(A_E_ID,A_E_Address),
    CONSTRAINT AddressFK FOREIGN KEY(A_E_ID) REFERENCES Employee(E_ID)    
);

CREATE TABLE Course(
    C_ID NUMBER,
    C_Name VARCHAR(255),
    CONSTRAINT CoursePK PRIMARY KEY(C_ID)
);

CREATE TABLE Enrollment(
    Enroll_E_ID NUMBER,
    Enroll_C_ID NUMBER,
    Enroll_Grade CHAR(1),
    CONSTRAINT EnrollPK PRIMARY KEY(Enroll_E_ID,Enroll_C_ID),
    CONSTRAINT EnrollFK FOREIGN KEY(Enroll_E_ID) REFERENCES Employee(E_ID),
    CONSTRAINT Enroll2FK FOREIGN KEY(Enroll_C_ID) REFERENCES Course(C_ID)
);

CREATE TABLE Requirement(
    Req_C_ID NUMBER,
    Req_P_ID NUMBER,
    CONSTRAINT RequirementPK PRIMARY KEY(Req_C_ID, Req_P_ID),
    CONSTRAINT RequirementFK FOREIGN KEY(Req_C_ID) REFERENCES Course(C_ID),
    CONSTRAINT Requirement2FK FOREIGN KEY(Req_P_ID) REFERENCES Position2(P_ID)
);

CREATE TABLE Prerequisite(
    Pre_C_ID NUMBER,
    Pre_ID NUMBER,
    CONSTRAINT PrerequisitePK PRIMARY KEY(Pre_C_ID,Pre_ID),
    CONSTRAINT PrerequisiteFK FOREIGN KEY(Pre_C_ID) REFERENCES Course(C_ID),
    CONSTRAINT Prerequisite2FK FOREIGN KEY(Pre_ID) REFERENCES Course(C_ID) 
); 














