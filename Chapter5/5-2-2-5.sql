WITH
repeat_interval AS (
  -- コード5.2.2.4参照
)
, action_log_with_index_date AS (
  SELECT
      u.user_id
    , u.register_date
    -- アクションの日付と、ログ全体の最新日付を日付型として取得
    , CAST(a.stamp AS date) AS action_date
    , MAX(CAST(a.stamp AS date)) OVER() AS latest_date
    
    -- 登録日のn日後の日付を計算する
    , r.index_name
    
    -- ■ PostgreSQLの場合は下記を使用
    , CAST(CAST(u.register_date AS date) + interval '1 day' * r.interval_date AS date) AS index_date
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
      -- 4. 登録日のn日後にアクションをしたかどうかを0,1のフラグで表す
    , SIGN(
        -- 3. 登録日のn日後にアクションをした回数をユーザごとに合計する
        SUM(
          -- 1. 登録日のn日後が、ログの最新日付以前に含まれるか確認
          CASE WHEN index_date <= latest_date THEN
            -- 2. 登録日のn日後の日付にアクションをしている場合は1、それ以外は0を返す
           CASE WHEN index_date = action_date THEN 1 ELSE 0 END
          END
        )
      ) AS index_date_action
  FROM
    action_log_with_index_date
  GROUP BY
    user_id, register_date, index_name, index_date
)
SELECT
    register_date
  , index_name
  , AVG(100.0 * index_date_action) AS repeat_rate
FROM
  user_action_flag
GROUP BY
  register_date, index_name
ORDER BY
  register_date, index_name
;
