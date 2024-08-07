use pizza_sales;
SELECT * FROM order_details;
SELECT * FROM orders;
SELECT * FROM pizza_types;
SELECT * FROM pizzas;

-- Q1: The total number of order placed
SELECT COUNT(distinct order_details_id) AS total_orders
FROM order_details;

SELECT order_id,
       DATE_FORMAT(date, '%Y/%m/%d') AS formatted_date,
       TIME_FORMAT(time, '%H:%i:%s') AS formatted_time
FROM orders;

-- Q2: The total revenue generated from pizza sales

SELECT round(SUM(od.quantity * p.price),0) AS total_revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id;

-- Q3: The highest priced pizza.

SELECT pt.name, p.size, p.price
FROM pizzas p
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;

-- Q4: The most common pizza size ordered.

SELECT p.size, COUNT(*) AS order_count
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY order_count DESC;

-- Q5: The top 5 most ordered pizza types along their quantities.

SELECT pt.name, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 5;

-- LEAST ORDERED PIZZA TYPES
SELECT pt.name, SUM(od.quantity) AS total_quantity, category
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name, category
ORDER BY total_quantity asc
LIMIT 5;

-- Q6: The quantity of each pizza categories ordered.

SELECT pt.category, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
order by total_quantity desc;

-- Q7: The distribution of orders by hours of the day.

SELECT HOUR(time) AS hour_of_day, COUNT(*) AS order_count
FROM orders
GROUP BY HOUR(time)
ORDER BY hour_of_day;

-- Q8: The category-wise distribution of pizzas. Variety!

SELECT category, COUNT(*) AS types_of_pizza
FROM pizzas p
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
order by types_of_pizza;
SELECT * FROM PIZZA_TYPES;

-- Q9: The average number of pizzas ordered per day.

WITH day_names AS (
    SELECT 1 AS day_num, 'Sunday' AS day_name
    UNION SELECT 2, 'Monday'
    UNION SELECT 3, 'Tuesday'
    UNION SELECT 4, 'Wednesday'
    UNION SELECT 5, 'Thursday'
    UNION SELECT 6, 'Friday'
    UNION SELECT 7, 'Saturday'
)
SELECT 
    dn.day_num,
    dn.day_name,
    round(AVG(daily_orders.orders_per_day),0) AS avg_orders_per_day
FROM (
    SELECT 
        DAYOFWEEK(date) AS day_of_week,
        COUNT(*) AS orders_per_day
    FROM orders
    GROUP BY date
) daily_orders
JOIN day_names dn ON daily_orders.day_of_week = dn.day_num
GROUP BY dn.day_num, dn.day_name
ORDER BY dn.day_num;

-- Q10: Top 3 most ordered pizza type based on revenue

SELECT pt.name, SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_revenue DESC
LIMIT 3;
select * from pizzas;
select * from pizza_types;

SELECT pt.category, SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_revenue DESC;


-- Price range by category
SELECT pt.category, 
       MIN(p.price) as min_price, 
       MAX(p.price) as max_price
FROM pizzas p
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

-- Q11: The percentage contribution of each pizza type to revenue

WITH total_revenue AS (
    SELECT SUM(od.quantity * p.price) AS total
    FROM order_details od
    JOIN pizzas p ON od.pizza_id = p.pizza_id
)
SELECT pt.name, (SUM(od.quantity * p.price) / tr.total) * 100 AS percentage_contribution
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
JOIN total_revenue tr
GROUP BY pt.name, tr.total
order by percentage_contribution desc;

-- Q12: The cumulative revenue generated over time.

SELECT distinct month(o.date) as Month, SUM(od.quantity * p.price)
OVER (ORDER BY month(o.date)) AS cumulative_revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
ORDER BY month(o.date);

-- Monthly Revenue

SELECT distinct month(o.date) as Month, SUM(od.quantity * p.price) AS monthly_revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
group by month(o.date)
ORDER BY month(o.date);


-- Q13: The top 3 most ordered pizza type based on revenue for each pizza category.

WITH ranked_pizzas AS (
    SELECT 
        pt.category,
        pt.name,
        SUM(p.price * o.quantity) AS Total_revenue,
        ROW_NUMBER() OVER (PARTITION BY pt.category ORDER BY SUM(p.price * o.quantity) DESC) AS rank1
    FROM 
        order_details o 
        JOIN pizzas p ON o.pizza_id = p.pizza_id 
        JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY 
        pt.category, pt.name
)
SELECT 
    category,
    name AS pizza_types,
    Total_revenue
FROM
    ranked_pizzas
WHERE
    rank1 <= 3
ORDER BY
    category, total_revenue DESC;