-- Data Studio Dashboard
https://lookerstudio.google.com/s/u5BR20ngmlc

-- Q3
SELECT COUNT(1)
FROM `prod.fact_fhv`;

-- Q4
-- 279,866
SELECT COUNT(1)
FROM `de-zoomcamp-412923.prod.fact_fhv`
WHERE pickup_datetime BETWEEN '2019-07-01' AND '2019-07-31';

-- 3,139,034
SELECT COUNT(1)
FROM `prod.fact_trips`
WHERE pickup_datetime BETWEEN '2019-07-01' AND '2019-07-31' AND
service_type = 'Yellow';

-- 401,966
SELECT COUNT(1)
FROM `prod.fact_trips`
WHERE pickup_datetime BETWEEN '2019-07-01' AND '2019-07-31' AND
service_type = 'Green';