{{ config(schema='staging') }}

-- silver query
SELECT
  "CRASH DATE" AS crash_date,
  CAST("CRASH TIME" AS VARCHAR) AS crash_time,
  CAST("CRASH DATE" + "CRASH TIME" AS TIMESTAMPTZ) AS crash_timestamp,
  CAST(LATITUDE AS DECIMAL(9,6)) AS latitude,
  CAST(LONGITUDE AS DECIMAL(9,6)) AS longitude,
  LOCATION AS location,
  BOROUGH AS borough,
  IFNULL(UPPER("ON STREET NAME"),'STREET UNKNOWN') AS on_street_name,
  IFNULL(UPPER("CROSS STREET NAME"),'CROSS STREET UNKNOWN') AS cross_street_name,
  IFNULL(UPPER("OFF STREET NAME"),'OFF STREET UNKNOWN') AS off_street_name,
  "NUMBER OF PERSONS INJURED" AS number_of_persons_injured,
  "NUMBER OF PERSONS KILLED" AS number_of_persons_killed,
  "NUMBER OF PEDESTRIANS INJURED" AS number_of_pedestrians_injured,
  "NUMBER OF PEDESTRIANS KILLED" AS number_of_pedestrians_killed,
  "NUMBER OF CYCLIST INJURED" AS number_of_cyclist_injured,
  "NUMBER OF CYCLIST KILLED" AS number_of_cyclist_killed,
  "NUMBER OF MOTORIST INJURED" AS number_of_motorist_injured,
  "NUMBER OF MOTORIST KILLED" AS number_of_motorist_killed,
  UPPER("CONTRIBUTING FACTOR VEHICLE 1") AS contributing_factor_vehicle_1,
  UPPER("CONTRIBUTING FACTOR VEHICLE 2") AS contributing_factor_vehicle_2,
  UPPER("CONTRIBUTING FACTOR VEHICLE 3") AS contributing_factor_vehicle_3,
  UPPER("CONTRIBUTING FACTOR VEHICLE 4") AS contributing_factor_vehicle_4,
  UPPER("CONTRIBUTING FACTOR VEHICLE 5") AS contributing_factor_vehicle_5,
  COLLISION_ID AS collision_id,
  UPPER("VEHICLE TYPE CODE 1") AS vehicle_type_code_1,
  UPPER("VEHICLE TYPE CODE 2") AS vehicle_type_code_2,
  UPPER("VEHICLE TYPE CODE 3") AS vehicle_type_code_3,
  UPPER("VEHICLE TYPE CODE 4") AS vehicle_type_code_4,
  UPPER("VEHICLE TYPE CODE 5") AS vehicle_type_code_5
FROM {{ source('bronze_lakehouse', 'collisions') }};
--FROM read_csv('vehicle_collisions.csv', types={'ZIP CODE': 'VARCHAR'});
