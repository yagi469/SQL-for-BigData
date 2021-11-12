WITH
repeat_interval AS (
  -- コード5.2.2.6参照
)
, action_log_with_index_date AS (
  SELECT
      u.user_id
    , u.register_date
    -- アクションの日付と、ログ全体の最新日付を日付型として取得
    , CAST(a.stamp AS date) AS action_date
    , MAX(CAST(a.stamp AS date)) OVER() AS latest_date
    , r_index_name
    
    -- 指標の対象期間の開始日と終了日を計算する
    -- ■ PostgreSQLの場合は下記を使用
    , CAST(u.register_date::date + '1 day'::interval * r.interval_begin_date AS date)
      AS index_begin_date
    , CAST(u.register_date::date + '1 day'::interval * r.interval_end_date AS date)
      AS latest_end_date
FROM
    mst_users AS u
  LEFT OUTER JOIN
    action_log AS a
  ON u.user_id = a.user_id
  CROSS JOIN
    repeat_interval AS r
)
, user_action_flag AS (
  SELECT
      user_id
    , register_date
    , index_name
      -- 4. 指標の対象期間にアクションしたかどうかを0,1のフラグで表す
    , SIGN(
        -- 3. 指標の対象期間にアクションをした回数をユーザごとに合計する
        SUM(
          -- 1. 指標の対象期間の終了日が、ログの最新日付以前に含まれるか確認
          CASE WHEN index_end_date <= latest_date THEN
            -- 2. 指標の対象期間にアクションをしている場合は1、それ以外は0を返す
            CASE WHEN action_date BETWEEN index_begin_date AND index_end_date
                 THEN 1 ELSE 0
            END
          END
        )
      ) AS index_date_action
  FROM
    action_log_with_index_date
  GROUP BY
    user_id, register_date, index_name, index_begin_date, index_end_date
)
SELECT
    register_date
  , index_name
  , AVG(100.0 * index_date_action) AS index_rate
FROM
  user_action_flag
GROUP BY
  register_date, index_name
ORDER BY
  register_date, index_name
;
