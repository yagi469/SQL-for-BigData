WITH
action_log_with_mst_users AS (
  -- コード5.2.2.1参照
)
, user_action_flag AS (
  -- コード5.2.2.2参照
)
SELECT
    register_date
  , AVG(100.0 * next_1_day_action) AS repeat_rate_1_day
FROM
  user_action_flag
GROUP BY
  register_date
ORDER BY
  register_date
;
