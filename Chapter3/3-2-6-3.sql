SELECT
    ip
  -- ■ PostgreSQL, Redshiftの場合、split_partで文字列を分解する
  , CAST(split_part(ip, '.', 1) AS integer) AS ip_part_1
  , CAST(split_part(ip, '.', 2) AS integer) AS ip_part_2
  , CAST(split_part(ip, '.', 3) AS integer) AS ip_part_3
  , CAST(split_part(ip, '.', 4) AS integer) AS ip_part_4
  
FROM
  (SELECT '192.168.0.1' AS ip) AS t
  -- ■ PostgreSQLの場合、明示的に型の指定が必要
  -- (SELECT CAST('192.168.0.1' AS text) AS ip) AS t
;
