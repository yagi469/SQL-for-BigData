WITH
access_log_with_parse_info AS (
  -- コード6.1.3.1参照
)
, access_log_with_via_info AS (
  -- コード6.1.3.1参照
)
, access_log_with_purchase_amount AS (
  SELECT
      a.log_id
    , a.via
    , SUM(
        CASE
          -- ■ PostgreSQLの場合、interval型のデータを用いて日付/時刻の四則演算ができる
          WHEN p.stamp::date BETWEEN a.stamp::date AND a.stamp::date + '1 day'::interval
          THEN amount
        END
      ) AS amount
  FROM
      access_log_with_via_info AS a
    LEFT OUTER JOIN
      purchase_log AS p
      ON a.long_session = p.long_session
  GROUP BY a.log_id, a.via
)
SELECT
   via
 , COUNT(1) AS via_count
 , COUNT(amount) AS conversions
 , AVG(100.0 * SIGN(COALESCE(amount, 0))) AS cvr
 , SUM(COALESCE(amount, 0)) AS amount
 , AVG(1.0 * COALESCE(amount, 0)) AS avg_amount
FROM
  access_log_with_purchase_amount
GROUP BY via
ORDER BY cvr DESC
;
