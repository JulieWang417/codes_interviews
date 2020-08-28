Department Top Three Salaries

Description

The Employee table holds all employees. Every employee has an Id, and there is also a column for the department Id.

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
| 5  | Janet | 69000  | 1            |
| 6  | Randy | 85000  | 1            |
+----+-------+--------+--------------+
The Department table holds all departments of the company.

+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+
Write a SQL query to find employees who earn the top three salaries in each of the department. For the above tables, your SQL query should return the following rows.

+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Randy    | 85000  |
| IT         | Joe      | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |
+------------+----------+--------+
Load the database file db.sql to localhost MySQL. Relevant tables will be created in the LeetCode database.

mysql < db.sql -uroot -p
Observation

Make the following observation to interviewers. Confirm your observation is correct. Ask for clarification if necessary.

Are salary distinct for all employee? If not, must use DISTINCT keyword.
How to display if department has fewer than 3 distinct salaries?
Every employment belongs to a department? No employee has NULL in DepartmentId.
On Correctness

What does top-3 paid employees in each department have in common?

They have the same DepartmentId.
They have fewer than 3 persons who get paid higher salary (can use either < 3 or <= 2).
Department No. 1 has 0 above him.
Department No. 2 has 1 above him.
Department No. 3 has 2 above him. The conditions are set-up for correlated subquery. In subquery, we can use an equijoin (DepartmentId) and non-equijoin (Salary) to filter the outer query.
Basic MySQL solution implementing the equijoin and non-equijoin logic above.

SELECT
  d.Name AS 'Department'
  ,e.Name AS 'Employee'
  ,e.Salary
FROM Employee e
JOIN Department d
  ON e.DepartmentId = d.Id
WHERE
  (SELECT COUNT(DISTINCT e2.Salary)
  FROM
    Employee e2
  WHERE
    e2.Salary > e.Salary
      AND e.DepartmentId = e2.DepartmentId
      ) < 3;
On Efficiency

The subquery solution above enforces nested select, resulting in N+1 select statements and bad runtime efficiency. If we have access to window function (MS SQL solution, we can simply rank salary over each department as partition, and pick the top 3. Instead of using DISTINCT, the window solution uses DENSE_RANK(). Note that we cannot refer to window column rnk in the WHERE clause. So we must set up a temporary table.

-- MS SQL: window function version
WITH department_ranking AS (
SELECT
  e.Name AS Employee
  ,d.Name AS Department
  ,e.Salary
  ,DENSE_RANK() OVER (PARTITION BY DepartmentId ORDER BY Salary DESC) AS rnk
FROM Employee AS e
JOIN Department AS d
ON e.DepartmentId = d.Id
)
SELECT
  Department
  ,Employee
  ,Salary
FROM department_ranking
WHERE rnk <= 3
ORDER BY Department ASC, Salary DESC;
We can further improve efficiency by filtering the ranking before joining with the department table. Instead of joining every employee with his department, we now only join the department top-3 employees with their departments. This is accomplished with an additional temporary table.

-- MS SQL: Boosting effiency with pre-filtering
WITH department_ranking AS (
SELECT
  e.Name AS Employee
  ,e.Salary
  ,e.DepartmentId
  ,DENSE_RANK() OVER (PARTITION BY e.DepartmentId ORDER BY e.Salary DESC) AS rnk
FROM Employee AS e
)
-- pre-filter table to reduce join size
,top_three AS (
SELECT
  Employee
  ,Salary
  ,DepartmentId
FROM department_ranking 
WHERE rnk <= 3
)
SELECT
  d.Name AS Department
  ,e.Employee
  ,e.Salary
FROM top_three AS e
JOIN Department AS d
ON e.DepartmentId = d.Id
ORDER BY d.Name ASC, e.Salary DESC;
We can get rid of the second temporary table by moving the predicate condition rnk <=3 inside JOIN. The logic is the same as the code above: tables are filtered before joining. We want to reduce the table size before join.

-- MS SQL: cleaner version
WITH department_ranking AS (
SELECT
  e.Name AS Employee
  ,e.Salary
  ,e.DepartmentId
  ,DENSE_RANK() OVER (PARTITION BY e.DepartmentId ORDER BY e.Salary DESC) AS rnk
FROM Employee AS e
)
SELECT
  d.Name AS Department
  ,r.Employee
  ,r.Salary
FROM department_ranking AS r
JOIN Department AS d
  ON r.DepartmentId = d.Id
  AND r.rnk <= 3
ORDER BY d.Name ASC, r.Salary DESC;