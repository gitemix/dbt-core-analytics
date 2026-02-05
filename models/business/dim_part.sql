{{ config(materialized='table') }}

SELECT
    part_key,
    p_name   AS product_name,
    p_brand  AS brand,
    p_type   AS type,
    p_size   AS size
FROM {{ ref('stg_tpch_part') }}
