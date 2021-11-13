SELECT
  -- ■ PostgreSQL, Hive, Redshift, SparkSQLの場合、substringで日付部分を抽出する
    substring(stamp, 1, 10) AS dt
  -- ■ PostgreSQL, Hive, BigQuery, SparkSQLの場合、substrが利用できる
  -- substr(stamp, 1, 10) AS dt
  
  -- 訪問者数を計算
  , COUNT(DISTINCT long_session) AS accesss_users
  -- 訪問回数を計算
  , COUNT(DISTINCT short_session) AS access_count
  -- ページビューを計算
  , COUNT(*) AS page_view
  
  -- 1ユーザあたりのページビュー数
  -- ■ PostgreSQL, Redshift, BigQuery, SparkSQLの場合、NULLIF関数が使用できる
  , 1.0 * COUNT(*) / NULLIF(COUNT(DISTINCT long_session), 0) AS pv_per_user
FROM
  access_log
GROUP BY
  -- ■ PostgreSQL, Redshift, BigQueryの場合、
  --  SELECT句で定義した別名をGROUP BYに指定できる
  dt
  -- ■ PostgreSQL, Hive, Redshift, SparkSQLの場合、
  --  SELECT句で別名を指定する前の式をGROUP BYに指定できる
  -- substring(stamp, 1, 10)
ORDER BY
  dt
;
