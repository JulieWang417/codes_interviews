'''
The Employee table holds all employees. Every employee has an Id, a salary, and there is also a column for the department Id.

1
2
3
4
5
6
7
8
+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
The Department table holds all departments of the company.

1
2
3
4
5
6
+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+
Write a SQL query to find employees who have the highest salary in each of the departments. For the above tables, Max has the highest salary in the IT department and Henry has the highest salary in the Sales department.

1
2
3
4
5
6
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| Sales      | Henry    | 80000  |
+------------+----------+--------+
'''
SELECT D.Name AS Department, E.Name AS Employee,E.Salary
FROM Department D, Employee E, (SELECT DepartmentId,MAX(Salary) as max FROM Employee GROUP BY DepartmentId) T
WHERE E.DepartmentId = D.id AND E.Salary = T.max  AND E.DepartmentId = T.DepartmentId



SELECT d.Name AS Department, e.Name AS Employee, e.Salary
FROM Employee AS e, Department AS d
WHERE e.DepartmentId = d.Id AND
e.Salary = (SELECT MAX(Salary) FROM Employee AS t WHERE t.DepartmentId = e.DepartmentId);


