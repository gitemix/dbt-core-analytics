{% macro to_dollars(column_name, decimal_places=2) -%}
    -- Converts numeric values to a decimal dollar format
    cast({{ column_name }} as decimal(16, {{ decimal_places }}))
{%- endmacro %}