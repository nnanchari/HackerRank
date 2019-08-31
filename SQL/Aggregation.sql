#Query a count of the number of cities in CITY having a Population larger than 100,000

select count(name) from city where population > 100000;

#Query the total population of all cities in CITY where District is California.

select sum(population) from city where district ='California';

#Query the average population of all cities in CITY where District is California.

select avg(population) from city where district='California';

#Query the average population for all cities in CITY, rounded down to the nearest integer.

select round(avg(population)) from city;

#Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.

select sum(population) from city where countrycode='JPN';

#Query the difference between the maximum and minimum populations in CITY.

select max(population)-min(population) from city;	

#Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, 
#but did not realize her keyboard's  key was broken until after completing the calculation. 
#She wants your help finding the difference between her miscalculation (using salaries with any zeroes removed), and the actual average salary.
#Write a query calculating the amount of error (i.e.:  average monthly salaries), and round it up to the next integer.

select ceil(avg(salary)-avg(replace(salary,'0',''))) from employees;


#Top Earners
#We define an employee's total earnings to be their monthly salary*months worked, and the maximum total earnings to be the maximum total earnings for any 
#employee in the Employee table. Write a query to find the maximum total earnings for all employees as well as the total number of employees 
#who have maximum total earnings. Then print these values as  space-separated integers.

select * from (select max(months * salary),count(employee_id) from employee 
group by months * salary
order by months * salary desc
              ) where rownum=1;


#Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345. Round your answer to  
#4 decimal places.

select cast(long_w as decimal(10,4)) from station 
where 
lat_n = (select max(lat_n) from station where lat_n < 137.2345);

#Weather Observation Station 2
#Query the following two values from the STATION table:
#The sum of all values in LAT_N rounded to a scale of 2 decimal places.
#The sum of all values in LONG_W rounded to a scale of 2 decimal places.

select cast(sum(lat_n) as decimal(10,2)) as lat,cast(sum(long_w) as decimal(10,2)) as lon from station;

#Weather Observation Station 13
#Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than 38.7880 and less than 137.2345. 
#Truncate your answer to 4 decimal places.

select cast(sum(lat_n) as decimal(10,4))from station where lat_n >38.7880 and lat_n < 137.2345;

#Weather Observation Station 14
#Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345. Truncate your answer to 4 decimal places.

select cast(max(lat_n) as decimal(10,4)) from station where lat_n < 137.2345;

#Weather Observation Station 15
#Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.235. 
#Round your answer to 4 decimal places.

select cast(long_w as decimal(10,4)) from station 
where 
lat_n = (select max(lat_n) from station where lat_n < 137.2345);

#Weather Observation Station 16
#Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7780. Round your answer to 4 decimal places.

select cast(min(lat_n) as decimal(10,4)) from station where lat_n > 38.7780;

#Weather Observation Station 17
#Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than 38.7780. 
#Round your answer to 4 decimal places.

select cast(long_w as decimal(10,4)) from station where lat_n =
(select min(lat_n) from station where lat_n > 38.7780);

#Weather Observation Station 18
#Consider P1(a,c) and P2(b,d) to be two points on a 2D plane.
#a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
#b happens to equal the minimum value in Western Longitude (LONG_W in STATION).
#c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
#d happens to equal the maximum value in Western Longitude (LONG_W in STATION).
#Query the Manhattan Distance between points P1 and P2 and round it to a scale of 4 decimal places.

select Round((max(lat_n)-min(lat_n)) + (max(long_W)-min(long_w)),4) from station;

#Weather Observation Station 19
#Consider P1(a,c) and P2(b,d) to be two points on a 2D plane where(a,b) are the respective minimum and maximum values of 
Northern Latitude (LAT_N) and (c,d) are the respective minimum and maximum values of Western Longitude (LONG_W) in STATION.
#Query the Euclidean Distance between points P1 and P2 and format your answer to display 4 decimal digits.

select round(
    sqrt(
    (max(lat_n)-min(lat_n)) * (max(lat_n)-min(lat_n))
    + 
    (max(long_w)-min(long_W)) * (max(long_w)-min(long_W)) ),4) from station;

#Weather Observation Station 20
#A median is defined as a number separating the higher half of a data set from the lower half. 
#Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to 4 decimal places.

select round(s.lat_n,4) from station s
where
(select count(lat_n) from station where lat_n < s.lat_n)
=
(select count(lat_n) from station where lat_n > s.lat_n);
