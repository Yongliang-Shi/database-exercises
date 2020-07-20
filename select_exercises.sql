#1. Create a new file called select_exercises.sql. Do your work for this exercise in that file.
# Using CML code select_exercises.sql

#2. Use the albums_db database.
show databases;
use albums_db;

#3. Explore the structure of the albums table.
describe albums;
select * from albums;

#4-1. Query for The name of all albums by Pink Floyd
select *
from albums
where artist = 'Pink Floyd';

#4-2. Query for The year Sgt. Pepper's Lonely Hearts Club Band was released
select release_date
from albums
where name = "Sgt. Pepper's Lonely Hearts Club Band";

#4-3. Query for The genre for the album Nevermind
select genre 
from albums
where name = 'Nevermind';

#4-4. Query for Which albums were released in the 1990s
select name 
from albums
where release_date between '1990' and '1999';

#4-5. Query for Which albums had less than 20 million certified sales
select name
from albums
where sales < 20.0;

#4-6. Query for All the albums with a genre of "Rock". 
# if = is used in the where clause, only albums having exactly "Rock" genre show up. 
select name, genre
from albums
where genre = 'Rock';

# If like is used in the where clause, all the albums containing "Rock" will show up. 
select name, genre
from albums
where genre like '%Rock%'