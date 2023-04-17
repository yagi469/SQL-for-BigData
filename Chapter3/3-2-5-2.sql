SELECT
    user_id
    
  -- ■ PostgreSQL, Redshiftの場合、日付型同士の引き算ができる
  , CURRENT_DATE AS today
  , register_stamp::date AS register_date
  , CURRENT_DATE - register_stamp::date AS diff_days
FROM mst_users_with_birthday
;
