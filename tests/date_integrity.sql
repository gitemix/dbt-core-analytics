
SELECT
    order_key,
    l_shipdate,
    l_commitdate,
    l_receiptdate
FROM {{ ref('stg_tpch_lineitem') }}
WHERE l_shipdate < l_receiptdate 
   OR l_commitdate < l_receiptdate