{{ config(merge_schema='true') }}

WITH source_date_range AS (
    SELECT
        MIN(crash_date) AS min_date,
        CURRENT_DATE + INTERVAL 30 DAY AS max_date
    FROM {{ ref('collisions') }}
),

date_series AS (
    SELECT
        CAST(d AS DATE) AS calendar_date
    FROM source_date_range,
        generate_series(
            CAST(min_date AS DATE),
            CAST(max_date AS DATE),
            INTERVAL 1 DAY
        ) AS t(d)
)
SELECT
    calendar_date AS full_date,
    EXTRACT(YEAR FROM calendar_date) AS year_number,
    EXTRACT(MONTH FROM calendar_date) AS month_number,
    EXTRACT(DAY FROM calendar_date) AS day_number,
    strftime(calendar_date, '%b') AS month_name,
    strftime(calendar_date, '%a') AS day_name,
    CONCAT(strftime(calendar_date, '%b'), ' ', EXTRACT(YEAR FROM calendar_date)) AS month_year,
    EXTRACT(YEAR FROM calendar_date) * 100 + EXTRACT(MONTH FROM calendar_date) AS month_year_sort,
    DATE_PART('week', calendar_date) AS week_of_year,
    EXTRACT(DOW FROM calendar_date) AS day_of_week,
    CASE
        WHEN EXTRACT(ISODOW FROM calendar_date) IN (6, 7) THEN TRUE
        ELSE FALSE
    END AS is_weekend,
    CASE
        WHEN EXTRACT(ISODOW FROM calendar_date) IN (6, 7) THEN FALSE
        ELSE TRUE
    END AS is_weekday,
    CAST(DATE_TRUNC('month', calendar_date) AS DATE) AS month_start_date,
    CAST(DATE_TRUNC('year', calendar_date) AS DATE) AS year_start_date,
    EXTRACT(YEAR FROM calendar_date) * 10000 +
    EXTRACT(MONTH FROM calendar_date) * 100 +
    EXTRACT(DAY FROM calendar_date) AS dim_date_sk,
    CURRENT_TIMESTAMP AS load_date
FROM date_series
ORDER BY calendar_date;
