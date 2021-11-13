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
, mst_actions(action) AS (
  -- コード5.2.3.1参照
)
, mst_user_actions AS (
  -- コード5.2.3.1参照
)
, register_action_flag AS (
  -- コード5.2.3.2参照
)
SELECT
    action
  , COUNT(1) users
  , AVG(100.0 * do_action) AS usage_rate
  , index_name
  , AVG(CASE do_action WHEN 1 THEN 100.0 * index_date_action END) AS idx_rate
  , AVG(CASE do_action WHEN 0 THEN 100.0 * index_date_action END) AS no_action_idx_rate
FROM
  register_action_flag
GROUP BY
  index_name, action
ORDER BY
  index_name, action
;
