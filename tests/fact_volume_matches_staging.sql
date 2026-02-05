-- The total quantity in the final Fact table must match the Staging table
-- This catches accidental inner-join filtering or fan-out (duplicates)
WITH staging_sum AS (
    SELECT SUM(quantity) as total_qty FROM {{ ref('stg_tpch_lineitem') }}
),
fact_sum AS (
    SELECT SUM(quantity) as total_qty FROM {{ ref('fact_sales') }}
)
SELECT 
    s.total_qty as staging_qty, 
    f.total_qty as fact_qty
FROM staging_sum s
JOIN fact_sum f ON 1=1
WHERE s.total_qty != f.total_qty