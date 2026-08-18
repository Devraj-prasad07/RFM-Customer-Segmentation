-- ============================================================
-- RFM Customer Segmentation - Business Analysis
-- ============================================================


-- ============================================================
-- 1. How many customers are in each RFM segment?
-- ============================================================

SELECT
    Segment,
    COUNT("Customer ID") AS customer_count
FROM customers_rfm
GROUP BY Segment
ORDER BY customer_count DESC;

-- INSIGHT:
-- Hibernating is the largest customer segment with 1,523 customers,
-- indicating that a significant portion of the customer base is
-- currently inactive.

-- ACTION:
-- The business should evaluate a reactivation/win-back strategy
-- to bring high-potential inactive customers back.


-- ============================================================
-- 2. Which segments contribute the most revenue?
-- ============================================================

SELECT
    Segment,
    SUM(Monetary) AS total_revenue
FROM customers_rfm
GROUP BY Segment
ORDER BY total_revenue DESC;

-- INSIGHT:
-- The Champions segment contributes the most revenue, generating
-- approximately ₹8.82 million in total customer spending.

-- ACTION:
-- The business should prioritize retention of Champions through
-- loyalty rewards, personalized engagement, and exclusive benefits
-- to protect their high revenue contribution.


-- ============================================================
-- 3. Which customer segments have the highest average customer spending?
-- ============================================================

SELECT
    Segment,
    ROUND(AVG(Monetary), 2) AS average_customer_spending
FROM customers_rfm
GROUP BY Segment
ORDER BY average_customer_spending DESC;

-- INSIGHT:
-- Champions have the highest average customer spending at
-- ₹11,909.57 per customer, indicating the highest average
-- customer value among all segments.

-- ACTION:
-- The business should prioritize Champions for retention through
-- loyalty rewards, personalized recommendations, and exclusive
-- benefits to increase customer lifetime value.


-- ============================================================
-- 4. Who are the top 5 Champions by monetary value?
-- ============================================================

SELECT
    "Customer ID",
    Monetary AS monetary_value
FROM customers_rfm
WHERE Segment = 'Champions'
ORDER BY monetary_value DESC
LIMIT 5;

-- INSIGHT:
-- The top 5 Champions have exceptionally high historical monetary
-- value, with Customer 18102 contributing ₹580,987.04, the highest
-- individual monetary value among Champions.

-- ACTION:
-- The business should prioritize these high-value Champions through
-- VIP loyalty programs, personalized engagement, exclusive benefits,
-- and proactive retention strategies to maximize customer lifetime value.


-- ============================================================
-- 5. How many high-value customers are At Risk?
-- ============================================================

SELECT
    COUNT("Customer ID") AS high_value_at_risk_customers
FROM customers_rfm
WHERE Segment = 'At Risk'
  AND Monetary > (
      SELECT AVG(Monetary)
      FROM customers_rfm
  );

-- INSIGHT:
-- The analysis identifies At Risk customers whose historical
-- monetary value is above the overall customer average, representing
-- a potentially important revenue-retention opportunity.

-- ACTION:
-- The business should prioritize these high-value At Risk customers
-- for targeted win-back campaigns, personalized offers, and retention
-- initiatives to reduce potential revenue loss and encourage repeat purchases.


-- ============================================================
-- 6. Which customer segments should the business prioritize?
-- ============================================================

SELECT
    Segment,
    COUNT("Customer ID") AS customer_count,
    ROUND(SUM(Monetary), 2) AS total_revenue,
    ROUND(AVG(Monetary), 2) AS average_customer_spending,
    ROUND(AVG(Recency), 2) AS average_recency,
    ROUND(AVG(Frequency), 2) AS average_frequency
FROM customers_rfm
GROUP BY Segment
ORDER BY total_revenue DESC;

-- INSIGHT:
-- Champions and Loyal Customers should be prioritized for retention
-- because they generate the majority of total revenue. At Risk and
-- Potential Loyalists represent important opportunities for win-back
-- and customer development.

-- ACTION:
-- Protect high-value Champions and Loyal Customers through retention
-- and loyalty initiatives, while using targeted win-back campaigns
-- for At Risk customers and engagement strategies to convert
-- Potential Loyalists into higher-value customers.


-- ============================================================
-- 7. Who are the top 10 customers by monetary value?
-- ============================================================

SELECT
    "Customer ID",
    Monetary AS monetary_value
FROM customers_rfm
ORDER BY monetary_value DESC
LIMIT 10;

-- INSIGHT:
-- The top 10 customers have the highest historical monetary value
-- in the customer base, making them the most valuable individual
-- customers based on total spending.

-- ACTION:
-- The business should prioritize these customers through VIP loyalty
-- programs, personalized engagement, exclusive benefits, and proactive
-- retention strategies to maximize customer lifetime value.


-- ============================================================
-- 8. What percentage of total revenue comes from each segment?
-- ============================================================

SELECT
    Segment,
    ROUND(
        100.0 * SUM(Monetary)
        / SUM(SUM(Monetary)) OVER(),
        2
    ) AS revenue_percentage
FROM customers_rfm
GROUP BY Segment
ORDER BY revenue_percentage DESC;

-- INSIGHT:
-- Champions contribute 50.79% of total revenue, while Loyal Customers
-- contribute another 28.02%. Together, these two segments generate
-- 78.81% of total revenue, indicating that revenue is highly
-- concentrated among the business's most valuable customer segments.

-- ACTION:
-- The business should prioritize retention of Champions and Loyal
-- Customers through loyalty programs, personalized engagement, and
-- exclusive benefits, while developing targeted strategies to move
-- Potential Loyalists and At Risk customers into higher-value segments.