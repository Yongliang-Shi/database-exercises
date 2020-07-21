-- Q1: Copy the order by exercise and save it as functions_exercises.sql.
-- CML functions_exercises.sql

-- Q2: Update your queries for employees whose names start and end with 'E'. 
-- Use concat() to combine their first and last name together as a single column named full_name.
select concat (first_name, ' ', last_name) as full_name
from employees
where last_name like 'E%E'
and first_name like 'E%E';

-- Q3: Convert the names produced in your last query to all uppercase.
select upper (concat (first_name, ' ', last_name)) as full_name
from employees
where last_name like 'E%E'
and first_name like 'E%E';

-- Q4: For your query of employees born on Christmas and hired in the 90s
--- use datediff() to find how many days they have been working at the company 
-- (Hint: You will also need to use NOW() or CURDATE())
select concat (first_name, ' ', last_name) as full_name, hire_date, datediff(curdate(), hire_date) as working_days
from employees
where hire_date between '1990-01-01' and '1999-12-31'
and birth_date like '%-12-25'
order by working_days;
-- output: 362 rows affected. min(working_days) = 7630
-- NOW() gives the same output
select concat (first_name, ' ', last_name) as full_name, hire_date, datediff(now(), hire_date) as working_days
from employees
where hire_date between '1990-01-01' and '1999-12-31'
and birth_date like '%-12-25'
order by working_days;
-- output: 362 rows affected. min(working_days) = 7630
-- ? operator - give wrong output, why? 


-- Q5: Find the smallest and largest salary from the salaries table.
select min(salary) as smallset_salary, max(salary) as largest_salary
from salaries;
-- output: min(salary) = 38623; max(salary) = 158220

-- Use your knowledge of built in SQL functions to generate a username for all of the employees. 
-- A username should be all lowercase, and consist of the first character of the employees first name, 
-- the first 4 characters of the employees last name, an underscore, the month the employee was born, 
-- and the last two digits of the year that they were born. 
select concat(lower(substr(first_name,1,1)),lower(substr(last_name,1,4)),'_',substr(birth_date,6,2),substr(birth_date,3,2)) as username, first_name, last_name, birth_date
from employees
limit 10; 
-- output: same as the example
-- ? Is this the way how to generate the username? 
-- ? Is there a better way?