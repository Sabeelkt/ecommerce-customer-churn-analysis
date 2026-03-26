USE churn_project;

SELECT
    -- Recency distribution
    MIN(recency)            as min_recency,
    MAX(recency)            as max_recency,
    ROUND(AVG(recency), 1)  as avg_recency,

    -- Frequency distribution
    MIN(frequency)            as min_frequency,
    MAX(frequency)            as max_frequency,
    ROUND(AVG(frequency), 1)  as avg_frequency,

    -- Monetary distribution
    MIN(monetary)            as min_monetary,
    MAX(monetary)            as max_monetary,
    ROUND(AVG(monetary), 2)  as avg_monetary

FROM rfm_features;

CREATE TABLE rfm_segments AS
WITH rfm_scored AS (
    SELECT
        customer_id,
        recency,
        frequency,
        monetary,
        aov,
        days_active,

        -- R score: lower recency = more recent = better = higher score
        NTILE(5) OVER (ORDER BY recency DESC)   as r_score,

        -- F score: higher frequency = better = higher score
        NTILE(5) OVER (ORDER BY frequency ASC)  as f_score,

        -- M score: higher monetary = better = higher score
        NTILE(5) OVER (ORDER BY monetary ASC)   as m_score

    FROM rfm_features
)
SELECT
    customer_id,
    recency,
    frequency,
    monetary,
    aov,
    days_active,
    r_score,
    f_score,
    m_score,

    -- Combined RFM score out of 15
    (r_score + f_score + m_score) as rfm_score,

    -- Segment label based on scores
    CASE
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4
            THEN 'Champion'
        WHEN r_score >= 3 AND f_score >= 3
            THEN 'Loyal'
        WHEN r_score >= 3 AND f_score <= 2
            THEN 'Promising'
        WHEN r_score <= 2 AND f_score >= 3
            THEN 'At Risk'
        WHEN r_score <= 2 AND f_score <= 2 AND m_score <= 2
            THEN 'Lost'
        ELSE
            'Needs Attention'
    END as segment

FROM rfm_scored;


-- Check how many customers in each segment
SELECT
    segment,
    COUNT(*)                    as customer_count,
    ROUND(COUNT(*) * 100.0
        / SUM(COUNT(*)) OVER(), 1) as percentage,
    ROUND(AVG(monetary), 2)    as avg_monetary,
    ROUND(AVG(recency), 1)     as avg_recency
FROM rfm_segments
GROUP BY segment
ORDER BY avg_monetary DESC;


-- Day 3 Key Findings:
-- 1. Champions (22.8%) spend 34x more than Lost customers (23.2%)
-- 2. At Risk segment: 708 customers, avg spend £2,148 — urgent win-back needed
-- 3. Cohort analysis shows 75% of new customers never return after first purchase
-- 4. December 2009 cohort retained best — 35% Month 1, still 20% at Month 24
-- 5. December 2010 cohort retained worst — only 9% Month 1