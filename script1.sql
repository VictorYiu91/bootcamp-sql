create database bootcamp2508;

use bootcamp2508;

-- SQL command is case-insensitive
create table persons (
id bigint,
pname varchar(20),
age int
);

-- * means all colums
select * from persons;
-- Put data int table
insert into persons (id, pname, age) values (1, 'John', 23);
insert into persons (id, pname, age) values (2, 'Peter', 18);
insert into persons (id, pname, age) values (3, 'Lucas', 44);

-- Peter's age -> 40;
-- For update statement, execute the update ONLY when the conditions fulfills.
update persons set age = 40 where pname = 'Peter';
-- update two colums
update persons set age = 80, pname = 'Peter Wong' where pname = 'Peter';
-- query lanaguage
select age, pname from persons;
-- where (conditional)
select age, pname from persons where pname = 'John';
select id, pname from persons where age > 20;
select * from persons where age < 31 or age > 60;
select * from persons where (age < 31 or age > 60) and (pname = 'Leo' or pname = 'Sally');

-- another style of insert
-- skip column name -> default natural order
insert into persons values (4, 'Sally', 30);
-- insert more than one entry
insert into persons values (5, 'Leo', 3), (6, 'Jennie', 18);

-- alter (add column)
alter table persons add gender varchar(1);
update persons set gender = 'M' where id in (1,2,3,5); -- where parameter in (OR event) 
update persons set gender = 'F' where pname = 'Sally' or pname = 'Jennie';
-- delete all data
delete from persons where age > 40;

insert into persons (id, pname) values (10, 'Kelly');
insert into persons values (11, 'David', null, null);

select * from persons;

alter table persons add DoB date;
update persons set DoB = '2022-10-3' where pname = 'Leo'; -- default string format 'YYYY-MM-DD' for date in MySQL
update persons set DoB = str_to_date('2022-11-13', '%Y-%m-%d') where pname = 'John';

select * from persons where DoB > '2022-10-31';

-- select null condition (is / is not)
select * from persons where gender is null;
select * from persons where gender is not null;
select * from persons where gender is not null and DoB is not null;

-- decimal place -> decimal / numeric
alter table persons add weight numeric(3,2); -- total 3 digits length included 2 decimal places
alter table persons modify weight numeric(5,2);
update persons set weight = 70.1 where pname = 'John';
update persons set weight = 59.4 where pname = 'Kelly';
update persons set weight = 62.9 where pname = 'Jennie';

update persons set weight = 999.99 where pname = 'Jennie'; -- OK
update persons set weight = -999.99 where pname = 'Jennie'; -- OK

alter table persons add height numeric(5,2);
update persons set height = 150.3 where pname = 'John';
update persons set height = 180.5 where pname = 'Kelly';
update persons set height = 173.4 where pname = 'Jennie';

-- Custom Column
-- power(), round(), ifnull()
select id
, pname as Person_Name
, age
, weight
, height
, 'hello'
, ifnull(round(weight / power(height/100, 2), 2), 'NA') as BMI 
from persons
where age is not null;

-- SQL support remainder by %
select age % 10 from persons;

-- Not equals to
select *
from persons
where gender <> 'F';

-- Between by default inclusive and ignore null cases
-- is for date format only
select *
from persons
where DoB between '2022-10-03' and '2022-11-12';

-- String functions
-- select pname + '!!!!' from persons;
-- String does not support + operation
select concat(pname, '!!!!') as new_name
, pname
, age
from persons;

-- substring
-- Database index starts from 1
-- substring(pname,1,1)
-- first '1' -> first char
-- second '1' -> the number of characters you need
select substring(pname,1,1) as first_char_name
from persons;

-- Find the persons who has the name start with J
select *
from persons
where substring(pname,1,1) = 'J';

select pname
, upper(pname)
, lower(pname)
, length(pname)
from persons;

-- replace -> case sensitive
select replace(pname, 'n', 'x') from persons;
select concat_ws('#', pname, ifnull(age, 0)) from persons;

-- indexOf
-- Java: return Index range from 0 to length -1, return -1 for not found
-- SQL: reuturn Index range from 1 to length, return 0 for not found
select pname, instr(pname, 'J') from persons;

update persons set pname ='彼得' where pname = 'David';
select pname, length(pname), char_length(pname) from persons;

-- like + % , % (zero or more)
select * from persons where pname like 'J%';
select * from persons where pname like '%ie%';

-- Integer Operation
select weight, floor(weight), ceil(weight) from persons;

-- Date Operation
select date_add(DoB, interval 3 month)
, DoB
, date_sub(DoB, interval 3 month)
, date_add(DoB, interval 2 year)
, date_add(DoB, interval 2 day) from persons;

select DoB
, extract(year from DoB)
, extract(month from DoB)
, extract(day from DoB)
 from persons;
 
-- select
select case
when weight > 70 then 'overweight'
when weight > 60 then 'normal'
else 'underweight'
end as weight_label,
weight,
pname,
id
from persons;

create table employees (
name varchar(20),
department varchar(2),
join_date date,
salary numeric (8,2)
);

insert into employees values ('John', 'IT', '2000-10-01', 25500.5);
insert into employees values ('Mary', 'IT', '1999-10-01', 29000.5);
insert into employees values ('Peter', 'MK', '2012-02-01', 14000.5);
insert into employees values ('Sally', 'HR', '2023-11-01', 18000.5);
insert into employees values ('Jennie', 'HR', '2019-12-01', 45000.5);
insert into employees values ('Sue', 'HR', '2020-06-01', 23000.5);

select * from employees;
delete from employees;

-- group by -> statistic (count, avg, max , min, sum)
-- group field X -> select field X (you can bypass the field X)
select department
, round(avg(salary),2) as average_salary
, max(salary) as max_salary
, min(salary) as min_salary
, sum(salary) as total_salary
, count(*) as no_of_employees
from employees
group by department;

-- NOT OK
-- select sum(salary), name from employees;

-- Having
select department, min(salary) -- Step 3
from employees
where salary >= 20000 -- Step 1
group by department having max(Salary) > 28000 -- Step 2
order by sum(salary) desc; -- Step 4

alter table employees add gender varchar(1);
update employees set gender = 'M' where name = 'John';
update employees set gender = 'F' where name = 'Mary';
update employees set gender = 'M' where name = 'Peter';
update employees set gender = 'F' where name = 'Sally';
update employees set gender = 'F' where name = 'Jennie';
update employees set gender = 'F' where name = 'Sue';

-- Multi grouping parameter
select department, gender, round(avg(salary),2), max(salary), sum(salary), min(join_date)
from employees
group by department, gender;

alter table employees add id bigint;
update employees set id = 1 where name = 'John';
update employees set id = 2 where name = 'Mary';
update employees set id = 3 where name = 'Peter';
update employees set id = 4 where name = 'Sally';
update employees set id = 5 where name = 'Jennie';
update employees set id = 6 where name = 'Sue';

create table jobs (
id bigint,
name varchar(100),
employee_id bigint
);

insert into jobs values (1, 'ABC', 1);
insert into jobs values (2, 'asdf', 1);
insert into jobs values (3, 'asdf', 1);
insert into jobs values (4, 'ABeC', 2);
insert into jobs values (5, 'ABqC', 3);
insert into jobs values (6, 'ABaC', 3);
insert into jobs values (7, 'AaBC', 5);
insert into jobs values (8, 'ABxC', 5);
insert into jobs values (9, 'ABCx', 5);
insert into jobs values (10, 'ABzC', 6);
select * from jobs;

-- Join Table
-- Inner Join (x)
select e.name as employee_name
, e.department
, j.id as job_id
, j.name as job_description
from employees e inner join jobs j on e.id = j.employee_id
where e.name = 'John';

-- Find employees who has no jobs (not exists)
select *
from employees e
where not exists (select * from jobs j where j.employee_id = e.id);

-- Find employees who has jobs (exists)
select *
from employees e
where exists (select * from jobs j where j.employee_id = e.id);

-- what is the difference between "exists" and "inner join"
-- 1. "exists" is faster than "inner join" (most likely)
-- 2. "inner join" is able to select both table columns, but "exists" cannot.

-- Primary Key and Foreign Key
create table customers(
id bigint primary key auto_increment,
name varchar(20),
age int
);

create table orders(
id bigint primary key auto_increment,
order_number varchar(50),
customer_id bigint,
foreign key (customer_id) references customers(id) -- foreign key -> for validating insert/update statement
);

insert into customers (name, age) values ('John', 13);
insert into customers (name, age) values ('Sally', 8);
insert into customers (name, age) values ('Leo', 23);
select * from customers;
insert into orders (order_number, customer_id) values ('HSBC001', 2);
insert into orders (order_number, customer_id) values ('HSBC002', 1);
select * from orders;

drop table jobs;
drop table employees;
drop table persons;
drop table orders;
drop table customers;

-- violate FK (foreign key constraint fails)
-- insert into orders (order_number, customer_id) values ('HSBC003', 4);