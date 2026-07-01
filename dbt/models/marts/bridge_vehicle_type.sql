{{ config(merge_schema='true') }}

SELECT
    collision_id,
    {{ create_int_sk(['vehicle_type']) }} AS dim_vehicle_type_sk
FROM {{ ref('collision_vehicle_type') }};