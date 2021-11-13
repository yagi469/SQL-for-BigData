WITH
access_log_with_path AS (
  -- URLからパスを抽出する
  SELECT *
    -- ■ PostgreSQLの場合、正規表現でパス部分を抽出する
    , substring(url from '//[^/]+([^?#]+)') AS url_path
  FROM access_log
)
SELECT
    url_path
  , COUNT(DISTINCT short_session) AS access_count
  , COUNT(DISTINCT long_session) AS access_users
  , COUNT(*) AS page_view
FROM
  access_log_with_path
GROUP BY
  url_path
;
