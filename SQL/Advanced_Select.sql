#Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. 
#Output one of the following statements for each record in the table

SELECT CASE WHEN A + B <= C OR A + C <= B OR B + C <= A THEN 'Not A Triangle'
            WHEN A = B AND B = C THEN 'Equilateral'
            WHEN A = B OR A = C OR B = C THEN 'Isosceles'
            ELSE 'Scalene'
        END
FROM TRIANGLES;

#Generate the following two result sets:

#Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a 
#parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
#Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the
#following format: There are a total of [occupation_count] [occupation]s

select name||'('||substr(Occupation,1,1)||')' from occupations order by name asc;

select 'There are a total of '||count||' '||lower(occupation)||'s.' from (select occupation, count(*) as count  from occupations group by occupation order by count,occupation asc) ;

#Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its 
#corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively
#Note: Print NULL when there are no more names corresponding to an occupation

select D,P,S,A from 
(select * from (select Name, occupation, ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY name) as row_num from occupations order by name asc) 
 pivot 
 ( min(name) for occupation in ('Doctor' as D,'Professor' as P,'Singer' as S,'Actor' as A)) order by row_num);
 
 
#You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N
#Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:

#Root: If node is root node.
#Leaf: If node is leaf node.
#Inner: If node is neither root nor leaf node.

select N, nvl2(P,(case when N in (select P from BST)
                      then 'Inner'
                      else 'Leaf'
                      end),
             'Root')
from BST 
order by N

#Amber's conglomerate corporation just acquired some new companies. Each of the companies follows this hierarchy: 

#Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, 
#total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code

select C.company_code,C1.founder,C.count1,C.count2,C.count3,C.count4 from
(select company_code,count(distinct lead_manager_code) count1,
count(distinct senior_manager_code) count2,
count(distinct manager_code) count3,
count(distinct employee_code) count4 from employee 
group by company_code
order by company_code) C,
(select distinct company_code,founder from company) C1
where C.company_code=C1.company_code
order by C.company_code;

;