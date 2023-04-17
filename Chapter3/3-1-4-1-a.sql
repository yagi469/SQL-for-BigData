SELECT
  -- ■　PostgreSQL, Hive, BigQueryの場合は、
  -- CURRENT_DATE定数やCURRENT_TIMESTAMP定数が利用できる
    CURRENT_DATE AS dt
  -- CURRENT_TIMESTAMP AS stamp
  
  -- ■ PostgreSQLの場合、CURRENT_TIMESTAMPはタイムゾーン付きのタイムスタンプ型になる
  -- タイムゾーンなしのタイムスタンプを取得したい場合は、LOCALTIMESTAMPを用いる
  , LOCALTIMESTAMP AS stamp
;
