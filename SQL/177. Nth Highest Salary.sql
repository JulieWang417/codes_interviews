"""
+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
For example, given the above Employee table, the query should return 200 as the second highest salary. If there is no second highest salary, then the query should return null.
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
Solution:
OFFSET 1: 从第一条数据之后开始读取
LIMIT 1: 读1条数据
Because there is maybe only one record in table Employee, we can use a temp table and then select from it.
"""

SELECT (SELECT salary 
        FROM Employee
        ORDER BY Salary DESC
        LIMIT 1 OFFSET N-1

    ) as NHighestSalary;