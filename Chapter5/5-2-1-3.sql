WITH
mst_users_with_year_month (
	-- コード5.2.1.2参照
)
SELECT
		year_month
	, COUNT(DISTINCT user_id) AS register_count
	, COUNT(DISTINCT CASE WHEN register_device = 'pc' THEN user_id END) AS register_pc
	, COUNT(DISTINCT CASE WHEN register_device = 'sp' THEN user_id END) AS register_sp
	, COUNT(DISTINCT CASE WHEN register_device = 'app' THEN user_id END) AS register_app
FROM
	mst_users_with_year_month
GROUP BY
	year_month
;
