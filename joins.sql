\c has_many_blogs;

\pset pager off

\echo Queries across multiple tables 1.
SELECT *
  FROM users;

\echo Queries across multiple tables 2.
SELECT *
  FROM posts
    WHERE user_id = 100;

\echo Queries across multiple tables 3.
SELECT users.first_name, users.last_name, posts.*
  FROM posts
    INNER JOIN users
      ON posts.user_id = users.id
    WHERE users.id = 200;

\echo Queries across multiple tables 4.
SELECT users.username, posts.*
  FROM posts
    INNER JOIN users
      ON posts.user_id = users.id
    WHERE users.first_name = 'Norene'
      AND users.last_name = 'Schmitt';

\echo Queries across multiple tables 5.
SELECT DISTINCT users.username
  FROM posts
    INNER JOIN users
      ON posts.user_id = users.id
    WHERE posts.created_at > '2015-01-01'
    ORDER BY users.username;

\echo Queries across multiple tables 6.
SELECT users.username, posts.title, posts.content
  FROM posts
    INNER JOIN users
      ON posts.user_id = users.id
    WHERE users.created_at < '2015-01-01'
    ORDER BY users.username;








\c andrew;