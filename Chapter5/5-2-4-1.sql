WITH
repeat_interval(index_name, interval_begin_date, interval_end_date) AS (
  -- ■ PostgreSQLの場合、VALUES句で一時テーブルを作成できる
  VALUES ('14 day retention', 8, 14)]
)
, action_log_with_index_date AS (
  -- コード5.2.2.7参照
)
, user_action_flag AS (
  -- コード5.2.2.7参照
)
, mst_action_bucket(action, min_count, max_count) AS (
  -- アクションの階級マスタ
  -- ■ PostgreSQLの場合、VALUES句で一時テーブルを作成できる
  VALUES
    ('comment',  0,    0)
  , ('comment',  1,    5)
  , ('comment',  6,   10)
  , ('comment', 11, 9999) -- 最大値として便宜上9999を入れている
  , ('follow' ,  0,    0)
  , ('follow' ,  1,    5)
  , ('follow' ,  6,   10)
  , ('follow' , 11, 9999) -- 最大値として便宜上9999を入れている
)
, mst_users_action_bucket AS (
  -- ユーザマスタとアクション階級マスタの組み合わせを算出
  SELECT
      u.user_id
    , u.register_date
    , a.action
    , a.min_count
    , a.max_count
  FROM
      mst_users AS u
    CROSS JOIN
      mst_action_bucket AS a
)
SELECT *
FROM
  mst_user_action_bucket
ORDER BY
  user_id, action, min_count
;
