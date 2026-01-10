-- Source: DataLemur (Tesla) | Difficulty: Easy | DB: PostgreSQL
-- Problem: Unfinished Parts
-- Link: https://datalemur.com/questions/tesla-unfinished-parts


-- Solution 1: IS NULL
SELECT part, assembly_step
FROM parts_assembly
WHERE finish_date IS NULL;