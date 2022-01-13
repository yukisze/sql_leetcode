/*
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key column for this table.
Each row of this table contains information about the salary of an employee.
 

Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.

The query result format is in the following example.

 

Example 1:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
n = 2
Output: 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
n = 2
Output: 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| null                   |
+------------------------+
*/


# solution 1
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  declare m int;
  set m = n-1; #N-1 is because we need to skip n-1 row to obtain nth highest salary
  RETURN (
      select distinct salary
      from employee 
      order by salary desc
      limit M,1
  );
END

#solution 2

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  set N = N-1;
  return(
   select distinct ifnull(salary,null)
   from employee
   order by salary desc
   limit N,1
   );
   End

# we cannot put N-1 in the return bracket, thats why I put set n = n-1 in the beginning
  
  
  
  
  
