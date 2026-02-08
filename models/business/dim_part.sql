{{ config(materialized='table') }}

SELECT
    part_key,
    part_name   AS product_name,
    brand,
    type,
    size,
    {{ dbt.current_timestamp() }} AS dbt_loaded_at
FROM {{ ref('stg_tpch_part') }}
