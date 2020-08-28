
''' https://xingxingpark.com/Leetcode-1045-Customers-Who-Bought-All-Products/ '''


SELECT customer_id 
FROM Customer
GROUP BY customer_id
WHERE COUNT(distinct customer_id)=(SELECT COUNT(*) FROM Product);