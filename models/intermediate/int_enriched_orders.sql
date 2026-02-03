{{ config(materialized='view') }}

SELECT
    o.order_key,
    o.customer_key,
    o.order_date,
    o.order_status,
    o.total_price,
    c.market_segment,
    n.n_name AS nation_name,
    r.r_name AS region_name
FROM {{ ref('stg_tpch_orders') }} o
JOIN {{ ref('stg_tpch_customer') }} c
  ON o.customer_key = c.customer_key
JOIN {{ ref('stg_tpch_nation') }} n
  ON c.nation_key = n.nation_key
JOIN {{ ref('stg_tpch_region') }} r
  ON n.region_key = r.region_key
