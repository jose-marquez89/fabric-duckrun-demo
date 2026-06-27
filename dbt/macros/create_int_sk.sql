{% macro create_int_sk(columns) %}
    CAST(CONCAT('0x', LEFT(MD5(CONCAT_WS('|',
        {% for column in columns %}
            {{ column }}{{ "," if not loop.last }}
        {% endfor %}
    )), 15)) AS BIGINT)
{% endmacro %}