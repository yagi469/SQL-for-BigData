WITH
repeat_interval(index_name, interval_begin_date, interval_end_date) AS (
  -- ■ PostgreSQLの場合、VALUES句で一時テーブルを作成できる
  VALUES
    ('01 day repeat'   , 1,  1)
  , ('02 day repeat'   , 2,  2)
  , ('03 day repeat'   , 3,  3)
  , ('04 day repeat'   , 4,  4)
  , ('05 day repeat'   , 5,  5)
  , ('06 day repeat'   , 6,  6)
  , ('07 day repeat'   , 7,  7)
  , ('07 day retention'. 1.  7)
  , ('14 day retention'. 8. 14)
  , ('21 day retention'. 15. 21)
  , ('28 day retention'. 22. 28)
)
SELECT *
FROM repeat_interval
ORDER BY index_name
; 
