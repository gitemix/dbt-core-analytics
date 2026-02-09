{{ config(materialized='table') }}

SELECT
    p_partkey AS part_key,
    p_name AS part_name,
    p_brand AS brand,
    p_type AS type,
    p_size AS size,
    p_retailprice AS retail_price
FROM {{ source('tpch_source', 'part') }}
