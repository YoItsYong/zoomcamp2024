Q3:
SELECT
	COUNT(1)
FROM
	green_taxi_data
WHERE
	Cast(lpep_pickup_datetime as DATE) = '2019-09-18' AND
	Cast(lpep_dropoff_datetime as DATE) = '2019-09-18'


Q4:
SELECT
	Cast(lpep_pickup_datetime as DATE),
	"trip_distance"
FROM
	green_taxi_data
WHERE
	Cast(lpep_pickup_datetime as DATE) = '2019-09-18' OR
	Cast(lpep_pickup_datetime as DATE) = '2019-09-16' OR
	Cast(lpep_pickup_datetime as DATE) = '2019-09-26' OR
	Cast(lpep_pickup_datetime as DATE) = '2019-09-21'
ORDER BY
	"trip_distance" DESC

Q5:
SELECT
	z."Borough",
	SUM(g.total_amount) as "SUM"
FROM
	green_taxi_data as g
LEFT JOIN
	zones as z
ON
	g."PULocationID" = z."LocationID"
WHERE
	CAST(lpep_pickup_datetime as DATE) = '2019-09-18'
GROUP BY
	z."Borough"
ORDER BY
	"SUM" DESC


Q6:
SELECT
	CAST(g.lpep_pickup_datetime as DATE),
	MAX(g.tip_amount),
	zpu."Zone" as ZPU,
	zdo."Zone" as ZPU
FROM
	green_taxi_data as g
LEFT JOIN
	zones as zpu
ON
	g."PULocationID" = zpu."LocationID"
LEFT JOIN
	zones as zdo
ON
	g."DOLocationID" = zdo."LocationID"
WHERE
	CAST(lpep_pickup_datetime as DATE) between '2019-09-01' AND '2019-09-30'
	AND
	zpu."Zone" LIKE 'Astoria'
GROUP BY
	CAST(g.lpep_pickup_datetime as DATE),
	g."DOLocationID",
	zpu."Zone",
	g.tip_amount,
	zdo."Zone"
ORDER BY
	MAX(g.tip_amount) DESC


Q7:
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:   + create  Terraform will perform the following actions:    # google_bigquery_dataset.dataset will be created   + resource "google_bigquery_dataset" "dataset" {       + creation_time              = (known after apply)       + dataset_id                 = "demo_dataset"       + delete_contents_on_destroy = false       + etag                       = (known after apply)       + id                         = (known after apply)       + labels                     = (known after apply)       + last_modified_time         = (known after apply)       + location                   = "US"       + project                    = "civil-charmer-410021"       + self_link                  = (known after apply)     }    # google_storage_bucket.data-lake-bucket will be created   + resource "google_storage_bucket" "data-lake-bucket" {       + force_destroy               = true       + id                          = (known after apply)       + location                    = "US"       + name                        = "terraform-demo-terra-bucket"       + project                     = (known after apply)       + public_access_prevention    = (known after apply)       + self_link                   = (known after apply)       + storage_class               = "STANDARD"       + uniform_bucket_level_access = true       + url                         = (known after apply)        + lifecycle_rule {           + action {               + type = "Delete"             }           + condition {               + age                   = 30               + matches_prefix        = []               + matches_storage_class = []               + matches_suffix        = []               + with_state            = (known after apply)             }         }        + versioning {           + enabled = true         }     }  Plan: 2 to add, 0 to change, 0 to destroy.  Do you want to perform these actions?   Terraform will perform the actions described above.   Only 'yes' will be accepted to approve.    Enter a value: 