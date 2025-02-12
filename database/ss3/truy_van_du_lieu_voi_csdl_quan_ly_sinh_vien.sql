use m3_c0924l1_jv103;
-- Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
SELECT 
    *
FROM
    student
WHERE
    name LIKE '% % h%';
-- Hiển thị lớp học có thời gian bắt đầu vào tháng 12
SELECT 
    *
FROM
    student
        JOIN
    class ON student.class_id = class.id
WHERE
    class.start_date LIKE '%-12-%';
-- Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5
SELECT 
    *
FROM
    subject
WHERE
    credit BETWEEN 3 AND 5;
-- Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2
UPDATE student 
SET 
    class_id = 2
WHERE
    name LIKE '% hieu';
-- Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
SELECT 
    name, sub_name, point
FROM
    student
ORDER BY point DESC , name ASC;