-- Find all the employees with the same hire date as employee 101010 using a sub-query.
select *
from employees
where hire_date in (
	select hire_date
	from employees
	where emp_no = '101010'
);
-- output: 69 rows affected
-- You also can use '='

-- Q2: Find all the titles held by all employees with the first name Aamod.
select title
from titles
where titles.emp_no in ( 
	select employees.emp_no
	from employees
	where first_name = 'Aamod'
)
order by title
-- 316 rows affected, 6 unique titles
-- You can also use DISTINCT title

-- Q3: How many people in the employees table are no longer working for the company?
select count(emp_no)
from employees
where emp_no in (
	select emp_no 
	from dept_emp
	where to_date != '9999-01-01'
);
-- Another way: WHERE column NOT IN ()

-- Q4: Find all the current department managers that are female.
select first_name, last_name
from employees
where emp_no in (
	select emp_no
	from dept_manager
	where to_date > curdate()
)
and gender = "F";
-- same as the example

-- Q5: Find all the employees that currently have a higher than average salary.
-- 154543 rows in total. 
-- average salary
-- 1. What is the average salary
select avg(salary)
from salaries
where to_date > curdate();

-- 2. Who is currenlty have a higher salary than average?

select emp_no
from salaries
where salary > (
	select avg(salary)
	from salaries
)
and to_date > curdate();

-- 3. add names

select first_name, last_name
from employees
where emp_no in (
	select emp_no
	from salaries
	where salary > (
		select avg(salary)
		from salaries
		)
	and to_date > curdate()
)
-- You cann't join salaries directly from the code above

select ee.first_name as first_name, ee.last_name as last_name, salary
from ( 
select *
from employees
where emp_no in (
	select emp_no
	from salaries
	where salary > (
		select avg(salary)
		from salaries
		)
	and to_date > curdate()
)
) as ee
join salaries on ee.emp_no = salaries.emp_no
where to_date > curdate();
-- output: same as the example

-- Q6: How many current salaries are within 1 standard deviation of the highest salary? 
-- (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
select count(salary)
from salaries
where salary > (
select (max(salary) - stddev(salary))
from salaries
)
and to_date > curdate();
-- output: 78 rows affected

-- BONUS
-- Q1: Find all the department names that currently have female managers.
select dept_name
from departments
where dept_no in (
	select dept_no
	from dept_emp
	where emp_no in (
		select emp_no
		from employees
		where emp_no in (
			select emp_no 
			from dept_manager
			where to_date > curdate()
		)
		and gender = "F"
	)
)
-- output: same as the example

-- Q2: Find the first and last name of the employee with the highest salary.
select first_name, last_name 
from employees
where emp_no = (
	select emp_no
	from salaries
	where salary = (
		select max(salary)
		from salaries
	)
)
-- output: same as the example

-- Q3: Find the department that the employee with the highest salary works in

select dept_name
from departments
where dept_no = (
	select dept_no
	from dept_emp
	where emp_no = (
		select emp_no
		from salaries
		where salary = (
			select max(salary)
			from salaries
		)
	)
);
-- output: same as the example