{{ config(materialized='table') }}

SELECT
    ps_partkey AS part_key,
    ps_suppkey AS supplier_key,
    ps_availqty AS available_quantity,
    ps_supplycost AS supply_cost
FROM {{ source('tpch_source', 'partsupp') }}
