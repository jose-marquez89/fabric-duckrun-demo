{{ config(schema_mode='overwrite') }}

SELECT
    collision_id,
    crash_timestamp AS collision_timestamp,
    number_of_persons_injured AS persons_injured,
    number_of_persons_killed AS persons_killed,
    number_of_pedestrians_injured AS pedestrians_injured,
    number_of_pedestrians_killed AS pedestrians_killed,
    number_of_cyclist_injured AS cyclists_injured,
    number_of_cyclist_killed AS cyclists_killed,
    number_of_motorist_injured AS motorists_injured,
    number_of_motorist_killed AS motorists_killed,
    latitude,
    longitude,
    {{ create_int_sk([
        'location',
        'borough',
        'on_street_name',
        'cross_street_name',
        'off_street_name'])
    }} AS dim_location_sk,
    EXTRACT(YEAR FROM crash_date) * 10000 +
    EXTRACT(MONTH FROM crash_date) * 100 +
    EXTRACT(DAY FROM crash_date) AS collision_date_sk,
    CURRENT_TIMESTAMP AS load_date
FROM {{ ref('collisions') }}
ORDER BY crash_timestamp;