SHOW DATABASES;
DROP DATABASE SIS;
DROP DATABASE sys;
SHOW DATABASES;

-- Create and use the database
CREATE DATABASE SIS;
USE SIS;

-- Create Students table
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15)
);
DESC Students;

-- Create Teacher table FIRST before using it as a foreign key
CREATE TABLE Teacher (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);
DESC Teacher;

-- Now create Courses, which references Teacher
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);
DESC Courses;

-- Create Enrollments
CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
DESC Enrollments;

-- Create Payments
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    amount DECIMAL(10, 2),
    payment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);
DESC Payments;

-- View all tables
SHOW TABLES;

INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number) VALUES
('Alice', 'Johnson', '2002-05-14', 'alice.johnson@example.com', '9876543210'),
('Bob', 'Smith', '2001-11-23', 'bob.smith@example.com', '9876543211'),
('Carol', 'Taylor', '2003-02-09', 'carol.taylor@example.com', '9876543212'),
('David', 'Lee', '2000-07-18', 'david.lee@example.com', '9876543213'),
('Eva', 'Brown', '2002-03-22', 'eva.brown@example.com', '9876543214'),
('Frank', 'Wilson', '2001-09-10', 'frank.wilson@example.com', '9876543215'),
('Grace', 'Moore', '2003-12-01', 'grace.moore@example.com', '9876543216'),
('Henry', 'Davis', '2000-01-25', 'henry.davis@example.com', '9876543217'),
('Ivy', 'Clark', '2002-08-05', 'ivy.clark@example.com', '9876543218'),
('Jake', 'Miller', '2001-04-17', 'jake.miller@example.com', '9876543219');
SELECT * FROM Students;

INSERT INTO Teacher (first_name, last_name, email) VALUES
('Laura', 'Adams', 'laura.adams@example.com'),
('Brian', 'White', 'brian.white@example.com'),
('Nina', 'Green', 'nina.green@example.com'),
('Tom', 'Baker', 'tom.baker@example.com'),
('Sara', 'Hall', 'sara.hall@example.com'),
('James', 'Wright', 'james.wright@example.com'),
('Olivia', 'King', 'olivia.king@example.com'),
('Paul', 'Turner', 'paul.turner@example.com'),
('Diana', 'Parker', 'diana.parker@example.com'),
('Mike', 'Lewis', 'mike.lewis@example.com');
SELECT * FROM teacher;

INSERT INTO Courses (course_name, credits, teacher_id) VALUES
('Mathematics', 4, 1),
('Physics', 3, 2),
('Chemistry', 4, 3),
('English', 2, 4),
('Computer Science', 5, 5),
('Biology', 4, 6),
('History', 3, 7),
('Geography', 3, 8),
('Economics', 3, 9),
('Statistics', 4, 10);
Select * From courses;

INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-06-01'),
(2, 2, '2024-06-02'),
(3, 3, '2024-06-03'),
(4, 4, '2024-06-04'),
(5, 5, '2024-06-05'),
(6, 6, '2024-06-06'),
(7, 7, '2024-06-07'),
(8, 8, '2024-06-08'),
(9, 9, '2024-06-09'),
(10, 10, '2024-06-10');
Select * From enrollments;

INSERT INTO Payments (student_id, amount, payment_date) VALUES
(1, 5000.00, '2024-06-01'),
(2, 4500.00, '2024-06-02'),
(3, 4800.00, '2024-06-03'),
(4, 4700.00, '2024-06-04'),
(5, 5200.00, '2024-06-05'),
(6, 4600.00, '2024-06-06'),
(7, 5100.00, '2024-06-07'),
(8, 5000.00, '2024-06-08'),
(9, 4900.00, '2024-06-09'),
(10, 5300.00, '2024-06-10');

-- TASK 2-- 
USE SIS;
INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number)
VALUES ('John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890');

INSERT INTO Enrollments (student_id, course_id, enrollment_date)
VALUES (1, 2, CURDATE());

UPDATE Teacher
SET email = 'new.email@example.com'
WHERE teacher_id = 1;

DELETE FROM Enrollments
WHERE student_id = 1 AND course_id = 1;

UPDATE Courses
SET teacher_id = 3
WHERE course_id = 2;

DELETE FROM Enrollments WHERE student_id = 1;
DELETE FROM Students WHERE student_id = 1;

UPDATE Payments
SET amount = 5000
WHERE payment_id = 2;

-- TASK 3--
USE SIS;
-- Before Check:-- 
SELECT * FROM Payments;
SELECT * FROM Students;
SELECT * FROM Students WHERE student_id = 1;
-- QUERY--  
SELECT s.first_name, s.last_name, SUM(p.amount) AS total_payment
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
WHERE s.student_id = 1
GROUP BY s.student_id;

-- Before Check:-- 
SELECT * FROM Courses;
SELECT * FROM Enrollments;
-- QUERY--  
SELECT c.course_name, COUNT(e.enrollment_id) AS student_count
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

-- Before Check:-- 
SELECT * FROM Students;
SELECT * FROM Enrollments;
SELECT * FROM Enrollments WHERE enrollment_id IS NULL;

SELECT s.student_id, s.first_name, s.last_name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id
HAVING COUNT(e.enrollment_id) = 0;

-- See students with no enrollments directly
SELECT s.student_id, s.first_name, s.last_name
FROM Students s
WHERE s.student_id NOT IN (
  SELECT DISTINCT student_id FROM Enrollments
);
-- QUERY--  
SELECT s.first_name, s.last_name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

-- Before Check:-- 
SELECT * FROM Students;
SELECT * FROM Enrollments;
SELECT * FROM Courses;
-- QUERY--  
SELECT s.first_name, s.last_name, c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

-- Before Check:-- 
SELECT * FROM Teacher;
SELECT * FROM Courses;
-- QUERY--  
SELECT t.first_name, t.last_name, c.course_name
FROM Teacher t
JOIN Courses c ON t.teacher_id = c.teacher_id;

-- Before Check:-- 
SELECT * FROM Students;
SELECT * FROM Enrollments;
SELECT * FROM Courses WHERE course_id = 2;
-- QUERY-- 
SELECT s.first_name, s.last_name, e.enrollment_date
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_id = 2;

-- Before Check:-- 
SELECT * FROM Students;
SELECT * FROM Payments;
-- QUERY-- 
SELECT s.first_name, s.last_name
FROM Students s
LEFT JOIN Payments p ON s.student_id = p.student_id
WHERE p.payment_id IS NULL;

-- Before Check:-- 
SELECT * FROM Courses;
SELECT * FROM Enrollments;
-- QUERY--
SELECT c.course_name
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;


-- Before Check:-- 
SELECT * FROM Enrollments;
-- QUERY--
SELECT s.student_id, s.first_name, s.last_name, COUNT(e.enrollment_id) AS course_count
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id
HAVING COUNT(e.enrollment_id) > 1;


-- Before Check:-- 
SELECT * FROM Teacher;
SELECT * FROM Courses;
-- QUERY--
SELECT t.first_name, t.last_name
FROM Teacher t
LEFT JOIN Courses c ON t.teacher_id = c.teacher_id
WHERE c.course_id IS NULL;

-- TASK 4:-- 
USE SIS;
-- Before Check:--
SELECT course_id, COUNT(*) AS total_enrolled
FROM Enrollments
GROUP BY course_id;
-- QUERY--
SELECT AVG(student_count) AS avg_enrollment_per_course
FROM (
    SELECT COUNT(*) AS student_count
    FROM Enrollments
    GROUP BY course_id
) AS sub;


-- Before Check:--
SELECT * FROM Payments ORDER BY amount DESC;
-- QUERY--
SELECT s.first_name, s.last_name, p.amount
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
WHERE p.amount = (
    SELECT MAX(amount) FROM Payments
);


-- Before Check:--
SELECT course_id, COUNT(*) AS enrollments FROM Enrollments GROUP BY course_id;
-- QUERY--
SELECT c.course_name, COUNT(e.enrollment_id) AS total_enrollments
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id
HAVING COUNT(e.enrollment_id) = (
    SELECT MAX(course_count)
    FROM (
        SELECT COUNT(*) AS course_count
        FROM Enrollments
        GROUP BY course_id
    ) AS sub
);


-- Before Check:--
SELECT * FROM Courses;
SELECT * FROM Payments;
-- QUERY--
SELECT t.first_name, t.last_name, SUM(p.amount) AS total_payment
FROM Teacher t
JOIN Courses c ON t.teacher_id = c.teacher_id
JOIN Enrollments e ON c.course_id = e.course_id
JOIN Payments p ON e.student_id = p.student_id
GROUP BY t.teacher_id;


-- Before Check:--
SELECT COUNT(*) FROM Courses;
-- QUERY--
SELECT student_id
FROM Enrollments
GROUP BY student_id
HAVING COUNT(DISTINCT course_id) = (
    SELECT COUNT(*) FROM Courses
);


-- Before Check:--
SELECT DISTINCT teacher_id FROM Courses;
-- QUERY--
SELECT teacher_id, first_name, last_name
FROM Teacher
WHERE teacher_id NOT IN (
    SELECT DISTINCT teacher_id FROM Courses
    WHERE teacher_id IS NOT NULL
);


-- Before Check:--
SELECT student_id, date_of_birth FROM Students;
-- QUERY--
SELECT AVG(age) AS avg_age
FROM (
    SELECT TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) AS age
    FROM Students
) AS sub;


-- Before Check:--
SELECT DISTINCT course_id FROM Enrollments;
-- QUERY--
SELECT course_id, course_name
FROM Courses
WHERE course_id NOT IN (
    SELECT DISTINCT course_id FROM Enrollments
);


-- Before Check:--
SELECT * FROM Enrollments;
SELECT * FROM Payments;
-- QUERY--
SELECT e.student_id, e.course_id, SUM(p.amount) AS total_payment
FROM Enrollments e
JOIN Payments p ON e.student_id = p.student_id
GROUP BY e.student_id, e.course_id;


-- Before Check:--
SELECT student_id, COUNT(*) FROM Payments GROUP BY student_id;
-- QUERY--
SELECT student_id, COUNT(*) AS payment_count
FROM Payments
GROUP BY student_id
HAVING COUNT(*) > 1;

-- QUERY--
SELECT s.student_id, s.first_name, s.last_name, SUM(p.amount) AS total_payment
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.student_id;

-- QUERY--
SELECT c.course_name, COUNT(e.student_id) AS enrollment_count
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id;

-- QUERY--
SELECT s.student_id, s.first_name, s.last_name, AVG(p.amount) AS avg_payment
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.student_id;







































