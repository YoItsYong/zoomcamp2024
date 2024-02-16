{{
    config(
        materialized='table'
    )
}}

with tripdata as (
    select *,
        row_number() over (partition by pickup_datetime) as rn
    from {{ source('staging', 'fhv_taxi_data_2019') }}

)
select
    -- identifiers
    {{ dbt_utils.generate_surrogate_key(['pickup_datetime']) }} as tripid,    
    {{ dbt.safe_cast("PUlocationID", api.Column.translate_type("integer")) }} as pickup_locationid,
    {{ dbt.safe_cast("DOlocationID", api.Column.translate_type("integer")) }} as dropoff_locationid,
        

    -- timestamps
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropOff_datetime as timestamp) as dropoff_datetime,    

from tripdata
where rn = 1
        -- airport_fee,
        -- distance_between_service,
        -- time_between_service,
        -- data_file_year,
        -- data_file_month

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=false) %}

  limit 100

{% endif %}
