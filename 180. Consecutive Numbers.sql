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


## self joining to create the following table
id	num	id	num	id	num
1	 1	  N	 N	  N	  N
2	 1	  1	 1	  N	  N
3	 1	  2	 1	  1	  1
4	 2	  3	 1	  2	  1
5	 1	  4	 2	  3	  1
6	 2	  5	 1	  4	  2
7	 2	  6	 2	  5	  1



