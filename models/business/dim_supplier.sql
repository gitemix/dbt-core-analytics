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
        {{ gen_surkey(['s.supplier_key']) }} AS dim_supplier_key,
        s.supplier_key,
        s.supplier_name,
        s.address,
        n.nation_name,
        r.region_name,
        s.phone_number,
        s.account_balance,
        -- Audit column
        {{ dbt_utils.current_timestamp() }} AS dbt_loaded_at
    FROM suppliers s
    LEFT JOIN nations n 
        ON s.nation_key = n.nation_key
    LEFT JOIN regions r 
        ON n.region_key = r.region_key
)

SELECT * FROM final