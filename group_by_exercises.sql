-- Q1: Create a new file named group_by_exercises.sql
-- CML code group_by_exercises.sql

-- Q2: In your script, use DISTINCT to find the unique titles in the titles table.
use employees;
describe titles;
select distinct title
from titles;
-- output: same as the example

-- Count is purely counting the rows, whether we count all columns through * or specify a column
select title, count(title)
from titles
where title in ('Staff','Manager')
group by title;
-- Simiar to Q7

-- sum the total couts for the above
select sum (s.total) as total_rows
    from (select title, count(title) as total
        from titles
        where title in ('Staff','Manager')
        group by title;
    ) as s;
-- sum, ave, min, max, etc. are all working on the values within the columns so you must specify the colume name

-- Q3: Find your query for employees whose last names start and end with 'E'. 
-- Update the query find just the unique last names that start and end with 'E' using GROUP BY. 
select last_name
from employees
where last_name like 'E%E'
group by last_name;
-- output: same as the example
-- You can also use DISTINCT with ORDER BY
select distinct last_name
from employees
where last_name like 'E%E'
order by last_name;
-- output: same result

-- Q4: Update your previous query to now find unique combinations of first and last name 
-- where the last name starts and ends with 'E'. 
-- You should get 846 rows.
select concat (last_name, ',', first_name) as full_name
from employees
where last_name like 'E%E'
group by last_name, first_name;
-- Aslo group by full_name;
-- output: 846 rows affected
-- If first_name is being 'SELECT', it must be "GROUP BY"
-- However, if last_name is 'DISTINCT', the above statement does not apply. 
select distinct last_name, first_name
from employees
where last_name like 'E%E'
order by last_name;
-- output: 846 rows affected

-- Q5: Find the unique last names with a 'q' but not 'qu'.
select last_name
from employees
where last_name like '%q%'
and last_name not like '%qu%'
group by last_name;
-- output: same as the example

-- Q6: Add a COUNT() to your results and use ORDER BY to make it easier to find employees whose unusual name is shared with others.
select last_name, count(last_name) as shared_time
from employees
where last_name like 'E%E'
group by last_name
order by shared_time desc;

select last_name, count(last_name) as shared_time
from employees
where last_name like '%q%'
and last_name not like '%qu%'
group by last_name
order by shared_time desc;

-- Q7: Update your query for 'Irena', 'Vidya', or 'Maya'. 
-- Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names. 
select count(gender), gender
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
group by gender;
-- output: same as the example

-- Q8: Recall the query the generated usernames for the employees from the last lesson. Are there any duplicate usernames?
-- Bonus: how many duplicate usernames are there?
-- Answer: Yes, there are duplicate usernames since the row number is less when 'DISTINCT' is added
select concat(lower(substr(first_name,1,1)),lower(substr(last_name,1,4)),'_',substr(birth_date,6,2),substr(birth_date,3,2)) as username
    , first_name
    , last_name
    , birth_date
from employees;
-- output: 300024 rows affected
select distinct concat(lower(substr(first_name,1,1)),lower(substr(last_name,1,4)),'_',substr(birth_date,6,2),substr(birth_date,3,2)) as username
    , first_name
    , last_name
    , birth_date
from employees;
-- output: 300018 rows affected
-- and the number of duplicate usernames are (300024 - 300018) = 6

-- Method 1: 
-- Run DISTINCT without first_name, last_name, birth_date
select distinct concat(lower(substr(first_name,1,1)),lower(substr(last_name,1,4)),'_',substr(birth_date,6,2),substr(birth_date,3,2)) as username
from employees;
-- output: 285872 rows affected
-- the difference is (300024 - 285872) = 14152

-- Method 2:
-- Step 1: Find the how many repetition each user name has
select concat(lower(substr(first_name,1,1)),lower(substr(last_name,1,4)),'_',substr(birth_date,6,2),substr(birth_date,3,2)) as username
    , count(concat(lower(substr(first_name,1,1)),lower(substr(last_name,1,4)),'_',substr(birth_date,6,2),substr(birth_date,3,2))) as rep
from employees
group by username
order by rep desc

-- Step 2: count the username by subquerry
select count(username_count.username)
from (
    select concat(lower(substr(first_name,1,1)),lower(substr(last_name,1,4)),'_',substr(birth_date,6,2),substr(birth_date,3,2)) as username
    , count(concat(lower(substr(first_name,1,1)),lower(substr(last_name,1,4)),'_',substr(birth_date,6,2),substr(birth_date,3,2))) as rep
    from employees
    group by username
    order by rep desc
) as username_count;
-- output 285872 rows affected

-- Step 3: calculate the difference: (300024 - 285872) = 14152