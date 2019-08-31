#Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.
#Note: CITY.CountryCode and COUNTRY.Code are matching key columns.

select sum(ct.population) from city ct, country ctry 
where ct.CountryCode = ctry.Code and ctry.CONTINENT='Asia';


#Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.
#Note: CITY.CountryCode and COUNTRY.Code are matching key columns.

select CT.name from 
Country CTRY,City CT where CTRY.code=CT.CountryCode and CTRY.continent='Africa';


#Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.
#Note: CITY.CountryCode and COUNTRY.Code are matching key columns.

select ctry.continent,round(avg(ct.population)-0.5) from city ct, country ctry 
where ctry.Code =ct.CountryCode 
group by ctry.continent;

#You are given two tables: Students and Grades. Students contains three columns ID, Name and Marks.
#Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. Ketty doesn't want the NAMES of those students 
#who received a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. 
#If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. 
#Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. 
#If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.
#Write a query to help Eve.

select case when grade < 8 then null else name end as name,grade,
marks from students, Grades where marks between min_mark and max_mark                       
order by grade desc,name;

#Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! Write a query to print the respective 
#hacker_id and name of hackers who achieved full scores for more than one challenge. Order your output in descending order by the total number 
#of challenges in which the hacker earned a full score. If more than one hacker received full scores in same number of challenges, 
#then sort them by ascending hacker_id.

select h.hacker_id,h.name from submissions s
inner join challenges c
on c.challenge_id=s.challenge_id
inner join difficulty d
on d.difficulty_level =c.difficulty_level 
inner join hackers h
on h.hacker_id=s.hacker_id
where d.score=s.score
group by h.hacker_id,h.name
having count(h.hacker_id)>1
order by count(h.hacker_id) desc,h.hacker_id asc;


