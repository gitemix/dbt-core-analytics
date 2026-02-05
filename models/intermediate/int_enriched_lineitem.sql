{{ config(materialized='view') }}

SELECT
    li.lineitem_key,
    li.order_key,
    li.part_key,
    li.supplier_key,
    li.l_shipdate,
    li.quantity,

    li.l_extendedprice AS gross_amount,
    li.l_extendedprice * (1 - li.discount) AS net_amount,
    li.discount,
    li.tax,

    p.part_name,
    p.brand,
    s.supplier_name,
    ps.supply_cost
FROM {{ ref('stg_tpch_lineitem') }} li
JOIN {{ ref('stg_tpch_part') }} p
  ON li.part_key = p.part_key
JOIN {{ ref('stg_tpch_supplier') }} s
  ON li.supplier_key = s.supplier_key
LEFT JOIN {{ ref('stg_tpch_partsupp') }} ps
  ON li.part_key = ps.part_key
 AND li.supplier_key = ps.supplier_key
