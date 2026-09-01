use inventory_demand

SELECT *
FROM inventory_demand;

Query 1 — Overall inventory
SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT product_id) AS total_products,
    COUNT(DISTINCT store_id) AS total_stores,
    SUM(current_stock) AS total_stock,
    ROUND(AVG(daily_demand), 2) AS avg_daily_demand,
    ROUND(SUM(inventory_value), 2) AS total_inventory_value,
    ROUND(SUM(potential_revenue_loss), 2) AS potential_revenue_loss
FROM inventory_demand;


Query 2 — Stockout risk
SELECT
    stockout_risk,
    COUNT(*) AS item_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM inventory_demand),
        2
    ) AS percentage
FROM inventory_demand
GROUP BY stockout_risk
ORDER BY item_count DESC;



Query 3 — High-risk inventory
SELECT
    product_id,
    store_id,
    category,
    region,
    current_stock,
    daily_demand,
    lead_time_days,
    supplier_reliability_score,
    stockout_risk_score,
    potential_revenue_loss
FROM inventory_demand
WHERE stockout_risk = 'High'
ORDER BY potential_revenue_loss DESC;


Query 4 — Category performance
SELECT
    category,
    SUM(current_stock) AS total_stock,
    ROUND(AVG(daily_demand), 2) AS avg_demand,
    ROUND(AVG(stockout_risk_score), 2) AS avg_risk,
    ROUND(SUM(inventory_value), 2) AS inventory_value,
    ROUND(SUM(potential_revenue_loss), 2) AS revenue_loss
FROM inventory_demand
GROUP BY category
ORDER BY revenue_loss DESC;


Query 5 — Regional performance
SELECT
    region,
    SUM(current_stock) AS total_stock,
    ROUND(AVG(daily_demand), 2) AS avg_demand,
    ROUND(AVG(stockout_risk_score), 2) AS avg_risk,
    ROUND(SUM(potential_revenue_loss), 2) AS revenue_loss
FROM inventory_demand
GROUP BY region
ORDER BY revenue_loss DESC;


Query 6 — Supplier performance
SELECT
    supplier_id,
    ROUND(AVG(supplier_reliability_score), 2) AS reliability,
    ROUND(AVG(lead_time_days), 2) AS avg_lead_time,
    ROUND(AVG(stockout_risk_score), 2) AS avg_risk,
    ROUND(SUM(potential_revenue_loss), 2) AS revenue_loss
FROM inventory_demand
GROUP BY supplier_id
ORDER BY avg_risk DESC;


