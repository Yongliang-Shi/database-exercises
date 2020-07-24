-- Join Example Database
-- Q1: Use the join_example_db. Select all the records from both the users and roles tables.
use join_example_db;
describe users;
select * 
from users;
describe roles;
select *
from roles;

-- Q2: Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. 
-- Before you run each query, guess the expected number of results.

select *
from users
join roles on users.role_id = roles.id;

select *
from users
left join roles on users.role_id = roles.id;

select *
from users
right join roles on users.role_id = roles.id; 

-- Q3: Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. 
-- Use count and the appropriate join type to get a list of roles along with the number of users that has the role. 
-- Hint: You will also need to use group by in the query.

select roles.name, count(users.name)
from users
right join roles on users.role_id = roles.id
group by roles.name

-- Employees Database
-- Q1: Use the employees database.
use employees;
-- Q2: Using the example in the Associative Table Joins section as a guide, 
-- write a query that shows each department along with the name of the current manager for that department.
-- Breakdown:
    -- the tables I am gonna use
        -- departments: dept_name, PRI: dept_no
        -- employees_with_departments: emp_no (PRI), dept_no (PRI), first_name, last_name
        -- dept_manager: dept_no (FK), emp_no (FK), to_date for the current
    -- group by deparment name

select departments.dept_name as 'Department Name', concat (first_name, ' ', last_name) as 'Department Manager'
from departments
right join dept_manager 
	on departments.dept_no = dept_manager.dept_no
join employees 
	on employees.emp_no = dept_manager.emp_no   
where dept_manager.to_date > curdate()  

select departments.dept_name as 'Department Name', concat (first_name, ' ', last_name) as 'Department Manager'
from departments
right join dept_manager 
	on departments.dept_no = dept_manager.dept_no
join employees 
	on employees.emp_no = dept_manager.emp_no   
where dept_manager.to_date > curdate()
order by departments.dept_name    
-- Try to use alias

-- Q3: Find the name of all departments currently managed by women.
select departments.dept_name as 'Department Name', concat (first_name, ' ', last_name) as 'Department Manager'
from departments
right join dept_manager 
	on departments.dept_no = dept_manager.dept_no
join employees 
	on employees.emp_no = dept_manager.emp_no   
where dept_manager.to_date > curdate() and employees.gender = 'F'
order by departments.dept_name     

-- Find the current titles of employees currently working in the Customer Service department.
-- Breakdown:
    -- tables I am gonna use
        -- titles: title, emp_no(FK), to_date
        -- employees_with_departments: count the current employees, emp_no (PRI), dept_no ()
        -- Customer Service Department number: d009

select title as 'Title', count(title)
from dept_emp
join titles on dept.emp_no = titles.emp_no
where dept_no = 'd009'
and title.to_date > curdate();

select title as 'Title', count(title)
from dept_emp
join titles on dept_emp.emp_no = titles.emp_no
where dept_no = 'd009'
and titles.to_date > curdate()
and dept_emp.to_date > curdate()
group by title;

-- Q5: Find the current highest salary of all current managers.
-- Breakdown:
    -- this is a update of Q2.
    -- I need to join it for salary 

select departments.dept_name as 'Department Name', concat (first_name, ' ', last_name) as 'Department Manager', salary
from departments
right join dept_manager 
	on departments.dept_no = dept_manager.dept_no
join employees 
	on employees.emp_no = dept_manager.emp_no   
join salaries
    on employees.emp_no = salaries.emp_no
where dept_manager.to_date > curdate()
and salaries.to_date > curdate()
order by departments.dept_name;

-- Q6: Find the number of employees in each department.
select departments.dept_no as dept_no, dept_name, count(emp_no)
from departments
join dept_emp 
    on departments.dept_no = dept_emp.dept_no
where to_date > curdate()
group by departments.dept_no;
-- output: same as the example

-- Q7: Which department has the highest average salary?
select dept_name, avg(salary) as average_salary
from salaries
join dept_emp
    on salaries.emp_no = dept_emp.emp_no
join departments
    on dept_emp.dept_no = departments.dept_no
where dept_emp.to_date > curdate()
and salaries.to_date > curdate()
group by dept_name
order by average_salary desc
limit 1; 

-- Q8: Who is the highest paid employee in the Marketing department?
select first_name, last_name
from employees
join dept_emp   
    on employees.emp_no = dept_emp.emp_no
join salaries
    on employees.emp_no = salaries.emp_no
where dept_emp.to_date > curdate()
and salaries.to_date > curdate()
and dept_no = 'd001'
order by salary desc
limit 1;

-- Q9: Which current department manager has the highest salary?
-- update of Q5
select first_name, last_name, salary, departments.dept_name
from departments
right join dept_manager 
	on departments.dept_no = dept_manager.dept_no
join employees 
	on employees.emp_no = dept_manager.emp_no   
join salaries
    on employees.emp_no = salaries.emp_no
where dept_manager.to_date > curdate()
and salaries.to_date > curdate()
order by salary desc
limit 1;

-- Q10: Bouns
-- Find the names of all current employees, their department name, and their current manager's name

select concat(employees.first_name, ' ', employees.last_name) as 'Employee Name', dept_name as 'Department Name', dept_manager.emp_no
from dept_emp
join employees
    on dept_emp.emp_no = employees.emp_no
join departments
    on dept_emp.dept_no = departments.dept_no
right join dept_manager
	on dept_emp.dept_no = dept_manager.dept_no
where dept_emp.to_date > curdate()
and dept_manager.to_date > curdate();

-- Q11: Bonus Find the highest paid employee in each department.
-- update of Q8

select *
from departments
join dept_emp 
    on departments.dept_no = dept_emp.dept_no
join salaries
    on dept_emp.emp_no = salaries.emp_no
where dept_emp.to_date > curdate()
and salaries.to_date > curdate()





