{{ config(merge_schema='true') }}

WITH contributing_factors AS (
    SELECT
        collision_id,
        UNNEST(
            LIST_DISTINCT([
                contributing_factor_vehicle_1,
                contributing_factor_vehicle_2,
                contributing_factor_vehicle_3,
                contributing_factor_vehicle_4,
                contributing_factor_vehicle_5
            ])
        ) AS reason
    FROM {{ ref('collisions') }}
),

dim AS ( 
    SELECT
        collision_id,
        UPPER(reason) AS reason
    FROM contributing_factors
)

SELECT *,
    {{ create_int_sk('reason') }} AS dim_reason_sk
FROM dim;
