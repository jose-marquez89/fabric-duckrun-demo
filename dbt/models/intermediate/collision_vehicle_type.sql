{{ config(merge_schema='true') }}

WITH vehicle_types AS (
    SELECT
        collision_id,
        UNNEST(
            LIST_DISTINCT([
                vehicle_type_code_1,
                vehicle_type_code_2,
                vehicle_type_code_3,
                vehicle_type_code_4,
                vehicle_type_code_5
            ])
        ) AS vehicle_type
    FROM {{ ref('collisions') }}
),

dim AS (
    SELECT
        collision_id,
        UPPER(vehicle_type) AS vehicle_type
    FROM vehicle_types
)

SELECT *,
    {{ create_int_sk('vehicle_type') }} AS dim_vehicle_type_sk
FROM vehicle_types;