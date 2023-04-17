WITH
actio_log_with_mst_users AS (
	-- コード5.2.2.1参照
)
, user_action_flag AS (
	SELECT
			user_id
		, register_date
			-- 4. 登録日の1日後にアクションをしたかどうかを0,1のフラグで表す
		, SIGN(
				-- 3. 登録日の1日後にアクションをした回数をユーザごとに合計する
				SUM(
					-- 1. 登録日の1日後が、ログの最新日付以前に含まれるか確認
					CASE WHEN next_day_1 <= latest_date THEN
						-- 2. 登録日の1日後の日付にアクションをしている場合は1,それ以外は0を返す
						CASE WHEN next_day_1 = action_date THEN 1 ELSE 0 END
					END
        )
      ) AS next_1_day_action
  FROM
    action_log_with_mst_users
  GROUP BY
    user_id, register_date
)
SELECT *
FROM
  user_action_flag
ORDER BY
  register_date, user_id
;
