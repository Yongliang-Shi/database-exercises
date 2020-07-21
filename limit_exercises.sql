-- Q1: Create a new SQL script named limit_exercises.sql.
-- CML code limit_exercises.sql

-- Q2: MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. For example, to find all the unique titles within the company, we could run the following query:
-- SELECT DISTINCT title FROM titles;
-- List the first 10 distinct last name sorted in descending order. Your result should look like this:
select distinct last_name
from employees
order by last_name desc
limit 10;

-- Q3: Find your query for employees born on Christmas and hired in the 90s from order_by_exercises.sql. Update it to find just the first 5 employees. Their names should be:
select concat (first_name, ' ', last_name) as employees_name
from employees
where hire_date between '1990-01-01' and '1999-12-31'
and birth_date like '%-12-25'
order by birth_date, hire_date desc
limit 5;

-- Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results. The employee names should be:
select concat (first_name, ' ', last_name) as employees_name, emp_no
from employees
where hire_date between '1990-01-01' and '1999-12-31'
and birth_date like '%-12-25'
order by birth_date, hire_date desc
limit 5 offset 45;