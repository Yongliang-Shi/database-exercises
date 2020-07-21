-- Exercises Part I

-- Q1: Create a file named where_exercises.sql. Make sure to use the employees database
-- use CML code where_exercises.sql

-- Q2: Find all employees with first names 'Irena', 'Vidya', or 'Maya' — 709 rows (Hint: Use IN).
use employees;
select concat (first_name, ' ', last_name) as employees_name
from employees
where first_name in ('Irena', 'Vidya', 'Maya');
-- output: 709 rows affected

-- Q3: Find all employees whose last name starts with 'E' — 7,330 rows.
select concat (first_name, ' ', last_name) as empolyees_name
from employees
where last_name like 'E%'
-- output: 7730 rows affected

-- Q4: Find all employees hired in the 90s — 135,214 rows.
select concat (first_name, ' ', last_name) as employees_names
from employees
where hire_date between '1990-01-01' and '1999-12-31';
-- output: 135214 rows affected
-- The data type of the hired day is DATE, so you have to treat it like string
select concat (first_name, ' ', last_name) as employees_names
from employees
where hire_date between 1990-01-01 and 1999-12-31;
-- output: 0 rows affected
select concat (first_name, ' ', last_name) as employees_names
from employees
where hire_date between '1990' and '1999';
-- output: 0 rows affected

-- Q5: Find all employees born on Christmas — 842 rows.
select concat (first_name, ' ', last_name) as employees_names
from employees
where birth_date like '%-12-25';
-- output: 842 rows affected

-- Q6: Find all employees with a 'q' in their last name — 1,873 rows.
select concat (first_name, ' ', last_name) as employees_names
from employees
where last_name like '%q%';
-- output: 1873 rows affected

-- Exercises Part II

-- Q1: Update your query for 'Irena', 'Vidya', or 'Maya' to use OR instead of IN — 709 rows.
select concat (first_name, ' ', last_name) as employees_name
from employees
where first_name = 'Irena' or first_name = 'Vidya' or first_name = 'Maya';
-- output: 709 rows affected

-- Q2: Add a condition to the previous query to find everybody with those names who is also male — 441 rows.
select concat (first_name, ' ', last_name) as employees_name
from employees
where (first_name = 'Irena' or first_name = 'Vidya' or first_name = 'Maya')
and gender = 'M';
-- output: 441 rows affected
-- Without parenthesis, the output is more than 441 rows
select concat (first_name, ' ', last_name) as employees_name
from employees
where first_name = 'Irena' or first_name = 'Vidya' or first_name = 'Maya'
and gender = 'M';
-- output: 619 rows

-- Q3: Find all employees whose last name starts or ends with 'E' — 30,723 rows.
select concat (last_name, ',', first_name) as employees_name
from employees
where last_name like 'E%'
or last_name like '%E';
-- output: 30723 rows affected
-- It seems that IN doesn't allow wildcard %.
select concat (last_name, ',', first_name) as employees_name
from employees
where last_name in ('E%', '%E');
-- output: 0 rows affected

-- Q4: Duplicate the previous query and update it to find all employees whose last name starts and ends with 'E' — 899 rows.
select concat (last_name, ',', first_name) as employees_name
from employees
where last_name like 'E%E';
-- output: 899 rows affected

-- Q5: Find all employees hired in the 90s and born on Christmas — 362 rows.
select concat (last_name, ',', first_name) as employees_name
from employees
where hire_date between '1990-01-01' and '1999-12-31'
and birth_date like '%-12-25';
-- output: 362 rows affected

-- Q6: Find all employees with a 'q' in their last name but not 'qu' — 547 rows.
select concat (last_name, ',', first_name) as employees_name
from employees
where last_name like '%q%'
and last_name not like '%qu%';
-- output: 547 rows affected