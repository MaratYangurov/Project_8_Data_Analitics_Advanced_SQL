-- Запрос №1
-- Найдите количество вопросов, которые набрали больше 300 очков или как минимум 100 раз были добавлены в «Закладки».
SELECT COUNT(id)
FROM stackoverflow.posts
WHERE score > 300 OR favorites_count >= 100;