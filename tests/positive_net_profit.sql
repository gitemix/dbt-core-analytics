-- This test fails if any row shows a net profit less than zero
-- (Assuming your business logic says you never sell at a loss)
SELECT
    order_key,
    net_profit
FROM {{ ref('fact_sales') }}
WHERE net_profit < 0