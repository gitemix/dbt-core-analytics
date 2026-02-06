{{ config(
    materialized='table'
) }}

WITH suppliers AS (
    SELECT * FROM {{ ref('stg_tpch_supplier') }}
),

nations AS (
    SELECT * FROM {{ ref('stg_tpch_nation') }}
),

regions AS (
    SELECT * FROM {{ ref('stg_tpch_region') }}
),

final AS (
    SELECT
        -- Use your macro to create a unique surrogate key
        {{ dbt_utils.generate_surrogate_key(['supplier_key']) }} AS dim_supplier_key,
        s.supplier_key,
        s.supplier_name,
        n.nation_name,
        r.region_name,
        s.account_balance,
        -- Audit column
        {{ dbt.current_timestamp() }} AS dbt_loaded_at
    FROM suppliers s
    LEFT JOIN nations n 
        ON s.nation_key = n.nation_key
    LEFT JOIN regions r 
        ON n.region_key = r.region_key
)

SELECT * FROM final