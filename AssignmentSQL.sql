/* I. CREATE TABLES */

-- faculty (Khoa trong trường)
create table faculty (
	id number primary key,
	name nvarchar2(30) not null
);

-- subject (Môn học)
create table subject(
	id number primary key,
	name nvarchar2(100) not null,
	lesson_quantity number(2,0) not null -- tổng số tiết học
);

-- student (Sinh viên)
create table student (
	id number primary key,
	name nvarchar2(30) not null,
	gender nvarchar2(10) not null, -- giới tính
	birthday date not null,
	hometown nvarchar2(100) not null, -- quê quán
	scholarship number, -- học bổng
	faculty_id number not null constraint faculty_id references faculty(id) -- mã khoa
);

-- exam management (Bảng điểm)
create table exam_management(
	id number primary key,
	student_id number not null constraint student_id references student(id),
	subject_id number not null constraint subject_id references subject(id),
	number_of_exam_taking number not null, -- số lần thi (thi trên 1 lần được gọi là thi lại) 
	mark number(4,2) not null -- điểm
);



/*================================================*/

/* II. INSERT SAMPLE DATA */

-- subject
insert into subject (id, name, lesson_quantity) values (1, n'Cơ sở dữ liệu', 45);
insert into subject values (2, n'Trí tuệ nhân tạo', 45);
insert into subject values (3, n'Truyền tin', 45);
insert into subject values (4, n'Đồ họa', 60);
insert into subject values (5, n'Văn phạm', 45);


-- faculty
insert into faculty values (1, n'Anh - Văn');
insert into faculty values (2, n'Tin học');
insert into faculty values (3, n'Triết học');
insert into faculty values (4, n'Vật lý');


-- student
insert into student values (1, n'Nguyễn Thị Hải', n'Nữ', to_date('19900223', 'YYYYMMDD'), 'Hà Nội', 130000, 2);
insert into student values (2, n'Trần Văn Chính', n'Nam', to_date('19921224', 'YYYYMMDD'), 'Bình Định', 150000, 4);
insert into student values (3, n'Lê Thu Yến', n'Nữ', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 150000, 2);
insert into student values (4, n'Lê Hải Yến', n'Nữ', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 170000, 2);
insert into student values (5, n'Trần Anh Tuấn', n'Nam', to_date('19901220', 'YYYYMMDD'), 'Hà Nội', 180000, 1);
insert into student values (6, n'Trần Thanh Mai', n'Nữ', to_date('19910812', 'YYYYMMDD'), 'Hải Phòng', null, 3);
insert into student values (7, n'Trần Thị Thu Thủy', n'Nữ', to_date('19910102', 'YYYYMMDD'), 'Hải Phòng', 10000, 1);


-- exam_management
insert into exam_management values (1, 1, 1, 1, 3);
insert into exam_management values (2, 1, 1, 2, 6);
insert into exam_management values (3, 1, 2, 2, 6);
insert into exam_management values (4, 1, 3, 1, 5);
insert into exam_management values (5, 2, 1, 1, 4.5);
insert into exam_management values (6, 2, 1, 2, 7);
insert into exam_management values (7, 2, 3, 1, 10);
insert into exam_management values (8, 2, 5, 1, 9);
insert into exam_management values (9, 3, 1, 1, 2);
insert into exam_management values (10, 3, 1, 2, 5);
insert into exam_management values (11, 3, 3, 1, 2.5);
insert into exam_management values (12, 3, 3, 2, 4);
insert into exam_management values (13, 4, 5, 2, 10);
insert into exam_management values (14, 5, 1, 1, 7);
insert into exam_management values (15, 5, 3, 1, 2.5);
insert into exam_management values (16, 5, 3, 2, 5);
insert into exam_management values (17, 6, 2, 1, 6);
insert into exam_management values (18, 6, 4, 1, 10);



/*================================================*/

/* III. QUERY */


 /********* A. BASIC QUERY *********/

-- 1. Liệt kê danh sách sinh viên sắp xếp theo thứ tự:
--      a. id tăng dần
--      b. giới tính
--      c. ngày sinh TĂNG DẦN và học bổng GIẢM DẦN

--cau a
select * from student
order by id asc;

--cau b
select * from student
order by gender asc;

--cau c

select * from student
order by birthday asc, scholarship desc;

-- 2. Môn học có tên bắt đầu bằng chữ 'T'

select name from subject
where name like 'T%';

-- 3. Sinh viên có chữ cái cuối cùng trong tên là 'i'

select name from student
where name like '%i';

-- 4. Những khoa có ký tự thứ hai của tên khoa có chứa chữ 'n'

select name from faculty
where name like '_n%';

-- 5. Sinh viên trong tên có từ 'Thị'

select name from student
where name like '%Thị%';

-- 6. Sinh viên có ký tự đầu tiên của tên nằm trong khoảng từ 'a' đến 'm', sắp xếp theo họ tên sinh viên
select name from student
where name between 'A' and 'M'
order by name asc;

-- 7. Sinh viên có học bổng lớn hơn 100000, sắp xếp theo mã khoa giảm dần

select * from student
where scholarship > 100000
order by faculty_id desc;

-- 8. Sinh viên có học bổng từ 150000 trở lên và sinh ở Hà Nội

select * from student
where scholarship >= 150000 and hometown = 'Hà Nội';

-- 9. Những sinh viên có ngày sinh từ ngày 01/01/1991 đến ngày 05/06/1992
select * from student
WHERE birthday BETWEEN TO_DATE ('01/01/1991', 'dd/mm/yyyy')
AND TO_DATE ('05/06/1992', 'dd/mm/yyyy');

-- 10. Những sinh viên có học bổng từ 80000 đến 150000

select * from student
where scholarship >= 80000 and scholarship <= 150000;

-- 11. Những môn học có số tiết lớn hơn 30 và nhỏ hơn 45


select * from subject
where lesson_quantity > 30 and lesson_quantity < 45;

---------------------------------------------------

/********* B. CALCULATION QUERY *********/

-- 1. Cho biết thông tin về mức học bổng của các sinh viên, gồm: Mã sinh viên, Giới tính, Mã 
		-- khoa, Mức học bổng. Trong đó, mức học bổng sẽ hiển thị là “Học bổng cao” nếu giá trị 
		-- của học bổng lớn hơn 500,000 và ngược lại hiển thị là “Mức trung bình”.
		
        
 select id as "Mã sinh viên",gender as "Gioi tinh", faculty_id as "Mã khoa",
        case 
        when scholarship > 500000 then 'Học bổng cao' 
        else 'Mức trung bình' 
        end as "Mức học bổng"
from student;
        
        
-- 2. Tính tổng số sinh viên của toàn trường

select count(id) as "Tổng số sinh viên" from student;

-- 3. Tính tổng số sinh viên nam và tổng số sinh viên nữ..

select
  count(case when gender='Nam' then 1 end) as "Tổng số sinh viên nam",
  count(case when gender='Nữ' then 1 end) as "Tổng số sinh viên nữ"
from student;


-- 4. Tính tổng số sinh viên từng khoa

select student.faculty_id, count(student.id) as "Tổng số sinh viên"
from student
group by student.faculty_id;

-- 5. Tính tổng số sinh viên của từng môn học

select subject.name as "Tên môn học", count( distinct exam_management.student_id) as "Số lượng sinh viên"
from exam_management,subject
where exam_management.subject_id = subject.id
group by subject.name;


-- 6. Tính số lượng môn học mà sinh viên đã học

select count(distinct exam_management.subject_id) as "Số lượng môn học"
from exam_management;

-- 7. Tổng số học bổng của mỗi khoa	

select student.faculty_id, sum(scholarship) as "Tổng số học bổng"
from student
group by student.faculty_id;

-- 8. Cho biết học bổng cao nhất của mỗi khoa

select student.faculty_id, max(scholarship) as "Học bổng cao nhất"
from student
group by student.faculty_id;

-- 9. Cho biết tổng số sinh viên nam và tổng số sinh viên nữ của mỗi khoa

select student.faculty_id, sum(case gender when N'Nam' then 1 else 0 end) as "Tổng sinh viên nam",
sum(case gender when N'Nữ' then 1 else 0 end) as "Tổng sinh viên nữ"
from student
group by student.faculty_id;


-- 10. Cho biết số lượng sinh viên theo từng độ tuổi

select EXTRACT(YEAR from CURRENT_TIMESTAMP)-EXTRACT(YEAR from birthday) as "Độ tuổi",count(id) as "Số sinh viên"
from student
group by EXTRACT(YEAR from CURRENT_TIMESTAMP)-EXTRACT(YEAR from birthday);

-- 11. Cho biết những nơi nào có ít nhất 2 sinh viên đang theo học tại trường

select hometown, count (student.id) as "Sô lượng sinh viên"
from student
group by hometown
having count (student.id) >= 2;


-- 12. Cho biết những sinh viên thi lại ít nhất 2 lần

select student.name, count(exam_management.number_of_exam_taking) as "Số lần thi"
from exam_management,student
where exam_management.student_id = student.id
group by student.name
having count (exam_management.number_of_exam_taking) >= 2 ;

-- 13. Cho biết những sinh viên nam có điểm trung bình lần 1 trên 7.0 

select student.name, student.gender, exam_management.number_of_exam_taking as "Số lần thi", avg(exam_management.mark) as "Điểm trung bình"
from exam_management,student
where exam_management.student_id = student.id and exam_management.number_of_exam_taking = 1 and student.gender = N'Nam'
group by student.name, exam_management.number_of_exam_taking, student.gender
having avg(exam_management.mark) > 7;

-- 14. Cho biết danh sách các sinh viên rớt ít nhất 2 môn ở lần thi 1 (rớt môn là điểm thi của môn không quá 4 điểm)

select exam_management.student_id , count(exam_management.subject_id) as "Số môn rớt"
from exam_management
where exam_management.number_of_exam_taking = 1 and exam_management.mark < 4
group by exam_management.student_id
having count(exam_management.subject_id)  >= 2;

-- 15. Cho biết danh sách những khoa có nhiều hơn 2 sinh viên nam

select student.faculty_id, count(student.id) as "Số sinh viên nam"
from student
where student.gender = N'Nam'
group by student.faculty_id
having count(student.id) > 2;

-- 16. Cho biết những khoa có 2 sinh viên đạt học bổng từ 200000 đến 300000

select student.faculty_id, count(student.id) as "Số sinh viên"
from student
where student.scholarship between 200000 and 300000
group by student.faculty_id
having count(student.id) > 2;

-- 17. Cho biết sinh viên nào có học bổng cao nhất

select * from student
where  scholarship = (select max(scholarship) from student);
-------------------------------------------------------------------

/********* C. DATE/TIME QUERY *********/

-- 1. Sinh viên có nơi sinh ở Hà Nội và sinh vào tháng 02

select * from student
where hometown = 'Hà Nội' and extract(month from birthday) = 2;

-- 2. Sinh viên có tuổi lớn hơn 20

select * from student
where
TRUNC(months_between(sysdate, STUDENT.BIRTHDAY ) / 12,8) > 20;

-- 3. Sinh viên sinh vào mùa xuân năm 1990

SELECT * FROM student WHERE (EXTRACT(MONTH FROM Birthday) in(1,2,3)) and EXTRACT(year FROM Birthday)=1990;



-------------------------------------------------------------------



/********* D. JOIN QUERY *********/

-- 1. Danh sách các sinh viên của khoa ANH VĂN và khoa VẬT LÝ

select faculty.name as "Tên Khoa", student.name as "Tên Sinh Viên"
from student left join faculty on student.faculty_id = faculty.id
where faculty.name like N'Anh - Văn' or  faculty.name like N'Vật lý'
group by faculty.name, student.name;

-- 2. Những sinh viên nam của khoa ANH VĂN và khoa TIN HỌC

select faculty.name as "Tên Khoa", student.name as "Tên Sinh Viên", student.gender
from student left join faculty on student.faculty_id = faculty.id
where (faculty.name = N'Anh - Văn' or  faculty.name = N'Tin học') and student.gender = N'Nam'
group by student.name, faculty.name,student.gender;

-- 3. Cho biết sinh viên nào có điểm thi lần 1 môn cơ sở dữ liệu cao nhất

select * from (select * from student inner join exam_management on student.id = exam_management.student_id
inner join subject on exam_management.subject_id = subject_id
where exam_management.number_of_exam_taking = '1' and subject.name = 'Cơ sở dữ liệu'
order by exam_management.mark desc)
where rownum = 1;


-- 4. Cho biết sinh viên khoa anh văn có tuổi lớn nhất.

SELECT * FROM(SELECT ID, NAME,BIRTHDAY,FACULTY_ID,(TRUNC(months_between(sysdate, STUDENT.BIRTHDAY ) / 12,8)) AS "TUOI"
FROM STUDENT
WHERE student.faculty_id=1
ORDER BY TUOI DESC)
WHERE ROWNUM=1;


-- 5. Cho biết khoa nào có đông sinh viên nhất

select name from (select faculty.name , student.faculty_id ,count (*) as "Tổng số sinh viên"
from faculty join student on faculty.id = student.faculty_id
group by faculty.name, student.faculty_id
order by "Tổng số sinh viên" desc)
where rownum <= 1;

-- 6. Cho biết khoa nào có đông nữ nhất

select name from (select faculty.name , student.faculty_id ,count (*) as "Tổng số sinh viên"
from faculty join student on faculty.id = student.faculty_id
where student.gender like N'Nữ'
group by faculty.name, student.faculty_id
order by "Tổng số sinh viên" desc)
where rownum <= 1;


-- 7. Cho biết những sinh viên đạt điểm cao nhất trong từng môn

select EXAM_MANAGEMENT.STUDENT_ID,EXAM_MANAGEMENT.SUBJECT_ID,MARK
from EXAM_MANAGEMENT,(select SUBJECT_ID, max(MARK) as maxdiem
    from EXAM_MANAGEMENT
    group by SUBJECT_ID)a
where EXAM_MANAGEMENT.SUBJECT_ID=a.SUBJECT_ID and MARK=a.maxdiem;

 
-- 8. Cho biết những khoa không có sinh viên học
select * from faculty
where not exists (select distinct faculty.id
from exam_management,student where exam_management.student_id=student.id and faculty.id=faculty.id);

-- 9. Cho biết sinh viên chưa thi môn cơ sở dữ liệu

select * from student
where not exists
(select distinct*
from exam_management
where subject_id like '1' and exam_management.student_id=student.id);


-- 10. Cho biết sinh viên nào không thi lần 1 mà có dự thi lần 2

select student_id,student.name
from exam_management ex
inner join student
on student_id = student.id 
where number_of_exam_taking=2 and not exists
(select *
from exam_management
where number_of_exam_taking=1 and student_id=ex.student_id);
