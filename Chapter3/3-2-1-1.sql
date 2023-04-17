SELECT
    user_id
    -- ■ PostgreSQL, Hive, Redshift, BigQuery, SparkSQLのすべてでCONCAT関数が利用できる
  , CONCAT(pref_name, city_name) AS pref_city
    -- ■ PostgreSQL, Redshiftの場合は||演算子も利用できる
    -- , pref_name || city_name AS pref_city
FROM
  mst_user_location
;
