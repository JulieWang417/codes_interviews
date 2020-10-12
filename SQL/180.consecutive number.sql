'''
Write a SQL query to find all numbers that appear at least three times consecutively.

1
2
3
4
5
6
7
8
9
10
11
+----+-----+
| Id | Num |
+----+-----+
| 1  |  1  |
| 2  |  1  |
| 3  |  1  |
| 4  |  2  |
| 5  |  1  |
| 6  |  2  |
| 7  |  2  |
+----+-----+
For example, given the above Logs table, 1 is the only number that appears consecutively for at least three times.

1
2
3
4
5
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
'''

SELECT L1.Num as ConsecutiveNums
FROM Logs L1, Logs L2, Logs L3
WHERE L1.Id =L2.Id+1 AND L2.Id=L3.Id + 1 AND L1.Num=L2.Num And L2.Num=L3.Num


