{{ config(merge_schema='true') }}

SELECT
    collision_id AS crash_id,
    crash_timestamp,
    number_of_persons_injured AS persons_injured,
    number_of_persons_killed AS persons_killed,
    number_of_pedestrians_injured AS pedestrians_injured,
    number_of_pedestrians_killed AS pedestrians_killed,
    number_of_cyclist_injured AS cyclists_injured,
    number_of_cyclist_killed AS cyclists_killed,
    number_of_motorist_injured AS motorists_injured,
    number_of_motorist_killed AS motorists_killed,
    {{ create_int_sk([
        'latitude',
        'longitude',
        'location',
        'on_street_name',
        'cross_street_name',
        'off_street_name'])
    }} AS dim_location_sk,
    {{ create_int_sk([
        'contributing_factor_vehicle_1',
        'contributing_factor_vehicle_2',
        'contributing_factor_vehicle_3',
        'contributing_factor_vehicle_4',
        'contributing_factor_vehicle_5'])
    }} AS dim_reason_sk,
    {{ create_int_sk([
        'vehicle_type_code_1',
        'vehicle_type_code_2',
        'vehicle_type_code_3',
        'vehicle_type_code_4',
        'vehicle_type_code_5'])
    }} AS dim_vehicle_type_sk,
    EXTRACT(YEAR FROM crash_date) * 10000 +
    EXTRACT(MONTH FROM crash_date) * 100 +
    EXTRACT(DAY FROM crash_date) AS dim_date_sk,
    CURRENT_TIMESTAMP AS load_date
FROM {{ ref('collisions') }}
ORDER BY crash_timestamp;