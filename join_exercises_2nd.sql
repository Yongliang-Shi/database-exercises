-- Using the example in the Associative Table Joins section as a guide, 
-- write a query that shows each department along with the name of the current manager for that department.

use employees;

-- step 1. Find the current manager emp_no for each department
select *
from departments as dep
join dept_manager as dm on dep.dept_no = dm.dept_no
where dm.to_date > curdate();

-- Step 2. Though manager emp_no to find the manager name for each department
-- It can be achieved either by another JOIN or SUBQUERY

select dept_name as 'Department Name', concat(ee.first_name, ' ', ee.last_name) as 'Department Manager'
from departments as dep
join dept_manager as dm on dep.dept_no = dm.dept_no
join employees as ee on dm.emp_no = ee.emp_no
where dm.to_date > curdate()
order by dept_name;


select dept_name as 'Department Name', concat(ee.first_name, ' ', ee.last_name) as 'Department Manager'
from employees as ee
join dept_emp on ee.emp_no = dept_emp.emp_no
join departments as dep on dept_emp.dept_no = dep.dept_no
where ee.emp_no in (
	select emp_no
	from departments as dep
	join dept_manager as dm on dep.dept_no = dm.dept_no
	where dm.to_date > curdate()
)
order by dept_name;

-- Find the name of all departments currently managed by women.
-- Add the gender filter to the qurey for the question above
    -- The gender filter can either be added to JOIN OR WHERE

select dept_name as 'Department Name', concat(ee.first_name, ' ', ee.last_name) as 'Department Manager'
from departments as dep
join dept_manager as dm on dep.dept_no = dm.dept_no
join employees as ee on dm.emp_no = ee.emp_no and ee.gender = 'F'
where dm.to_date > curdate()
order by dept_name;

select dept_name as 'Department Name', concat(ee.first_name, ' ', ee.last_name) as 'Department Manager'
from departments as dep
join dept_manager as dm on dep.dept_no = dm.dept_no
join employees as ee on dm.emp_no = ee.emp_no 
where dm.to_date > curdate()
and ee.gender = 'F'
order by dept_name;

-- Find the current titles of employees currenlty working in the customer service department

select title, count(de.emp_no)
from titles as t
join dept_emp as de on t.emp_no = de.emp_no
join departments as dep on de.dept_no = dep.dept_no
where t.to_date > curdate()
and de.to_date > curdate()
and dep.dept_name = 'Customer Service'
group by title;

-- Find the current salary of all current managers.
-- Add the salary column in the output of Q2 by JOIN table 'salaries'
-- The current filter can be added either within JOIN or by WHERE

select dept_name as 'Department Name', concat(ee.first_name, ' ', ee.last_name) as 'Department Manager', sa.salary as Salary
from departments as dep
join dept_manager as dm on dep.dept_no = dm.dept_no
join employees as ee on dm.emp_no = ee.emp_no
join salaries as sa on ee.emp_no = sa.emp_no
where dm.to_date > curdate()
and sa.to_date > curdate()
order by dept_name;

select dept_name as 'Department Name', concat(ee.first_name, ' ', ee.last_name) as 'Department Manager', sa.salary as Salary
from departments as dep
join dept_manager as dm on dep.dept_no = dm.dept_no and dm.to_date > curdate()
join employees as ee on dm.emp_no = ee.emp_no
join salaries as sa on ee.emp_no = sa.emp_no and sa.to_date > curdate()
order by dep.dept_name

-- Find the number of employees in each department.

select dm.dept_no, dep.dept_name, count(dm.emp_no)
from dept_emp as dm
join departments as dep on dm.dept_no = dep.dept_no
join employees as ee on dm.emp_no = ee.emp_no
where dm.to_date > curdate()
group by dm.dept_no;

-- Which department has the highest average salary? Hint: Use current not historic information.

select dep.dept_name, avg(sa.salary) as average
from departments as dep
join dept_emp as de on dep.dept_no = de.dept_no and de.to_date > curdate()
join salaries as sa on de.emp_no = sa.emp_no and sa.to_date > curdate()
group by dep.dept_no
order by average desc
limit 1;

-- Who is the highest paid employee in the Marketing department?

select ee.first_name as first_name, ee.last_name as last_name
from dept_emp as de
join departments as dep on de.dept_no = dep.dept_no and de.to_date > curdate() and de.dept_no = 'd001'
join salaries as sa on de.emp_no = sa.emp_no and sa.to_date > curdate()
join employees as ee on sa.emp_no = ee.emp_no
order by sa.salary desc
limit 1;

-- Which current department manager has the highest salary?
-- This is a update query for Q5
	-- Put Q5 query in descending order
	-- Choose the first row in the table
select ee.first_name as first_name,
			ee.last_name as last_name,
			sa.salary as salary,
			dep.dept_name
from departments as dep
join dept_manager as dm on dep.dept_no = dm.dept_no and dm.to_date > curdate()
join employees as ee on dm.emp_no = ee.emp_no
join salaries as sa on ee.emp_no = sa.emp_no and sa.to_date > curdate()
order by salary desc
limit 1;

