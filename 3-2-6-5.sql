SELECT
    ip
  -- ■ PostgreSQL, Redshiftの場合、lpad関数で0埋めする
  ,    lpad(split_part(ip, '.', 1), 3, '0')
    || lpad(split_part(ip, '.', 2), 3, '0')
    || lpad(split_part(ip, '.', 3), 3, '0')
    || lpad(split_part(ip, '.', 4), 3, '0')
    AS ip_padding
    
FROM
  (SELECT '192.168.0.1' AS ip) AS t
  -- ■ PostgreSQLの場合、明示的に型の指定が必要
  -- (SELECT CAST('192.168.0.1' AS text) AS ip) AS t
;
