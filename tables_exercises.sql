show databases;
use employees;
show tables;
use employees;
describe employees;
# Data type includes int, date, varchar, enum
show tables;
# tables contain numeric type column: current_dep_emp;dept_emp; dept_emp_latest_date; dept_manager;employees; employees_with_departments; salaries; titles;
# tables contain string type column:current_dept_emp; departments; dept_emp; dept_manager;employees; employees_with_departments; titles;
# tables contain date type column: current_dept_emp; dept_emp; dept_emp_latest_date; dept_manager; employees; employees_with_departments; salaries; titles
show create table employees;
show create table departments;
show create table dept_manager;
show create table dept_emp;
# Table dept_manager and dept_emp use both employees and departments tables as references
show create table dept_manager;