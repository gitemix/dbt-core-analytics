{% test is_positive(model, column_name) %}
with validation_error AS(    
    select {{column_name}} as amount
    from {{ model }}
    where {{ column_name }} < 0)
{% endtest %}