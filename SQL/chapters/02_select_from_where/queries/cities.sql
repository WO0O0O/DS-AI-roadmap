-- Write your SQL query here
-- Select the 'city' column
-- From the table `bigquery-public-data.openaq.global_air_quality`
-- Where the 'country' column is 'US'

SELECT city
FROM `bigquery-public-data.openaq.global_air_quality`
WHERE country = 'US';
