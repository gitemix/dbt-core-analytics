{{ config(materialized='table') }}

SELECT
    part_key,
    part_name   AS product_name,
    brand,
    type,
    size
FROM {{ ref('stg_tpch_part') }}
