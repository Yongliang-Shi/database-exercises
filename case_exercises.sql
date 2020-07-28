-- Q1: Write a query that returns all employees (emp_no), their department number, their start date, their end date, 
-- and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

use employees;

select ee.emp_no
				, de.dept_no
				, de.from_date
				, de.to_date
				, case when de.to_date > curdate() then 1
					when de.to_date < curdate() then 0
					else 'Unclear'
					end as is_current_employee
from employees as ee
join dept_emp as de on ee.emp_no = de.emp_no;

-- Q2: Write a query that returns all employee names, and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' 
-- depending on the first letter of their last name.

select concat(first_name,' ', last_name) as full_name
				, case when substr(last_name,1,1) in ('A','B','C','D','E','F','G','H') then 'A-H'
				    when substr(last_name,1,1) in ('I','J','K','L','M','N','O','P','Q') then 'I-Q'
				    when substr(last_name,1,1) in ('R','S','T','U','V','W','X','Y','Z') then 'R-Z'
				    end AS alpha_group
from employees;

-- Q3: How many employees were born in each decade?

select decade, count(decade) 
from (
    select *
		, case when birth_date between '1950-01-01' and '1959-12-31' then '1950s'
		when birth_date between '1960-01-01' and '1969-12-31' then '1960s' 
		when birth_date between '1970-01-01' and '1979-12-31' then '1970s' 
		when birth_date between '1980-01-01' and '1989-12-31' then '1980s' 
		when birth_date between '1990-01-01' and '1999-12-31' then '1990s' 
		else 'After 2000'
		end as 'decade'
    from employees 
    order by birth_date
) as each_dec
group by each_dec.decade

-- BONUS
-- What is the average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

-- Step 1: find the average salary for each department
select dep.dept_name, avg(sa.salary)
from departments as dep
join dept_emp as de on dep.dept_no = de.dept_no and de.to_date > curdate()
join salaries as sa on de.emp_no = sa.emp_no and sa.to_date > curdate()
group by dep.dept_name

-- Step 2: Create temporaray table 
create temporary table dept_combo_salary as
select dep.dept_name, avg(sa.salary)
from employees.departments as dep
join employees.dept_emp as de on dep.dept_no = de.dept_no and de.to_date > curdate()
join employees.salaries as sa on de.emp_no = sa.emp_no and sa.to_date > curdate()
group by dep.dept_name;


use employees;

drop table dept_combo_salary;

create temporary table dept_combo_salary as
select dep.dept_name, avg(sa.salary) as dept_avg_sa
from employees.departments as dep
join employees.dept_emp as de on dep.dept_no = de.dept_no and de.to_date > curdate()
join employees.salaries as sa on de.emp_no = sa.emp_no and sa.to_date > curdate()
group by dep.dept_name;

select *
from dept_combo_salary;

-- Add column for combined departments
alter table dept_combo_salary drop column dept_group;
alter table dept_combo_salary drop column avg_salary;

alter table dept_combo_salary add dept_group varchar(20) default 'NUll';
alter table dept_combo_salary add avg_salary float default 0;
/* insert into dept_combo_salary(avg_salary) values (1),(2),(3),(4),(5),(6),(7),(8),(9); */

select *,

case 
when dept_name = 'Finance' then 'Finance & HR'
when dept_name = 'Human Resources' then 'Finance & HR' 
when dept_name = 'Development' then 'R&D'
when dept_name = 'Research' then 'R&D'
when dept_name = 'Production' then 'Prod & QM'
when dept_name = 'Quality Management' then 'Prod & QM'
when dept_name = 'Sales' then 'Sales & Marketing'
when dept_name = 'Marketing' then 'Sales & Marketing'
when dept_name = 'Customer Service' then 'Customer Service'
end as dept_group

from dept_combo_salary;

select *,

case when dept_group = 'Finance' then 78559.9370 + 63921.8998
end as avg_salary

from dept_combo_salary;


