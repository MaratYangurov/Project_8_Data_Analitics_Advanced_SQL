-- Запрос №3
-- Выведите количество постов за 2008 год по месяцам. 
-- Отберите посты от пользователей, которые зарегистрировались в сентябре 2008 года и сделали хотя бы один пост в декабре того же года. 
-- Отсортируйте таблицу по значению месяца по убыванию.


WITH
-- Находим пользователей, зарегистрировавшихся в сентябре 2008 года, и сделавших хотя бы один пост в декабре 2008 года
active_users AS (
    SELECT DISTINCT u.id AS user_id
    FROM stackoverflow.users AS u
    INNER JOIN stackoverflow.posts AS p ON u.id = p.user_id
    WHERE u.creation_date BETWEEN '2008-09-01' AND '2008-09-30'
      AND p.creation_date BETWEEN '2008-12-01' AND '2008-12-31'
),
-- Считаем количество постов за каждый месяц 2008 года для найденных пользователей
posts_by_month AS (
    SELECT
        EXTRACT(MONTH FROM p.creation_date) AS month,
        COUNT(p.id) AS post_count
    FROM stackoverflow.posts AS p
    INNER JOIN active_users AS au ON p.user_id = au.user_id
    WHERE p.creation_date BETWEEN '2008-01-01' AND '2008-12-31'
    GROUP BY EXTRACT(MONTH FROM p.creation_date)
)
-- Выводим результат, сортируя по месяцу в обратном порядке
SELECT
    month,
    post_count
FROM posts_by_month
ORDER BY month DESC;
