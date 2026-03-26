CREATE DATABASE IF NOT EXISTS churn_project;
USE churn_project;
SELECT COUNT(*) as total_rows FROM orders_raw;
SELECT * FROM orders_raw LIMIT 10;
DESCRIBE orders_raw;