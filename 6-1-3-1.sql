WITH
access_log_with_parse_info AS (
  -- 流入元情報を抽出する
  SELECT *
    -- ■ PostgreSQLの場合、正規表現で流入元情報を抽出する
    , substring(url from 'https?://([^/]*)') AS url_domain
    , substring(url from 'utm_source=([^&]*)') AS url_utm_source
    , substring(url from 'utm_medium=([^&]*)') AS url_utm_medium
    , substring(referrer from 'https?://[^/]*') AS referrer_domain
  FROM access_log
)
, access_log_with_via_info AS (
  SELECT *
    , ROW_NUMBER() OVER(ORDER BY stamp) AS log_id
    , CASE
        WHEN url_utm_source <> '' AND url_utm_medium <> ''
          -- ■ PostgreSQL, Hive, BigQuery, SparkSQLの場合、3引数以上のconcat関数が使える
          THEN concat(url_utm_source, '-', url_utm_medium)
          -- ■ PostgreSQL, Redshiftの場合、文字列の連結に||演算子が使える
        WHEN referrer_domain IN ('search.yahoo.co.jp', 'www.google.co.jp') THEN 'search'
        WHEN referrer_domain IN ('twitter.com', 'www.facebook.com') THEN 'social'
        ELSE 'other'
        -- ELSE referrer_domain とすることで、ドメイン別に集計可能
      END AS via
  FROM access_log_with_parse_info
  -- リファラーが空ではなく、そのドメインが自サイトのドメインではないログを流入元とする
  WHERE COALESCE(referrer_domain, '') NOT IN ('', url_domain)
)
SELECT via, COUNT(1) AS access_count
FROM access_log_with_via_info
GROUP BY via
ORDER BY access_count DESC;
