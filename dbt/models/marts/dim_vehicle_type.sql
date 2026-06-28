{{ config(merge_schema='true') }}

SELECT DISTINCT
  vehicle_type,
  dim_vehicle_type_sk,
  CURRENT_TIMESTAMP AS load_date
FROM {{ ref('collision_vehicle_type') }};