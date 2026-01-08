-- Source: DataLemur (Twitter) | Difficulty: Easy | DB: PostgreSQL
-- Problem: Histogram of Tweets
-- Key idea: count tweets per user in 2022, then histogram by that count
-- Link: https://datalemur.com/questions/sql-histogram-tweets


-- Solution 1: CTE
WITH cte AS (
  SELECT user_id, COUNT(tweet_id) AS tweets_num
  FROM tweets
  WHERE tweet_date BETWEEN '2022-01-01' AND '2022-12-31' 
  GROUP BY user_id
)
SELECT tweets_num AS tweet_bucket, COUNT(user_id) AS users_num
FROM cte
GROUP BY tweets_num


-- Solution 2: Subquery
SELECT tweets_num AS tweet_bucket, COUNT(user_id) AS users_num
FROM (
  SELECT user_id, COUNT(tweet_id) AS tweets_num
  FROM tweets
  WHERE tweet_date BETWEEN '2022-01-01' AND '2022-12-31'
  GROUP BY user_id
) t
GROUP BY tweets_num;