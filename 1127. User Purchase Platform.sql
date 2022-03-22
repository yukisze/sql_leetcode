/* Table: Spending

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| spend_date  | date    |
| platform    | enum    | 
| amount      | int     |
+-------------+---------+

The table logs the history of the spending of users that make purchases from an online shopping website that has a desktop and a mobile application.
(user_id, spend_date, platform) is the primary key of this table.
The platform column is an ENUM type of ('desktop', 'mobile')
Write an SQL query to find the total number of users and the total amount spent using the mobile only, the desktop only, 
and both mobile and desktop together for each date.

Return the result table in any order.

Example 1:

Input: 
Spending table:
+---------+------------+----------+--------+
| user_id | spend_date | platform | amount |
+---------+------------+----------+--------+
| 1       | 2019-07-01 | mobile   | 100    |
| 1       | 2019-07-01 | desktop  | 100    |
| 2       | 2019-07-01 | mobile   | 100    |
| 2       | 2019-07-02 | mobile   | 100    |
| 3       | 2019-07-01 | desktop  | 100    |
| 3       | 2019-07-02 | desktop  | 100    |
+---------+------------+----------+--------+
Output: 
+------------+----------+--------------+-------------+
| spend_date | platform | total_amount | total_users |
+------------+----------+--------------+-------------+
| 2019-07-01 | desktop  | 100          | 1           |
| 2019-07-01 | mobile   | 100          | 1           |
| 2019-07-01 | both     | 200          | 1           |
| 2019-07-02 | desktop  | 100          | 1           |
| 2019-07-02 | mobile   | 100          | 1           |
| 2019-07-02 | both     | 0            | 0           |
+------------+----------+--------------+-------------+ 
Explanation: 
On 2019-07-01, user 1 purchased using both desktop and mobile, user 2 purchased using mobile only and user 3 purchased using desktop only.
On 2019-07-02, user 2 purchased using mobile only, user 3 purchased using desktop only and no one purchased using both platforms.
*/

--solution 1
-- using if(condition, value_if_true, value_if_false) to get 'both'
/*
This is the table to count number of user_id on the same spend_date, so if ct = 2, then we get both

+---------+------------+----+----------+--------+
| user_id | spend_date | ct | platform | amount |
+---------+------------+----+----------+--------+
|       1 | 2019-07-01 |  2 | mobile   |    200 |
|       2 | 2019-07-01 |  1 | mobile   |    100 |
|       2 | 2019-07-02 |  1 | mobile   |    100 |
|       3 | 2019-07-01 |  1 | desktop  |    100 |
|       3 | 2019-07-02 |  1 | desktop  |    100 |
|       3 | 2019-07-03 |  1 | desktop  |    100 |
|       4 | 2019-07-03 |  1 | desktop  |    100 |
|       5 | 2019-07-03 |  1 | desktop  |    100 |
|       6 | 2019-07-03 |  1 | desktop  |    100 |
|       7 | 2019-07-03 |  1 | desktop  |    100 |
+---------+------------+----+----------+--------+

+---------+------------+----------+--------+
| user_id | spend_date | platform | amount |
+---------+------------+----------+--------+
|       1 | 2019-07-01 | both     |    200 |
|       2 | 2019-07-01 | mobile   |    100 |
|       2 | 2019-07-02 | mobile   |    100 |
|       3 | 2019-07-01 | desktop  |    100 |
|       3 | 2019-07-02 | desktop  |    100 |
|       3 | 2019-07-03 | desktop  |    100 |
|       4 | 2019-07-03 | desktop  |    100 |
|       5 | 2019-07-03 | desktop  |    100 |
|       6 | 2019-07-03 | desktop  |    100 |
|       7 | 2019-07-03 | desktop  |    100 |
+---------+------------+----------+--------+
*/
-- then create a table to perform right join, so that we can obtain null value
/* # spend_date	platform
+------------+----------+
| spend_date | platform |
+------------+----------+
| 2019-07-01 | desktop  |
| 2019-07-02 | desktop  |
| 2019-07-03 | desktop  |
| 2019-07-01 | mobile   |
| 2019-07-02 | mobile   |
| 2019-07-03 | mobile   |
| 2019-07-01 | both     |
| 2019-07-02 | both     |
| 2019-07-03 | both     |
+------------+----------+
*/
select dt.spend_date,dt.platform,coalesce(sum(total_amount),0) as total_amount,count(user_id) as total_users
from
(select user_id, spend_date, if(ct = 2, "both", platform) as platform, total_amount
    from
        (select user_id, spend_date, count(user_id) as ct, platform, sum(amount) as total_amount
        from spending
        group by user_id, spend_date
        ) a
    )b
right join 
    (select distinct(spend_date), 'desktop' platform from Spending
    union
    select distinct(spend_date), 'mobile' platform from Spending
    union
    select distinct(spend_date), 'both' platform from Spending
    ) dt
on b.spend_date = dt.spend_date and b.platform = dt.platform
group by dt.spend_date, dt.platform;
 
    
