{{ config(materialized='table') }}

SELECT DISTINCT
    customer_key,
    market_segment,
    nation_name,
    region_name
    {{ dbt.current_timestamp() }} AS dbt_loaded_at
FROM {{ ref('int_enriched_orders') }}
