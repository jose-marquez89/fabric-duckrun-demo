{% macro generate_schema_name(custom_schema_name, node) %}
    {{ log("CUSTOM generate_schema_name CALLED", info=True)}}
    {{ custom_schema_name or target.schema }}
{% endmacro %}