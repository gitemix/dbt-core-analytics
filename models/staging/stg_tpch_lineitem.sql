{{ config(
    materialized='incremental',
    unique_key='lineitem_key'
) }}

SELECT
    {{ dbt_utils.generate_surrogate_key(['l_orderkey','l_linenumber']) }} AS lineitem_key,
    l_orderkey AS order_key,
    l_partkey AS part_key,
    l_suppkey AS supplier_key,
    l_linenumber,
    {{ to_whole_number('l_quantity') }}AS quantity,
    l_extendedprice,
    l_discount,
    l_tax,
    l_returnflag,
    l_linestatus,
    l_shipdate,
    l_commitdate,
    l_receiptdate
FROM {{ source('tpch_source', 'lineitem') }}

{% if is_incremental() %}
WHERE l_shipdate >= (SELECT MAX(l_shipdate) FROM {{ this }})
{% endif %}
