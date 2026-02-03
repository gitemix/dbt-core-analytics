{{ config(materialized='table') }}

SELECT
    s_suppkey AS supplier_key,
    s_name AS supplier_name,
    s_nationkey AS nation_key,
    s_acctbal AS account_balance
FROM {{ source('tpch_source', 'supplier') }}
