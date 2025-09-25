create database bootcamp_exercise1;
use bootcamp_exercise1;

-- constraints - Primary Key, Foreign Key, not null, unique
-- Primary Key -> Non Null, Unique, Index
-- Foreign Key -> Refer to PK, Nullable, Index

create table regions(
REGION_ID bigint primary key auto_increment,
REGION_NAME varchar(25) not null
);
insert into regions (REGION_NAME) values ('EUROPE');
insert into regions (REGION_NAME) values ('ASIA');
insert into regions (REGION_NAME) values ('NORTH_AMERICA');

create table countries(
COUNTRY_ID varchar(2) primary key,
COUNTRY_NAME varchar(40),
REGION_ID bigint not null,
foreign key (REGION_ID) references regions(REGION_ID)
);
insert into countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) values ('UK', 'UNITED_KINGDOM', 1);
insert into countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) values ('FR', 'FRANCE', 1);
insert into countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) values ('CN', 'CHINA', 2);
insert into countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) values ('JP', 'JAPAN', 2);
insert into countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) values ('US', 'UNITED_STATE_OF_AMERICA', 3);
insert into countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) values ('CA', 'CANADA', 3);

create table locations(
LOCATION_ID bigint primary key auto_increment,
STREET_ADDRESS varchar(25),
POSTAL_CODE varchar(12),
CITY varchar(30),
STATE_PROVINCE varchar(12),
COUNTRY_ID varchar(2) not null,
foreign key (COUNTRY_ID) references countries(COUNTRY_ID)
);
insert into locations (STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID) values ('Choi_Hung_Road', 'CH123', 'SAN_PO_KONG', 'HONG_KONG','CN');
insert into locations (STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID) values ('Shibuya_Street', 'SH123', 'Shibuya', 'TOKYO','JP');
insert into locations (STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID) values ('Portinger_Street', 'PO123', 'MANCHESTER', 'LONDON','UK');
insert into locations (STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID) values ('Hollywood_Avenue', 'HO123', 'TIMESQUARE', 'NEW_YORK','US');

-- Q12
create table job_grades(
GRADE_LEVEL varchar(35) primary key,
LOWEST_SAL bigint not null,
HIGHEST_SAL bigint not null
);
insert into job_grades value ('GENERAL_MANAGEMENT', 500000, 1000000);
insert into job_grades value ('MANAGER', 30000, 100000);
insert into job_grades value ('OFFICER', 10000, 40000);
insert into job_grades value ('ASSISTANT', 5000, 20000);

create table jobs(
JOB_ID varchar(10) primary key,
GRADE_LEVEL varchar(35) not null,
-- JOB_TITTLE varchar(35),
-- MIN_SALARY bigint,
-- MAX_SALARY bigint,
foreign key (GRADE_LEVEL) references job_grades(GRADE_LEVEL)
);
-- insert into jobs (JOB_ID, JOB_TITTLE, MIN_SALARY, MAX_SALARY) values ('IT001', 'IT_MANAGER', 100000, 50000);
-- insert into jobs (JOB_ID, JOB_TITTLE, MIN_SALARY, MAX_SALARY) values ('IT002', 'IT_OFFICER', 40000, 20000);
-- insert into jobs (JOB_ID, JOB_TITTLE, MIN_SALARY, MAX_SALARY) values ('HR001', 'HR_MANAGER', 70000, 30000);
-- insert into jobs (JOB_ID, JOB_TITTLE, MIN_SALARY, MAX_SALARY) values ('HR002', 'HR_ASSISTANT', 15000, 8000);
-- insert into jobs (JOB_ID, JOB_TITTLE, MIN_SALARY, MAX_SALARY) values ('MK001', 'MK_MANAGER', 80000, 30000);
-- insert into jobs (JOB_ID, JOB_TITTLE, MIN_SALARY, MAX_SALARY) values ('MK002', 'MK_OFFICER', 25000, 13000);
-- insert into jobs (JOB_ID, JOB_TITTLE, MIN_SALARY, MAX_SALARY) values ('CEO', 'CHIEF_EXECUTIVE_OFFICER',10000000, 500000);
insert into jobs values ('CEO', 'GENERAL_MANAGEMENT');
insert into jobs values ('IT001', 'MANAGER');
insert into jobs values ('IT002', 'OFFICER');
insert into jobs values ('IT003', 'ASSISTANT');
insert into jobs values ('HR001', 'MANAGER');
insert into jobs values ('HR002', 'OFFICER');
insert into jobs values ('HR003', 'ASSISTANT');
insert into jobs values ('MK001', 'MANAGER');
insert into jobs values ('MK002', 'OFFICER');
insert into jobs values ('MK003', 'ASSISTANT');

create table departments(
DEPARTMENT_ID bigint primary key auto_increment,
DEPARTMENT_NAME varchar(30),
MANAGER_ID bigint,
LOCATION_ID bigint not null,
foreign key (LOCATION_ID) references locations(LOCATION_ID)
);
insert into departments (DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) values ('CENTRAL_MANAGEMENT', 1, 3);
insert into departments (DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) values ('INFORMATION_TECHNOLOGY', 2, 4);
insert into departments (DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) values ('HUMAN_RESOURCES', 3, 1);
insert into departments (DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) values ('MARKETING', 4, 2);

create table employees(
EMPLOYEE_ID bigint primary key auto_increment,
FIRST_NAME varchar(20),
LAST_NAME varchar(25),
EMAIL varchar(25) not null unique,
PHONE_NUMBER varchar(20),
HIRE_DATE date,
JOB_ID varchar(10) not null,
SALARY bigint,
COMMISSION_PCT bigint,
MANAGER_ID bigint,
DEPARTMENT_ID bigint not null,
foreign key (JOB_ID) references jobs(JOB_ID),
foreign key (DEPARTMENT_ID) references departments(DEPARTMENT_ID)
);

create index idx_employees_manager_id on employees (mamanger_id);

insert into employees (FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
values ('Leo', 'Chow', 'leoc246@gmail.com', '55447712', '2000-05-24', 'CEO', 800000, 0, null, 1);
insert into employees (FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
values ('Java', 'Chan', 'javac@gmail.com', '78912155', '2017-08-11', 'IT001', 60000, 0, 1, 2);
insert into employees (FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
values ('Mary', 'Smith', 'ms11@gmail.com', '65717568', '2020-02-01', 'HR001', 800000, 0, 1, 3);
insert into employees (FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
values ('Stephen', 'Lau', 'steplau2@gmail.com', '54871342', '2013-08-24', 'MK001', 55000, 0, 1, 4);
insert into employees (FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
values ('John','Wong', 'johnwong1234@gmail.com', '66211234', '2023-05-12', 'IT002', 50000, 0, 2, 2); 
insert into employees (FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
values ('Lucas','Chan', 'lucaschan1234@gmail.com', '99884561', '2024-07-26', 'IT003', 10000, 0, 2, 2);
insert into employees (FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
values ('Sally','Suzuki', 'ssusz88@gmail.com', '55224561', '2024-07-26', 'HR003', 8000, 0, 3, 3);


create table job_history(
EMPLOYEE_ID bigint,
START_DATE date,
primary key(EMPLOYEE_ID, START_DATE),
END_DATE date,
JOB_ID varchar(10) not null,
DEPARTMENT_ID bigint not null,
foreign key (EMPLOYEE_ID) references employees(EMPLOYEE_ID),
foreign key (JOB_ID) references jobs(JOB_ID),
foreign key (DEPARTMENT_ID) references departments(DEPARTMENT_ID)
);
insert into job_history(EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID) values (5, '2023-05-12', '2025-09-19', 'IT002', 2);
insert into job_history(EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID) values (6, '2024-07-26', '2025-09-19', 'IT003', 2);
insert into job_history(EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID) values (7, '2024-07-26', '2025-09-19', 'HR003', 3);

-- Q2. see "insert into"
-- Q3.
select l.LOCATION_ID, l.STREET_ADDRESS, l.CITY, l.STATE_PROVINCE, c.COUNTRY_NAME
from locations l inner join countries c on l.COUNTRY_ID = c.COUNTRY_ID; 
-- Q4.
select FIRST_NAME, LAST_NAME, DEPARTMENT_ID
from employees;
-- Q5.
select e.FIRST_NAME, e.LAST_NAME, e.JOB_ID, e.DEPARTMENT_ID
from employees e
inner join departments d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
inner join locations l on d.LOCATION_ID = l.LOCATION_ID
inner join countries c on c.COUNTRY_ID = l.COUNTRY_ID
where l.COUNTRY_ID = 'US';

-- Q6. 
select e.EMPLOYEE_ID, e.LAST_NAME, e.MANAGER_ID, m.LAST_NAME
from employees e left join employees m on e.MANAGER_ID = m.employee_ID;

-- Q7.
With john_hire_date_table as (
select HIRE_DATE as john_hire_date
from employees
where EMPLOYEE_ID = 5
)
select e.FIRST_NAME, e.LAST_NAME, e.HIRE_DATE
from employees e inner join john_hire_date_table j
where e.HIRE_DATE > j.john_hire_date;

-- Q8.
select d.DEPARTMENT_NAME, count(*) as NUMBERS_OF_EMPLOYEE
from employees e inner join departments d on e.DEPARTMENT_ID = d.DEPARTMENT_ID 
group by e.DEPARTMENT_ID;

-- Q9.
select h.EMPLOYEE_ID, j.GRADE_LEVEL, datediff(h.END_DATE, h.START_DATE) as NUMBER_OF_DAYS_HIRED
from job_history h inner join jobs j on h.JOB_ID = j.JOB_ID 
where h.DEPARTMENT_ID = 2;

-- Q10.
select d.DEPARTMENT_NAME, e.FIRST_NAME, l.CITY, c.COUNTRY_NAME
from departments d 
inner join employees e on d.MANAGER_ID = e.EMPLOYEE_ID
inner join locations l on d.LOCATION_ID = l.LOCATION_ID
inner join countries c on l.COUNTRY_ID = c.COUNTRY_ID;

-- Q11.
select d.DEPARTMENT_NAME, round(avg(e.SALARY),2) as AVERAGE_SALARY
from employees e inner join departments d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
group by d.DEPARTMENT_NAME;