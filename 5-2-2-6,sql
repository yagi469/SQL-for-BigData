WITH
repeat_interval(index_name, interval_begin_date, interval_end_date) AS (
  -- ■ PostgreSQLの場合、VALUES句で一時テーブルを作成できる
  VALUES
    ('07 day retention', 1, 7)
  , ('14 day retention', 8, 14)
  , ('21 day retention', 15, 21)
  , ('28 day retention', 22, 28)
)
SELECT *
FROM repeat_interval
ORDER BY index_name
;
