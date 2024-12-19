-- Запрос №4
-- Сколько уникальных постов пользователя с именем Joel Coehoorn получили хотя бы один голос?
SELECT COUNT(DISTINCT p.id) AS unique_posts
FROM stackoverflow.posts AS p
INNER JOIN stackoverflow.users AS u ON p.user_id = u.id
WHERE u.display_name = 'Joel Coehoorn'
  AND EXISTS (
      SELECT 1
      FROM stackoverflow.votes AS v
      WHERE v.post_id = p.id
  );