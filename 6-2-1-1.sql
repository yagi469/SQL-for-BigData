WITH
activity_log_with_landing_exit AS (
  SELECT
      session
    , path
    , stamp
    , FIRST_VALUE(path)
        OVER(
          PATITION BY session
          ORDER BY stamp ASC
            ROWS BETWEEN UNBOUNDED PRECEDING
                     AND UNBOUNDED FOLLOWING
          ) AS landing
     , LAST_VALUE(path)
         OVER(
          PARTITION BY session
          ORDER BY stamp ASC
            ROWS BETWEEN UNBOUNDED PRECEDING
                     AND UNBOUNDED FOLLOWING
          ) AS exit
  FROM activity_log
)
SELECT *
FROM
  activity_log_with_landing_exit
;
