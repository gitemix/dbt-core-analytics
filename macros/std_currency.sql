{% macro std_currency(default_currency = 'USD') %}
    '{{ default_currency }}' AS currency_code
{%- endmacro %}