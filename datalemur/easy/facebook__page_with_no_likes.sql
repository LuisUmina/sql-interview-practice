-- Source: DataLemur (Facebook) | Difficulty: Easy | DB: PostgreSQL
-- Problem: Page With No Likes
-- Link: https://datalemur.com/questions/sql-page-with-no-likes


-- Solution 1: GROUP BY + HAVING
SELECT p.page_id
FROM pages p LEFT JOIN page_likes pl ON p.page_id = pl.page_id
GROUP BY p.page_id
HAVING COUNT(pl.page_id) = 0
ORDER BY p.page_id ASC;


-- Solution 2: IS NULL
SELECT p.page_id
FROM pages p LEFT JOIN page_likes pl ON p.page_id = pl.page_id
WHERE pl.page_id IS NULL
ORDER BY p.page_id ASC;


-- Solution 3: NOT EXISTS
SELECT p.page_id
FROM pages p
WHERE NOT EXISTS  (
                  SELECT 1
                  FROM page_likes pl
                  WHERE pl.page_id = p.page_id
                  )
ORDER BY p.page_id;


-- Solution 4: NOT IN
SELECT page_id
FROM pages
WHERE page_id NOT IN (SELECT page_id FROM page_likes)
ORDER BY page_id;

