WITH
repeat_interval AS (
  -- コード5.2.2.8参照
)
, action_log_with_index_date AS (
  -- コード5.2.2.7参照
)
, user_action_flag AS (
  -- コード5.2.2.7参照
)
SELECT
    index_name
  , AVG(100.0 * index_date_action) AS repeat_rate
FROM
  user_action_flag
GROUP BY
  index_name
ORDER BY
  index_name
;
