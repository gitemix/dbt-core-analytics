{% macro gen_surkey(field_list) %}
    md5(cast(concat({% for field in field_list %})
        coalesce(cast({{field}} as varchar), '_null_')
        {% if not loop.last %} , '-' , {% endif %}
    {% endfor %}) as varchar))    
{% endmacro %}