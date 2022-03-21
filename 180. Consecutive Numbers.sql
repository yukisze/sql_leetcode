/*
Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
id is the primary key for this table.
 

Write an SQL query to find all numbers that appear at least three times consecutively.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
Explanation: 1 is the only number that appears consecutively for at least three times.
*/


## solution 1

Select distinct L.NUM as ConsecutiveNums
from logs L
left join logs L1
               ON (L1.ID = L.ID + 1 and L.NUM = L1.NUM)
left join logs L2
               ON (L2.ID = L.ID + 2 AND  L.NUM = L2.NUM)

WHERE L.ID IS NOT NULL AND L1.ID IS NOT NULL AND L2.ID IS NOT NULL;


## self left joining to create the following table
id	num	id	num	id	num
1	 1	  N	 N	  N	  N
2	 1	  1	 1	  N	  N
3	 1	  2	 1	  1	  1
4	 2	  N	 N	  N	  N
5	 1	  N	 N	  3	  1
6	 2	  N	 N	  4	  2
7	 2	  6	 2	  N	  N

-- this is why we need all L L1 L2 too be not null

-- using inner join we get
id	num	id	num	id	num
3	 1	  2	 1	  1	 1 

-- solution 2 using between 1 and 2

select distinct(t1.num) as ConsecutiveNums from logs t1 
join logs t2 on  t1.num = t2.num 
where t2.id - t1.id between 1 and 2 --so the id will be having 1 and 2 difference
group by t1.id and t1.num --group by so we can count(t2.id) to see if it is >= 2
having count(t2.id) >=2;
                            



