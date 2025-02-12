select * 
from student 
	join class on student.class_id = class.id;
select * 
from student 
	left join class on student.class_id = class.id;
select *
from student
where name ='nguyen minh hai';
select *
from student
where name like 'nguyen %';
select * 
from student 
where name like '% hai'
	or name like '% huynh';
select * 
from student 
where point > 5;
select * 
from student 
where point in (4,6,8);
select point, count(point) 
from student 
group by point;
select point, count(point) 
from student 
group by point 
having point > 5;
select point, count(point) 
from student 
group by point 
having point > 5 
	and count(point) >= 2;
select * 
from student 
	join class on student.class_id = class.id
where class.name = 'c1121g1'
order by point desc;


