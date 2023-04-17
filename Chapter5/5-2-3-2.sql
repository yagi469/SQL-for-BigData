WITH
repeat_interval AS (
  -- コード5.2.3.1参照
)
, action_log_with_index_date AS (
  -- コード5.2.2.7参照
)
, user_action_flag AS (
  -- コード5.2.2.7参照
)
, mst_actions AS (
  -- コード5.2.3.1参照
)
, mst_user_actions AS (
  -- コード5.2.3.1参照
)
, register_action_flag AS (
  SELECT DISITNCT
      m.user_id
    , m.register_date
    , m.action
    , CASE
        WHEN a.action IS NOT NULL THEN 1
        ELSE 0
      END AS do_action
    , index_name
    , index_date_action
  FROM
      mst_user_actions AS m
    LEFT JOIN
      action_log AS a
      ON m.user_id = a.user_id
      AND CAST(m.register_date AS date) = CAST(a.stamp AS date)
      AND m.action = a.action
    LEFT JOIN
      user_action_flag AS f
      ON m.user_id = f.user_id
  WHERE
    f.index_date_action IS NOT NULL
)
SELECT
  +
FROM
  register_action_flag
ORDER BY
  user_id, index_name, action
;
