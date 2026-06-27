{{ config(merge_schema='true') }}

SELECT DISTINCT
  contributing_factor_vehicle_1 AS reason_vehicle_1,
  contributing_factor_vehicle_2 AS reason_vehicle_2,
  contributing_factor_vehicle_3 AS reason_vehicle_3,
  contributing_factor_vehicle_4 AS reason_vehicle_4,
  contributing_factor_vehicle_5 AS reason_vehicle_5,
  {{ create_int_sk([
      'contributing_factor_vehicle_1',
      'contributing_factor_vehicle_2',
      'contributing_factor_vehicle_3',
      'contributing_factor_vehicle_4',
      'contributing_factor_vehicle_5'
  ]) }} AS dim_reason_sk,
  CURRENT_TIMESTAMP AS load_date
FROM {{ ref('collisions') }};