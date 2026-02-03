{{ config(materialized='table') }}

SELECT
    o_orderkey AS order_key,
    o_custkey AS customer_key,
    o_orderstatus AS order_status,
    o_totalprice AS total_price,
    o_orderdate AS order_date,
    o_orderpriority AS order_priority
FROM {{ source('tpch_source', 'orders') }}
