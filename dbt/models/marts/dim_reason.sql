{{ config(merge_schema='true') }}

SELECT DISTINCT
  reason,
  dim_reason_sk,
  CURRENT_TIMESTAMP AS load_date
FROM {{ ref('collision_reason') }};