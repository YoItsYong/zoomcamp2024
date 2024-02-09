CREATE OR REPLACE EXTERNAL TABLE `de-zoomcamp-412923.ny_taxi.external_green_taxi_data`
  OPTIONS (
    format = "PARQUET",
    uris = ['gs://w3_green_taxi/*']
  );

CREATE OR REPLACE TABLE `de-zoomcamp-412923.ny_taxi.green_taxi_data_nonpartitioned` AS
SELECT * FROM `ny_taxi.external_green_taxi_data`;

--Question 1: What is count of records for the 2022 Green Taxi Data?? 840402
SELECT COUNT(1)
FROM `ny_taxi.green_taxi_data_nonpartitioned`;

-- Question 2: Write a query to count the distinct number of PULocationIDs for the entire dataset on both the tables.
-- EXTERNAL: 258
SELECT COUNT(DISTINCT PULocationID)
FROM `ny_taxi.external_green_taxi_data`;

-- MATERIALIZED : 258
SELECT COUNT(DISTINCT PULocationID)
FROM `ny_taxi.green_taxi_data_nonpartitioned`;
-- What is the estimated amount of data that will be read when this query is executed on the External Table and the Table?
-- EXTERNAL : 0MB
-- MATERIALIZED : 6.41MB

-- Question 3: How many records have a fare_amount of 0? 1,622
SELECT COUNT(1)
FROM `ny_taxi.external_green_taxi_data`
WHERE fare_amount = 0.0;

-- Question 4: What is the best strategy to make an optimized table in Big Query if your query will always order the results by PUlocationID and filter based on lpep_pickup_datetime? (Create a new table with this strategy) Partition by lpep_pickup_datetime Cluster on PUlocationID

CREATE OR REPLACE TABLE `de-zoomcamp-412923.ny_taxi.green_taxi_data_partitioned_clustered`
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PULocationID AS
SELECT * FROM `ny_taxi.external_green_taxi_data`;

-- Question 5: Write a query to retrieve the distinct PULocationID between lpep_pickup_datetime 06/01/2022 and 06/30/2022 (inclusive)
-- Use the materialized table you created earlier in your from clause and note the estimated bytes. Now change the table in the from clause to the partitioned table you created for question 4 and note the estimated bytes processed. What are these values?

-- MATERIALIZED : 12.82MB
SELECT COUNT(DISTINCT PULocationID) as trips
FROM `ny_taxi.green_taxi_data_nonpartitioned`
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30';

-- Nonpartitioned + Clustered : 1.12MB
SELECT COUNT(DISTINCT PULocationID) as trips
FROM `ny_taxi.green_taxi_data_partitioned_clustered`
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30';

-- Question 6: Where is the data stored in the External Table you created? GCP Bucket

-- Question 7: It is best practice in Big Query to always cluster your data: False

-- Question 8: Write a SELECT count(*) query FROM the materialized table you created. How many bytes does it estimate will be read? Why?

-- 0 B because the COUNT(*) method allows BQ to count rows via metadata and thus it doesn't have to read any of the actual data in the table
SELECT COUNT(*)
FROM `ny_taxi.green_taxi_data_nonpartitioned`
