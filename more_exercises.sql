-- Employees Database
-- Q1: How much do the current managers of each department get paid, relative to the average salary for the department? 
-- Is there any department where the department manager gets paid less than the average salary?

-- Step 1: current average salary of each department
select de.dept_no, avg(sa.salary) as salary
from dept_emp as de
join salaries as sa on de.emp_no = sa.emp_no and de.to_date > curdate() and sa.to_date > curdate()
group by de.dept_no;

-- Step 2: current salary of the manager in each department
select dm.dept_no, dm.emp_no, sa.salary 
from dept_manager as dm
join salaries as sa on dm.emp_no = sa.emp_no and dm.to_date > curdate() and sa.to_date > curdate();

-- Step 3: current manager's salary and average salary in each department
select * 
from (
    select de.dept_no, avg(sa.salary) as salary
    from dept_emp as de
    join salaries as sa on de.emp_no = sa.emp_no and de.to_date > curdate() and sa.to_date > curdate()
    group by de.dept_no
) as avg_sa
join (
    select dm.dept_no, dm.emp_no, sa.salary 
    from dept_manager as dm
    join salaries as sa on dm.emp_no = sa.emp_no and dm.to_date > curdate() and sa.to_date > curdate()
) as dm_sa
on avg_sa.dept_no = dm_sa.dept_no

-- Step 4: Add manager's names and department's names 

select * 
from (
    select de.dept_no, avg(sa.salary) as salary
    from dept_emp as de
    join salaries as sa on de.emp_no = sa.emp_no and de.to_date > curdate() and sa.to_date > curdate()
    group by de.dept_no
) as avg_sa
join (
    select dm.dept_no, dm.emp_no, sa.salary 
    from dept_manager as dm
    join salaries as sa on dm.emp_no = sa.emp_no and dm.to_date > curdate() and sa.to_date > curdate()
) as dm_sa
on avg_sa.dept_no = dm_sa.dept_no
join employees as ee
on dm_sa.emp_no = ee.emp_no
join departments as dep
on avg_sa.dept_no = dep.dept_no;

-- Step 5: Add relative salary

select *, (dm_sa.salary-avg_sa.salary)
from (
    select de.dept_no, avg(sa.salary) as salary
    from dept_emp as de
    join salaries as sa on de.emp_no = sa.emp_no and de.to_date > curdate() and sa.to_date > curdate()
    group by de.dept_no
) as avg_sa
join (
    select dm.dept_no, dm.emp_no, sa.salary 
    from dept_manager as dm
    join salaries as sa on dm.emp_no = sa.emp_no and dm.to_date > curdate() and sa.to_date > curdate()
) as dm_sa
on avg_sa.dept_no = dm_sa.dept_no
join employees as ee
on dm_sa.emp_no = ee.emp_no
join departments as dep
on avg_sa.dept_no = dep.dept_no;

-- Step 6: Clean up the table

select dep.dept_name as 'Department Name'
	, concat(ee.first_name, ' ', ee.last_name) as 'Full Name'
	, dm_sa.salary as 'Manager Salary'
	, avg_sa.salary as 'Average Salary'
	, (dm_sa.salary-avg_sa.salary) as 'Relative Salary'
from (
    select de.dept_no, avg(sa.salary) as salary
    from dept_emp as de
    join salaries as sa on de.emp_no = sa.emp_no and de.to_date > curdate() and sa.to_date > curdate()
    group by de.dept_no
) as avg_sa
join (
    select dm.dept_no, dm.emp_no, sa.salary 
    from dept_manager as dm
    join salaries as sa on dm.emp_no = sa.emp_no and dm.to_date > curdate() and sa.to_date > curdate()
) as dm_sa
on avg_sa.dept_no = dm_sa.dept_no
join employees as ee
on dm_sa.emp_no = ee.emp_no
join departments as dep
on avg_sa.dept_no = dep.dept_no
order by dep.dept_name