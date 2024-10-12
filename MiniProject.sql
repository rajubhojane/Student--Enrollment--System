CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR2(50) NOT NULL,
    Email VARCHAR2(50) NOT NULL UNIQUE,
    Phone VARCHAR2(15),
    DOB DATE,
    YearOfJoining INT  
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR2(100) NOT NULL,
    Credits INT,
    Instructor VARCHAR2(50)
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    JoiningDate DATE,  -- Add JoiningDate column here
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

UPDATE Students
SET YearOfJoining = EXTRACT(YEAR FROM SYSDATE);

INSERT INTO Students (StudentID, Name, Email, Phone, DOB, YearOfJoining) VALUES (6, 'Vaishnavi', 'vaishnavi@example.com', '6666666666', TO_DATE('2001-07-20', 'YYYY-MM-DD'), EXTRACT(YEAR FROM SYSDATE));
INSERT INTO Students (StudentID, Name, Email, Phone, DOB, YearOfJoining) VALUES (5, 'Raju', 'raju@example.com', '5555555555', TO_DATE('2000-05-10', 'YYYY-MM-DD'), EXTRACT(YEAR FROM SYSDATE));
INSERT INTO Students (StudentID, Name, Email, Phone, DOB, YearOfJoining) VALUES (7, 'Dnyaneshwari', 'dnyaneshwari@example.com', '7777777777', TO_DATE('2002-09-15', 'YYYY-MM-DD'), EXTRACT(YEAR FROM SYSDATE));
INSERT INTO Students (StudentID, Name, Email, Phone, DOB, YearOfJoining) VALUES (8, 'Divya', 'divya@example.com', '8888888888', TO_DATE('2003-11-30', 'YYYY-MM-DD'), EXTRACT(YEAR FROM SYSDATE));


SELECT * FROM Students
ORDER BY StudentID ASC;

CREATE TABLE StudentCourses (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);


//INSERT INTO Courses (CourseID, CourseName, Credits, Instructor) VALUES (101, 'Database Systems', 3, 'Dr. Smith');
//INSERT INTO Courses (CourseID, CourseName, Credits, Instructor) VALUES (102, 'Operating Systems', 4, 'Prof. Johnson');
INSERT INTO Courses (CourseID, CourseName, Credits, Instructor) VALUES (103, 'Operating Systems', 5, 'Prof. Johnson');
INSERT INTO Courses (CourseID, CourseName, Credits, Instructor) VALUES (104, 'DSA', 6, 'Dr. Smith');
DELETE FROM Courses WHERE CourseID = 102;




//desc StudentCourses;
//select * from Courses;

INSERT INTO StudentCourses (StudentID, CourseID) VALUES (5, 103);
INSERT INTO StudentCourses (StudentID, CourseID) VALUES (6, 104);
INSERT INTO StudentCourses (StudentID, CourseID) VALUES (6, 103);
INSERT INTO StudentCourses (StudentID, CourseID) VALUES (7, 101);
INSERT INTO StudentCourses (StudentID, CourseID) VALUES (7, 103);







select * from StudentCourses;
select * from Courses;
select * from Students;

SELECT 
    s.StudentID,
    s.Name AS StudentName, 
    c.CourseID,
    c.CourseName AS CourseName
FROM 
    StudentCourses sc
JOIN 
    Students s ON sc.StudentID = s.StudentID
JOIN 
    Courses c ON sc.CourseID = c.CourseID;

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, JoiningDate) VALUES (1, 5, 101, SYSDATE);
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, JoiningDate) VALUES (2, 5, 103, SYSDATE);
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, JoiningDate) VALUES (3, 6, 103, SYSDATE);
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, JoiningDate) VALUES (4, 6, 104, SYSDATE);
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, JoiningDate) VALUES (5, 7, 101, SYSDATE);
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, JoiningDate) VALUES (6, 7, 103, SYSDATE);





SELECT * FROM Enrollments;


--View Concept

CREATE VIEW StudentEnrollments AS
SELECT 
    s.StudentID,
    s.Name AS StudentName, 
    c.CourseName AS CourseName,
    e.JoiningDate
FROM 
    Enrollments e
JOIN 
    Students s ON e.StudentID = s.StudentID
JOIN 
    Courses c ON e.CourseID = c.CourseID;
    
    
UPDATE StudentEnrollments
SET CourseName = 'Advanced DSA'
WHERE StudentName = 'Vaishnavi' AND CourseName = 'DSA';

SELECT * FROM StudentEnrollments;

--Index Concept

CREATE INDEX idx_student_name ON Students(Name);

SELECT *
FROM Students
WHERE Name = 'Vaishnavi';


SELECT *
FROM Students
ORDER BY Name;

--Trigger Added
CREATE OR REPLACE TRIGGER trg_set_year_of_joining
BEFORE INSERT ON Students
FOR EACH ROW
BEGIN
  :NEW.YearOfJoining := EXTRACT(YEAR FROM SYSDATE);
END;
/

INSERT INTO Students (StudentID, Name, Email, Phone, DOB)VALUES (9, 'Kamini', 'Kamini@example.com', '9999999999', TO_DATE('2000-02-15', 'YYYY-MM-DD'));

select * from Students;


--Cursor Concept Added
UPDATE Students SET YearOfJoining = EXTRACT(YEAR FROM SYSDATE);
DECLARE
    CURSOR cur_students IS
        SELECT StudentID FROM Students;  -- Declare a cursor to fetch StudentID
    v_student_id Students.StudentID%TYPE;  -- Variable to hold the StudentID
BEGIN
    OPEN cur_students;  -- Open the cursor
    LOOP
        FETCH cur_students INTO v_student_id;  -- Fetch the next StudentID
        EXIT WHEN cur_students%NOTFOUND;  -- Exit loop when no more rows are found

        -- Process each student ID: print it to the output
        DBMS_OUTPUT.PUT_LINE('Student ID: ' || v_student_id);  -- Output the StudentID
    END LOOP;
    CLOSE cur_students;  -- Close the cursor
END;
/


SET SERVEROUTPUT ON;



