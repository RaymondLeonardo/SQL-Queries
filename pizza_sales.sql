-- KPI REQUIREMENTS
-- TOTAL REVENUE, AVERAGE ORDER VALUE, TOTAL PIZZA SOLD, TOTAL ORDERS, AVERAGE PIZZAS PER ORDER


SELECT * FROM pizza_sales

-- TOTAL REVENUE
SELECT SUM(total_price) AS total_revenue
FROM pizza_sales;

-- AVERAGE ORDER VALUE
SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS avg_order_value
FROM pizza_sales;

-- TOTAL PIZZA SOLD
SELECT SUM(quantity) AS total_pizzas_sold
FROM pizza_sales;

-- TOTAL ORDERS
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales;

-- AVERAGE PIZZAS PER ORDER
SELECT CAST(SUM(quantity) AS DECIMAL (10,2))/COUNT(DISTINCT order_id) AS avg_pizzas_per_order
FROM pizza_sales;


-- HOURLY TRENDS FOR TOTAL PIZZAS SOLD
SELECT 
	DATE_PART('HOUR', order_time) as order_hours, 
	SUM(quantity) as total_pizzas_sold
FROM pizza_sales
GROUP BY DATE_PART('HOUR', order_time)
ORDER BY DATE_PART('HOUR', order_time);

-- WEEKLY TRENDS FOR ORDERS
SELECT 
    EXTRACT(WEEK FROM order_date) AS WeekNumber,
    EXTRACT(YEAR FROM order_date) AS Year,
    COUNT(DISTINCT order_id) AS Total_orders
FROM 
    pizza_sales
GROUP BY 
    EXTRACT(WEEK FROM order_date),
    EXTRACT(YEAR FROM order_date)
ORDER BY 
    Year, WeekNumber;
	

-- PERCENTAGE SALES BY CATEGORY
SELECT 
	pizza_category, 
	CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS percentage
FROM pizza_sales
GROUP BY pizza_category;


-- PERCENTAGE SALES BY SIZE
SELECT 
	pizza_size, 
	CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS percentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;


-- TOTAL PIZZAS SOLD BY CATEGORY
SELECT 
	pizza_category, 
	SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC


-- TOP 5 PIZZAS BY REVENUE
SELECT
	pizza_name, 
	SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5;


-- 5 LOWEST PIZZAS REVENUE
SELECT
	pizza_name, 
	SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue
LIMIT 5;


-- TOP 5 PIZZAS BY QUANTITY SOLD
SELECT 
	pizza_name,
	SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5;

-- BOTTOM 5 PIZZAS BY QUANTITY SOLD
SELECT 
	pizza_name, 
	SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold
LIMIT 5;


-- TOP 5 PIZZAS BY TOTAL ORDERS
SELECT
	pizza_name,
	COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC
LIMIT 5;


-- BOTTOM 5 PIZZAS BY TOTAL ORDERS
SELECT
	pizza_name,
	COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders
LIMIT 5;