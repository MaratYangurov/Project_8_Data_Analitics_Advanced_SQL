-- Запрос №5
-- Сколько в среднем дней в период с 1 по 7 декабря 2008 года включительно пользователи взаимодействовали с платформой? 
-- Для каждого пользователя отберите дни, в которые он или она опубликовали хотя бы один пост. 
-- Нужно получить одно целое число — не забудьте округлить результат.
WITH user_active_days AS (
    SELECT
        p.user_id,
        COUNT(DISTINCT CAST(p.creation_date AS DATE)) AS active_days -- Количество уникальных дней активности для каждого пользователя
    FROM stackoverflow.posts AS p
    WHERE CAST(p.creation_date AS DATE) BETWEEN '2008-12-01' AND '2008-12-07'
    GROUP BY p.user_id
)

SELECT 
    ROUND(AVG(active_days)) AS avg_active_days -- Среднее количество дней активности пользователей, округлённое до целого
FROM user_active_days;