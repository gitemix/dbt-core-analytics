{{ config(
    materialized='table'
) }}

WITH geo_base AS (
    SELECT
        n.n_nationkey AS geography_key,
        n.n_name AS nation_name,
        r.r_name AS region_name
    FROM {{ source('tpch_source', 'nation') }} n
    LEFT JOIN {{ source('tpch_source', 'region') }} r
        ON n.n_regionkey = r.r_regionkey
)

SELECT
    geography_key,
    nation_name,
    region_name,
    {{ dbt_utils.current_timestamp() }} AS dbt_loaded_at
FROM geo_base
