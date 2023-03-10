# Q.1. How many burgers were ordered?

SELECT 
    COUNT(*) AS 'no of orders'
FROM
    runner_orders;
# Q2. How many unique customer orders were made?
    
SELECT 
    COUNT(DISTINCT customer_id) AS 'no of unique customer'
FROM
    customer_orders;
# Q3. How many successful orders were delivered by each runner?

SELECT 
    runner_id,
    COUNT(DISTINCT order_id) AS 'no. of successful order'
FROM
    runner_orders
WHERE
    cancellation IS NULL
GROUP BY runner_id;

# Q.4. How many of each type of burger was delivered?

SELECT 
    B.BURGER_NAME,
    COUNT(C.BURGER_ID) AS 'DELIVERED BURGER COUNT'
FROM
    customer_orders C
        JOIN
    burger_names B ON B.burger_id = C.burger_id
        JOIN
    runner_orders R ON C.order_id = R.order_id
WHERE
    R.distance IS NOT NULL
GROUP BY C.burger_id;

# Q.5. How many Vegetarian and Meatlovers were ordered by each customer?

SELECT 
    C.customer_id, B.BURGER_NAME, COUNT(C.BURGER_ID)
FROM
    customer_orders C
        JOIN
    burger_names B ON B.BURGER_ID = C.BURGER_ID
GROUP BY C.customer_id , B.burger_name
ORDER BY C.customer_id;

# Q6. What was the maximum number of burgers delivered in a single order?

WITH burger_count_cte AS
(
 SELECT c.order_id, COUNT(c.burger_id) AS burger_per_order
 FROM customer_orders AS c
 JOIN runner_orders AS r
  ON c.order_id = r.order_id
 WHERE r.distance != 0
 GROUP BY c.order_id
)
SELECT MAX(burger_per_order) AS burger_count
FROM burger_count_cte;

# Q7. For each customer, how many delivered burgers had at least 1 change and how many had no changes?

SELECT 
    c.customer_id,
    SUM(CASE
        WHEN c.exclusions <> ' ' OR c.extras <> ' ' THEN 1
        ELSE 0
    END) AS at_lease_1_change,
    SUM(CASE
        WHEN c.exclusions = ' ' AND c.extras = ' ' THEN 1
        ELSE 0
    END) AS no_changes
FROM
    customer_orders c
        JOIN
    runner_orders r ON r.order_id = c.order_id
WHERE
    distance != 0
GROUP BY c.customer_id;

# Q8. What was the total volume of burgers ordered for each hour of the day?

SELECT 
    EXTRACT(HOUR FROM ORDER_TIME) AS HOUR_OF_DAY,
    COUNT(BURGER_ID) AS BURGER_COUNT
FROM
    customer_orders
GROUP BY HOUR_OF_DAY
ORDER BY HOUR_OF_DAY;

# Q9. How many runners signed up for each 1 week period? 

SELECT 
    EXTRACT(WEEK FROM REGISTRATION_DATE) AS WEEK_NO,
    COUNT(RUNNER_ID)
FROM
    burger_runner
GROUP BY WEEK_NO;

# Q10.What was the average distance travelled for each customer?

SELECT 
    C.CUSTOMER_ID, AVG(R.DISTANCE)
FROM
    customer_orders C
        JOIN
    runner_orders R ON C.order_id = R.order_id
GROUP BY C.customer_id;


















