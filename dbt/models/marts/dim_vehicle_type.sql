{{ config(merge_schema='true') }}

SELECT DISTINCT
  vehicle_type_code_1 AS vehicle_type_1,
  vehicle_type_code_2 AS vehicle_type_2,
  vehicle_type_code_3 AS vehicle_type_3,
  vehicle_type_code_4 AS vehicle_type_4,
  vehicle_type_code_5 AS vehicle_type_5,
  {{ create_int_sk([
      'vehicle_type_code_1',
      'vehicle_type_code_2',
      'vehicle_type_code_3',
      'vehicle_type_code_4',
      'vehicle_type_code_5'
  ]) }} AS dim_vehicle_type_sk,
  CURRENT_TIMESTAMP AS load_date
FROM {{ ref('collisions') }};