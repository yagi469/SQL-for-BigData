SELECT
    url
  , COUNT(DISTINCT short_session) AS access_count
  , COUNT(DISTINCT long_session) AS access_users
  , COUNT(*) AS page_view
FROM
  access_log
GROUP BY
  url
;
