WITH
repeat_interval(index_name, interval_date) AS (
  -- ■ PostgreSQLの場合、VALUES句で一時テーブルを作成できる
  VALUES
    ('01 day repeat', 1)
  , ('02 day repeat', 2)
  , ('03 day repeat', 3)
  , ('04 day repeat', 4)
  , ('05 day repeat', 5)
  , ('06 day repeat', 6)
  , ('07 day repeat', 7)
)
SELECT *
FROM repeat_interval
ORDER BY index_name
;
  
