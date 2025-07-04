use studentcoursedb;

# Stored Procedure — Show enrollments of a student by ID
DELIMITER //

CREATE PROCEDURE GetStudentEnrollments(IN input_student_id INT)
BEGIN
    SELECT student.Name, course.CourseName, enrollment.EnrollDate
    FROM student
    JOIN enrollment ON student.StudentID = enrollment.StudentID
    JOIN course ON course.CourseID = enrollment.CourseID
    WHERE student.StudentID = input_student_id;
END //

DELIMITER ;

CALL GetStudentEnrollments(1);

# Function — Count how many courses a student is enrolled in
DELIMITER //

CREATE FUNCTION CountCoursesForStudent(input_student_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE course_count INT;

    SELECT COUNT(*) INTO course_count
    FROM enrollment
    WHERE StudentID = input_student_id;

    RETURN course_count;
END //

DELIMITER ;

SELECT Name, CountCoursesForStudent(StudentID) AS EnrolledCourses
FROM student;
