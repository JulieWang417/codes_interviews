'''
Several friends at a cinema ticket office would like to reserve consecutive available seats.
Can you help to query all the consecutive available seats order by the seat_id using the following cinema table?

seat_id	free
1	1
2	0
3	1
4	1
5	1
Your query should return the following result for the sample case above.

seat_id
3
4
5
'''

SELECT a.seat_id
FROM cinema a, cinema b
WHERE ABS(a.seat_id-b.seat_id) = 1 and a.free = 1 and b.free = 1
ORDER BY a.seat_id;
