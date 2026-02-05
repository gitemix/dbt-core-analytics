{{ config(
    materialized='table'
) }}

WITH dates AS (
    SELECT DISTINCT
        o.order_date AS date
    FROM {{ ref('int_enriched_orders') }} o

    UNION

    SELECT DISTINCT
        li.shipdate AS date
    FROM {{ ref('int_enriched_lineitem') }} li
)

SELECT
    TO_NUMBER(TO_CHAR(date, 'YYYYMMDD')) AS date_key,
    date,
    EXTRACT(DAY FROM date) AS day,
    EXTRACT(MONTH FROM date) AS month,
    TO_CHAR(date, 'Month') AS month_name,
    EXTRACT(QUARTER FROM date) AS quarter,
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(DOW FROM date) AS day_of_week,
    CASE WHEN EXTRACT(DOW FROM date) IN (0,6) THEN TRUE ELSE FALSE END AS is_weekend,
    {{ dbt_utils.current_timestamp() }} AS dbt_loaded_at
FROM dates
