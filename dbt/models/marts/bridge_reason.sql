{{ config(merge_schema='true') }}

SELECT
    collision_id,
    {{ create_int_sk('reason') }} AS dim_reason_sk
FROM {{ ref('collision_reason') }};
