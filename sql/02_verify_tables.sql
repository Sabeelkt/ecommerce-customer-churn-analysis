-- Day 2 verification queries
USE churn_project;

-- Check all 3 tables exist
SHOW TABLES;

-- Verify row counts
SELECT COUNT(*) as total_rows FROM orders_raw;
SELECT COUNT(*) as total_rows FROM orders_clean;
SELECT COUNT(*) as total_rows FROM rfm_features;

-- Preview RFM features
SELECT * FROM rfm_features LIMIT 10;

-- Quick business insight from RFM
SELECT
    MIN(recency)  as best_recency,
    MAX(recency)  as worst_recency,
    AVG(recency)  as avg_recency,
    MIN(monetary) as lowest_spend,
    MAX(monetary) as highest_spend,
    AVG(monetary) as avg_spend
FROM rfm_features;