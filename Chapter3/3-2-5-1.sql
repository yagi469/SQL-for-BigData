SELECT
    user_id
  -- ■ PostgreSQLの場合、interval型のデータを用いて日付/時刻の四則演算ができる
  , register_stamp::timestamp AS register_stamp
  , register_stamp::timestamp + '1 hour'::interval     AS after_1_hour
  , register_stamp::timestamp - '30 minutes'::interval AS before_30_minutes
  
  , register_stamp::date AS register_date
  , (register_stamp::date + '1 day'::interval  )::date AS after_1_day
  , (register_stamp::date - '1 month'::interval)::date AS before_1_month
  
  -- タイムスタンプの文字列から日付を得るには、to_date関数を用いる
  -- , to_date(register_stamp) AS register_date
  --
  -- 日や月の計算には、date_add関数やadd_months関数が利用できる
  -- ただし、年の計算をする関数は実装されていない
  -- , date_add(to_date(register_stamp), 1) AS after_1_day
  -- , add_months(to_date(register_stamp), -1) AS befor_1_month
FROM mst_users_with_birthday
;
