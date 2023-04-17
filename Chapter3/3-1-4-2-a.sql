-- 文字列から日付型/タイムスタンプ型に変換する
SELECT
    -- ■ PostgreSQL, Hive, Redshift. BigQuery, SparkSQLのすべてで、
    --  「CAST(value AS type)」の形式が利用できる
    --   CAST('2016-01-30' AS date) AS dt
    -- , CAST('2016-01-30 12:00:00' AS timestamp) AS stamp

    -- ■ POstgreSQL, Hive, Redshift, BigQuery, SparkSQLのすべてで
    --  「type value」の形式が利用できる
    --   # ただし、valueは定数である必要があり、カラム名は指定できない
    date '2016-01-30' AS dt
  , timestamp '2016-01-30 12:00:00' AS stamp

    -- ■ PostgreSQL, Redshiftの場合、「value::type」の形式が利用できる
    --  '2016-01-30'::date AS dt
    --, '2016-01-30 12:00:00'::timestamp AS stamp
;
