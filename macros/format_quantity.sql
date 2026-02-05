{% macro to_whole_number(column_name) %}
    cast({{ column_name }} as integer)
{% endmacro %}