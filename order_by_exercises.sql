-- Q1: Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.
-- CML cp where_exercises.sql order_by_exercises.sql
-- CML code order_by_exercises.sql

-- Q2: Modify your first query to order by first name. The first result should be Irena Reutenauer and the last result should be Vidya Simmen.
select concat (first_name, ' ', last_name) as employees_name
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
order by first_name;

-- Q3: Update the query to order by first name and then last name. The first result should now be Irena Acton and the last should be Vidya Zweizig.
select concat (first_name, ' ', last_name) as employees_name
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
order by first_name, last_name;

-- Q4: Change the order by clause so that you order by last name before first name. Your first result should still be Irena Acton but now the last result should be Maya Zyda.
select concat (first_name, ' ', last_name) as employees_name
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
order by last_name, first_name;

-- Q5: Update your queries for employees with 'E' in their last name to sort the results by their employee number. Your results should not change!
select concat (first_name, ' ', last_name) as empolyees_name, emp_no
from employees
where last_name like 'E%'
order by emp_no;

select concat (last_name, ',', first_name) as employees_name, emp_no
from employees
where last_name like 'E%'
or last_name like '%E'
order by emp_no

select concat (last_name, ',', first_name) as employees_name, emp_no
from employees
where last_name like 'E%E'
order by emp_no;

-- Q6: Now reverse the sort order for both queries.
select concat (first_name, ' ', last_name) as empolyees_name, emp_no
from employees
where last_name like 'E%'
order by emp_no desc;

select concat (last_name, ',', first_name) as employees_name, emp_no
from employees
where last_name like 'E%'
or last_name like '%E'
order by emp_no desc;

select concat (last_name, ',', first_name) as employees_name, emp_no
from employees
where last_name like 'E%E'
order by emp_no desc;

-- Q7 Change the query for employees hired in the 90s and born on Christmas such that the first result is the oldest employee who was hired last. It should be Khun Bernini.
select concat (first_name, ' ', last_name) as employees_name
from employees
where hire_date between '1990-01-01' and '1999-12-31'
and birth_date like '%-12-25'
order by birth_date, hire_date desc;
-- output: first name Khun Bernini