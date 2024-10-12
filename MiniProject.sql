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




--Created By Raju And Vaishnavi-
SELECT * FROM Enrollments;