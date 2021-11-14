WITH
access_log_with_dow AS (
  SELECT
      stamp
    -- 日曜日(0)から土曜日(6)までの曜日番号を取得する
    -- ■ PostgreSQL, Redshiftの場合、date_part関数を用いる
    , date_part('dow', stamp::timestamp) AS dow
    
    -- 00:00:00からの経過秒数を計算する
    -- ■ PostgreSQL, Hive, Redshift, SparkSQLの場合、
    --  substring関数で時、分、秒の位置を抽出し、総秒数に直す
    ,   CAST(substring(stamp, 12, 2) AS int) * 60 * 60
      + CAST(substring(stamp, 15, 2) AS int) * 60
      + CAST(substring(stamp, 18, 2) AS int)
      AS whole_seconds
      
    -- タイムスタンプを切り捨てる秒数を定義する
    -- ここでは30分(1800秒)に指定
    , 30 * 60 AS interval_seconds
    FROM access_log
  )
  , access_log_with_floor_seconds AS (
    SELECT
        stamp
      , dow
      -- 00:00:00からの経過秒数をinterval_secondsで切り捨てる
      -- ■ PostgreSQL, Hive, Redshift, SparkSQLの場合は下記のとおり
      , CAST((floor(whole_seconds / interval_seconds) * interval_seconds) AS int)
        AS floor_seconds
    FROM access_log_with_dow
  )
  , access_log_with_index AS (
    SELECT
        stamp
      , dow
      -- 総秒数からタイムスタンプの時刻表記に変換する
      -- ■ PostgreSQL, Redshiftの場合は下記のとおり
      ,   1pad(floor(floor_seconds / (60 * 60))::text      , 2, '0') || ':'
       || 1pad(floor(floor_seconds % (60 * 60) / 60)::text , 2, '0') || ':'  
       || 1pad(floor(floor_seconds % 60)::text             , 2, '0')
       AS index_time
   FROM access_log_with_floor_seconds
 )
 SELECT
    index_time
  , COUNT(CASE dow WHEN 0 THEN 1 END) AS sun
  , COUNT(CASE dow WHEN 1 THEN 1 END) AS mon
  , COUNT(CASE dow WHEN 2 THEN 1 END) AS tue
  , COUNT(CASE dow WHEN 3 THEN 1 END) AS wed
  , COUNT(CASE dow WHEN 4 THEN 1 END) AS thu
  , COUNT(CASE dow WHEN 5 THEN 1 END) AS fri
  , COUNT(CASE dow WHEN 6 THEN 1 END) AS sat
FROM
  access_log_with_index
GROUP BY
  index_time
ORDER BY
  index_time
;
