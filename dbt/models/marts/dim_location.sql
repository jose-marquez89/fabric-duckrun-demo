{{ config(merge_schema='true') }}

SELECT DISTINCT
    latitude,
    longitude,
    location,
    borough,
    on_street_name,
    cross_street_name,
    off_street_name,
    {{ create_int_sk([
        'latitude',
        'longitude',
        'location',
        'borough',
        'on_street_name',
        'cross_street_name',
        'off_street_name']) }} AS dim_location_sk,
    CURRENT_TIMESTAMP AS load_date
FROM {{ ref('collisions') }};