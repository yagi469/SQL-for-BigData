WITH
	mst_users_with_year_month AS (
		SELECT
				*
			-- ■ PostgreSQL, Hive, Redshift, SparkSQLの場合、substringで年-月部分を抽出する
			, substring(register_date, 1, 7) AS year_month
		FROM
			mst_users
)
SELECT
		year_month
	, COUNT(DISTINCT user_id) AS register_count
	, LAG(COUNT(DISTINCT user_id)) OVER(ORDER BY year_month) AS last_month_count
	, 1.0
		* COUNT(DISTINCT user_id)
		/ LAG(COUNT(DISTINCT user_id)) OVER(ORDER BY year_month)
		AS month_over_month_ratio
FROM
	mst_users_with_year_month
GROUP BY
	year_month
;
