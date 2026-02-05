{{ config(materialized='table') }}

SELECT DISTINCT
    customer_key,
    market_segment,
    nation_name,
    region_name
FROM {{ ref('int_enriched_orders') }}
