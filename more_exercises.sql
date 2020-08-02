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

-- World Database
-- What languages are spoken in Santa Monica?
select Language, Percentage
from city
join countrylanguage as cl on city.countrycode = cl.countrycode
where name = 'Santa Monica'
order by percentage;

-- How many different countries are in each region?
select Region, count(name) as num_countries
from country
group by Region
order by num_countries;

-- What is the population for each region?
select Region, sum(population) as population
from country
group by Region
order by population desc;

-- What is the population for each continent?
select Continent, sum(population) as population
from country
group by Continent
order by population desc;

-- What is the average life expectancy globally?
select avg(LifeExpectancy)
from country;

-- What is the average life expectancy for each region, each continent? Sort the results from shortest to longest
select Continent, avg(LifeExpectancy) as life_expectancy 
from country
group by Continent
order by life_expectancy;

select Region, avg(LifeExpectancy) as life_expectancy 
from country
group by Region
order by life_expectancy;

-- Bonus
-- Find all the countries whose local name is different from the official name
 select Name, LocalName
 from country
 where Name != LocalName
 order by Name;

--  How many countries have a life expectancy less than x?
-- Assume x = 65
select count(Name)
from country
where LifeExpectancy > 65;

-- What state is city x located in?
-- Assume city x = San Antonio
select Name, District as State 
from city
where Name = 'San Antonio'

-- What region of the world is city x located in?
-- Assume city x = San Antonio
select city.name as city_name, country.name, region
from city
join country on city.countrycode = country.code
where city.name like 'San Antonio';

-- What country (use the human readable name) city x located in?
-- Assume city x = San Antonio
select city.name as city_name, country.name
from city
join country on city.countrycode = country.code
where city.name like 'San Antonio';

-- What is the life expectancy in city x?
-- Assume city x = San Antonio
select city.name as city_name, LifeExpectancy
from city
join country on city.countrycode = country.code
where city.name like 'San Antonio';

-- Sakila Database
-- Q1: Display the first and last names in all lowercase of all the actors.
select lower(first_name) as first_name, lower(last_name) as last_name
from actor;

-- Q2: You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
-- What is one query would you could use to obtain this information?
select actor_id as ID_number, first_name, last_name
from actor
where first_name = 'Joe';

-- Q3: Find all actors whose last name contain the letters "gen":
select actor_id, first_name, last_name
from actor
where last_name like "%gen%";

-- Q4: Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order.
select last_name, first_name
from actor
where last_name like "%li%"
order by last_name, first_name;

-- Q5: Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China
select country_id, country
from country 
where country in ("Afghanistan","Bangladesh","China");

-- Q6: List the last names of all the actors, as well as how many actors have that last name.
select last_name, count(last_name) 
from actor
group by last_name;

-- Q7: ist last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
select last_name, count(last_name) 
from actor
group by last_name
having count(last_name) > 1;

-- Q8: You cannot locate the schema of the address table. Which query would you use to re-create it?
show create table address;
describe address;

-- Q9: Use JOIN to display the first and last names, as well as the address, of each staff member.
select first_name, last_name, address
from staff
join address using(address_id);

-- Q10: Use JOIN to display the total amount rung up by each staff member in August of 2005.
select staff_id, first_name, last_name, sum(amount) 
from staff
join payment using(staff_id)
where payment_date like "%2005-08%"
group by staff_id;