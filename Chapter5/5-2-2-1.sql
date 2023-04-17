WITH
action_log_with_mst_users AS (
  SELECT
      u.user_id
    , u.register_date
    -- アクションの日付と、ログ全体の最新日付を日付型として取得
    , CAST(a.stamp AS date) AS action_date
    , MAX(CAST(a.stamp AS date)) AS latest_date
    
    -- 登録日の1日後の日付を計算する
    -- ■ PostgreSQLの場合は下記を使用
    , CAST(u.register_date::date + '1 day'::interval AS date) AS next_day_1
	FROM
			mst_users AS u
		LEFT OUTER JOIN
			action_log AS a
		ON u.user_id = a.user_id
)
SELECT *
FROM
	action_log_with_mst_users
ORDER BY
	register_date
;
