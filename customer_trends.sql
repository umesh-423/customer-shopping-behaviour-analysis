select * from customer;

--Q1) Total revenue by gender
select gender, SUM(purchase_amount) AS revenue
from customer
group by gender;

--Q2) Which customers use discounts but paid more than avg purchare amt?
select customer_id, purchase_amount
from customer
where discount_applied = 'Yes' and purchase_amount >= (select AVG(purchase_amount) from customer)

--Q3) Top 5 products with highest avg review rating?
select item_purchased, ROUND(AVG(review_rating::numeric),2) as avg_review_rating
from customer
group by item_purchased
order by avg_review_rating DESC
limit 5;

--Q4) Compare avg purchase amount between standard and express shipping
select shipping_type, ROUND(AVG(purchase_amount),2) AS avg_purchase_amt
from customer
where shipping_type in ('Express','Standard')
group by shipping_type

--Q5) Do subscribed customers spend more? Compare avg spend and total revenue between subscribers and non-subscribers
select subscription_status, COUNT(customer_id) as total_customers, 
ROUND(AVG(purchase_amount),2) as avg_purchase_amt, 
SUM(purchase_amount) as total_revenue
from customer
group by subscription_status
order by total_revenue, avg_purchase_amt desc;

--Q6) Which 5 products have the highest % of purchase with discounts applied?
SELECT item_purchased,
ROUND(100.0 * SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS discount_rate
FROM customer
GROUP BY item_purchased
ORDER BY discount_rate DESC
LIMIT 5;

--Q7) Segment customers into new, returning and loyal based 
--on their total no of previous purchases
with customer_type as (
SELECT customer_id, previous_purchases,
CASE 
    WHEN previous_purchases = 1 THEN 'New'
    WHEN previous_purchases BETWEEN 2 AND 10 THEN 'Returning'
    ELSE 'Loyal'
    END AS customer_segment
FROM customer)

select customer_segment,count(*) AS "Number of Customers" 
from customer_type 
group by customer_segment;


--Q8) What are the top 3 most purchased products within each category?
WITH item_counts AS (
    SELECT category,
           item_purchased,
           COUNT(customer_id) AS total_orders,
           ROW_NUMBER() OVER (PARTITION BY category ORDER BY COUNT(customer_id) DESC) AS item_rank
    FROM customer
    GROUP BY category, item_purchased
)
SELECT item_rank,category, item_purchased, total_orders
FROM item_counts
WHERE item_rank <=3;


--Q9) Are customers who are repeat buyers (>5 purchases) also likely to subscribe?
select subscription_status, COUNT(customer_id) as total_customers
from customer
where previous_purchases > 5
group by subscription_status

--Q10) What is the revenue contibute of each age group?
select age_group, SUM(purchase_amount) as total_revenue
from customer
group by age_group