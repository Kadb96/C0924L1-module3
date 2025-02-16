use m3_c0924l1_jv103;

-- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.

SELECT 
    *
FROM
    subject
WHERE
    credit = (SELECT 
            MAX(credit)
        FROM
            subject);

-- Hiển thị các thông tin môn học có điểm thi lớn nhất.

SELECT 
    c.name
FROM
    student s
        JOIN
    class c ON s.class_id = c.id
WHERE
    s.point = (SELECT 
            MAX(point)
        FROM
            student);

-- Hiển thị các thông tin sinh viên (em thay bằng lớp vì mỗi sinh viên chỉ có 1 điểm) và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần

SELECT 
    c.name, AVG(point) average_point
FROM
    student s
        JOIN
    class c ON s.class_id = c.id
GROUP BY c.name
ORDER BY average_point DESC;