{{ config(
    materialized='table'
) }}

WITH lineitems AS (
    SELECT
        li.lineitem_key,
        li.order_key,
        li.part_key,
        li.supplier_key,
        li.l_shipdate,
        li.quantity,
        li.gross_amount,
        li.net_amount
    FROM {{ ref('int_enriched_lineitem') }} li
),

orders AS (
    SELECT
        o.order_key,
        o.order_date,
        o.ship_priority,
        o.customer_key 
    FROM {{ ref('int_enriched_orders') }} o
),

fact_base AS (
    SELECT
        li.lineitem_key,
        li.order_key,
        li.part_key,
        li.supplier_key,
        li.l_shipdate,
        li.quantity,
        li.gross_amount,
        li.net_amount,
        o.order_date,
        o.customer_key,
        o.ship_priority
    FROM lineitems li
    LEFT JOIN orders o
        ON li.order_key = o.order_key
)

SELECT
    fb.lineitem_key,
    fb.order_key,
    
    -- Customer
    fb.customer_key AS customer_key,
    
    -- Product
    fb.part_key AS part_key,
    
    -- Supplier
    fb.supplier_key AS supplier_key,
    
    -- Dates (as foreign keys to dim_date)
    TO_NUMBER(TO_CHAR(fb.order_date, 'YYYYMMDD')) AS order_date_key,
    TO_NUMBER(TO_CHAR(fb.shipdate, 'YYYYMMDD')) AS ship_date_key,
    
    -- Metrics
    fb.quantity,
    fb.gross_amount,
    fb.net_amount,
    {{ std_currency() }},
    
    -- Audit
    {{ dbt.current_timestamp() }} AS dbt_loaded_at

FROM fact_base fb
