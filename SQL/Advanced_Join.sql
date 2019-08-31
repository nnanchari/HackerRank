#You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. 
#It is guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.
#If the End_Date of the tasks are consecutive, then they are part of the same project. 
#Samantha is interested in finding the total number of different projects completed.
#Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order. 
#If there is more than one project that have the same number of completion days, then order by the start date of the project.

select start_date,min(end_Date) end_date_final from 
(select start_date from projects where start_date not in (select end_date from projects) order by start_Date)a,
(select end_Date from projects where end_date not in (select start_date from projects) order by end_Date)b
where a.start_Date < b.end_Date
group by start_date
order by end_Date_final-start_Date, start_date;


#You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. Friends contains two columns: 
#ID and Friend_ID (ID of the ONLY best friend). Packages contains two columns: ID and Salary (offered salary in $ thousands per month).

select A.name from
(select s.id,s.name,p.salary from students s,packages p where s.id=p.id) A,
(select f.id,f.friend_id,p.salary from packages p, friends f where f.friend_id=p.id
 )B
where 
A.id=B.id and
B.Salary > A.Salary order by B.Salary;

#You are given a table, Functions, containing two columns: X and Y.
#Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.
#Write a query to output all such symmetric pairs in ascending order by the value of X.

select f1.x,f1.y from functions f1 inner join functions f2 on
f1.x=f2.y and f1.y=f2.x and f1.x <>  f2.x and f1.x < f2.x
union
select x,y from functions f where x=y group by x,y having count(*) >1
order by x;

#Samantha interviews many candidates from different colleges using coding challenges and contests. Write a query to print the contest_id, hacker_id, 
#name, and the sums of total_submissions, total_accepted_submissions, total_views, and total_unique_views for each contest sorted by contest_id. 
#Exclude the contest from the result if all four sums are .
#Note: A specific contest can be used to screen candidates at more than one college, but each college only holds  screening contest.

SELECT CT.contest_id, 
       CT.hacker_id, 
       CT.name, 
       sum(ts), 
       sum(tas), 
       sum(tv), 
       sum(tuv) 
FROM   contests CT 
       INNER JOIN colleges  CL 
               ON CL.contest_id = CT.contest_id 
       INNER JOIN challenges  CH 
               ON CH.college_id = CL.college_id 
       LEFT JOIN (SELECT challenge_id, 
                         Sum(total_submissions)          AS TS, 
                         Sum(total_accepted_submissions) AS TAS 
                  FROM   submission_stats 
                  GROUP  BY challenge_id) S 
              ON S.challenge_id = CH.challenge_id 
       LEFT JOIN (SELECT challenge_id, 
                         Sum(total_views)        AS TV, 
                         Sum(total_unique_views) AS TUV 
                  FROM   view_stats 
                  GROUP  BY challenge_id) V 
              ON V.challenge_id = CH.challenge_id 
GROUP BY CT.contest_id, 
       CT.hacker_id, 
       CT.name
ORDER  BY CT.contest_id;