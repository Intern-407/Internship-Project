{% macro yes_no_to_boolean(column_expr) %}
    case
        when {{ column_expr }} = 'Yes' then true
        when {{ column_expr }} = 'No' then false
        else null
    end
{% endmacro %}
