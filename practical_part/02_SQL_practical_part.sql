-- Запрос №2
-- Сколько в среднем в день задавали вопросов с 1 по 18 ноября 2008 включительно? 
-- Результат округлите до целого числа.
WITH
posts_count AS (
	SELECT
		CAST(p.creation_date AS DATE) AS post_date,
		COUNT(*) AS questions_per_day
	FROM stackoverflow.posts AS p
	LEFT JOIN stackoverflow.post_types AS pt ON p.post_type_id = pt.id
	WHERE p.creation_date BETWEEN '2008-11-01' AND '2008-11-19'
		AND pt.type = 'Question'
	GROUP BY CAST(p.creation_date AS DATE)
)

SELECT 
	ROUND(AVG(questions_per_day)) AS avg_questions_per_day
FROM posts_count AS pc;
