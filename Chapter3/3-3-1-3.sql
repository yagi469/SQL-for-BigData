SELECT
    user_id
  , product_id
    -- 個別のレビュースコア
  , score
    -- 全体の平均レビュースコア
  , AVG(score) OVER() AS avg_score
    -- ユーザーの平均レビュースコア
  , AVG(score) OVER(PARTITION BY user_id) AS user_avg_score
    -- 個別のレビュースコアと、ユーザーの平均レビュースコアとの差
  , score - AVG(score) OVER(PARTITION BY user_id) AS user_avg_score_diff
FROM
  review
;
