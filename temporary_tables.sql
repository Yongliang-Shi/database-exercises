-- Q1. Using the example from the lesson, re-create the employees_with_departments table.

CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;

select *
from employees_with_departments;
-- To ensure the table has been created. 

-- Q1_a&b Add a column named full_name to this table. 
-- It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
-- Update the table so that full name column contains the correct data

alter table employees_with_departments add full_name varchar(50);

update employees_with_departments
set full_name = concat (first_name, ' ', last_name);

select *
from employees_with_departments;

-- Q1_c. Remove the first_name and last_name columns from the table.

alter table employees_with_departments drop column first_name;
alter table employees_with_departments drop column last_name;

select *
from employees_with_departments;

-- Q1_d: What is another way you could have ended up with this same table?

CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, concat(first_name,' ', last_name) as full_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;

select *
from employees_with_departments;

-- Q2: Create a temporary table based on the payment table from the sakila database.
-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. 
-- For example, 1.99 should become 199.

use darden_1041;
create temporary table payment as
select *
from sakila.payment;

alter table payment add amount_cent int;

update payment
set amount_cent = amount*100;

alter table payment drop column amount;

select * from
payment;
-- Could I alter the data type of a column?

--Q3: Find out how the average pay in each department compares to the overall average pay. 
-- In order to make the comparison easier, you should use the Z-score for salaries. 
-- In terms of salary, what is the best department to work for? The worst?
use darden_1041;

-- Step 1: create temporary table for average pay in each department. 
-- drop table department_average_pay;

create temporary table department_average_pay as
select dep.dept_name, avg(sa.salary) as dep_avg_sa
from employees.salaries as sa
join employees.dept_emp as de on sa.emp_no = de.emp_no and sa.to_date > curdate()
join employees.departments as dep on de.dept_no = dep.dept_no and de.to_date > curdate()
group by dep.dept_name;

alter table department_average_pay add ovrall_avg decimal(9,4);
alter table department_average_pay add ovrall_std decimal(9,4);

select *
from department_average_pay;

-- Step 2: create temporary value overall average
-- drop table overall_average_pay;
create temporary table overall_average_pay as
select avg(salary) as avg_all_sa
from employees.salaries
where employees.salaries.to_date > curdate();

select overall_average_pay.avg_all_sa
from overall_average_pay;

update department_average_pay
set ovrall_avg = (
select overall_average_pay.avg_all_sa
from overall_average_pay
);

select *
from department_average_pay;

-- Step 3: create temporary value overall average
-- drop table overall_std_pay;
create temporary table overall_std_pay as
select stddev(salary) as std_all_sa
from employees.salaries
where employees.salaries.to_date > curdate(); 

select overall_std_pay.std_all_sa 
from overall_std_pay;

update department_average_pay
set ovrall_std = (
select overall_std_pay.std_all_sa 
from overall_std_pay
);

select *
from department_average_pay;

-- Step 4: add a new column salary_z_score and calculate the value
-- alter table department_average_pay drop column salary_z_sore;
alter table department_average_pay add salary_z_sore decimal(7,7);

update department_average_pay
set salary_z_sore = (dep_avg_sa - ovrall_avg) / ovrall_std;

select * 
from overall_std_pay;

-- Best department: Sales
-- Worst department: Human Resources