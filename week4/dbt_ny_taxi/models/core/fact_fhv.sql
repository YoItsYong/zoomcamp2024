{{
    config(
        materialized='table'
    )
}}

with fhv_tripdata as (
    select *,
        'FHV' as service_type
    from {{ ref('stg_fhv_taxi_data_2019') }}
),
dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select fhv_tripdata.tripid, 
    fhv_tripdata.service_type,
    fhv_tripdata.pickup_locationid, 
    fhv_tripdata.dropoff_locationid,
    fhv_tripdata.pickup_datetime, 
    fhv_tripdata.dropoff_datetime,
    pickup_zone.borough as pickup_borough,
    pickup_zone.zone as pickup_zone,
    dropoff_zone.zone as dropoff_zone,  

from fhv_tripdata
inner join dim_zones as pickup_zone
on fhv_tripdata.pickup_locationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on fhv_tripdata.dropoff_locationid = dropoff_zone.locationid

