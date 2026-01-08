-- Source: DataLemur (LinkdIn) | Difficulty: Easy | DB: PostgreSQL
-- Problem: Data Science Skills
-- Key idea: pivot skills per candidate using conditional aggregation
-- Link: https://datalemur.com/questions/matching-skills


-- Solution 1: Conditional Aggregation (pivot via CASE)
SELECT candidate_id
FROM
  (
  SELECT candidate_id,  MAX(CASE WHEN skill = 'Python' THEN 1 ELSE 0 END) AS FLG_Python,
                        MAX(CASE WHEN skill = 'Tableau' THEN 1 ELSE 0 END) AS FLG_Tableau,
                        MAX(CASE WHEN skill = 'PostgreSQL' THEN 1 ELSE 0 END) AS FLG_PostgreSQL
  FROM candidates
  GROUP BY candidate_id
  ) temp
WHERE (FLG_Python + FLG_Tableau + FLG_PostgreSQL) = 3
ORDER BY candidate_id ASC;


-- Solution 2: Group by + Having
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(DISTINCT skill) = 3
ORDER BY candidate_id ASC


-- Solution 3: INTERSECT
SELECT candidate_id FROM candidates WHERE skill = 'Python'
INTERSECT
SELECT candidate_id FROM candidates WHERE skill = 'Tableau'
INTERSECT
SELECT candidate_id FROM candidates WHERE skill = 'PostgreSQL'
ORDER BY candidate_id;


-- Solution 4: EXISTS
SELECT DISTINCT c.candidate_id
FROM candidates c
WHERE     EXISTS (SELECT 1 FROM candidates c2 WHERE c2.skill = 'Python' AND c2.candidate_id = c.candidate_id)
      AND EXISTS (SELECT 1 FROM candidates c2 WHERE c2.skill = 'Tableau' AND c2.candidate_id = c.candidate_id)
      AND EXISTS (SELECT 1 FROM candidates c2 WHERE c2.skill = 'PostgreSQL' AND c2.candidate_id = c.candidate_id)
ORDER BY c.candidate_id;