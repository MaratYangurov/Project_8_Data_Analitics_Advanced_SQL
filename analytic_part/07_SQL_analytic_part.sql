-- Запрос №7
-- Найдите пользователя, который опубликовал больше всего постов за всё время с момента регистрации. 
-- Выведите данные его активности за октябрь 2008 года в таком виде:

-- номер недели;
-- дата и время последнего поста, опубликованного на этой неделе.


WITH 
user_posts AS (
    -- Подсчёт количества постов для каждого пользователя
    SELECT
        p.user_id,
        COUNT(p.id) AS total_posts
    FROM stackoverflow.posts AS p
    GROUP BY p.user_id
),
top_user AS (
    -- Поиск пользователя с наибольшим количеством постов
    SELECT 
        user_id
    FROM user_posts
    ORDER BY total_posts DESC
    LIMIT 1
),
october_activity AS (
    -- Выбор активности выбранного пользователя за октябрь 2008
    SELECT
        EXTRACT(WEEK FROM p.creation_date) AS week_number,
        MAX(p.creation_date) AS last_post_date
    FROM stackoverflow.posts AS p
    WHERE p.user_id = (SELECT user_id FROM top_user)
      AND p.creation_date::DATE BETWEEN '2008-10-01' AND '2008-10-31'
    GROUP BY EXTRACT(WEEK FROM p.creation_date)
)
-- Вывод результата
SELECT 
    week_number,
    last_post_date
FROM october_activity
ORDER BY week_number;
