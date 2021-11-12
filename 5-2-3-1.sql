WITH
repeat_interval(idex_name, interval_begin_date, interval_end_date) AS (
  -- ■ PostgreSQLの場合、VALUES句で一時テーブルを作成できる
  VALUES ('01 day repeat', 1, 1)
)
, action_log_with_index_date AS (
  -- コード5.2.2.7参照
)
, user_action_flag AS (
  -- コード5.2.2.7参照
)
, mst_action AS (
            SELECT 'view'    AS action
  UNION ALL SELECT 'comment' AS action
  UNION ALL SELECT 'follow'  AS action
)
, mst_user_actions AS (
  SELECT
      u.user_id
    , u.register_date
    , a.action
  FROM
      mst_users AS u
    CROSS JOIN
      mst_actions AS a
)
SELECT *
FROM mst_user_actions
ORDER BY user_id, action
;
