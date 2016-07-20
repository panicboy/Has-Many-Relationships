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
    WHERE posts.created_at > '2015-01-02'
    ORDER BY users.username;

\echo Queries across multiple tables 6.
SELECT users.username, posts.title, posts.content
  FROM posts
    INNER JOIN users
      ON posts.user_id = users.id
    WHERE users.created_at < '2015-01-01'
    ORDER BY users.username;

\echo Queries across multiple tables 7.
SELECT posts.title AS "Post Title", comments.*
  FROM posts
    INNER JOIN comments
      ON posts.id = comments.post_id
  ORDER BY posts.title;
  -- LIMIT 100;

\echo Queries across multiple tables 8.
SELECT posts.title AS post_title,
        posts.url AS post_url,
        comments.body AS comment_body
  FROM posts
    INNER JOIN comments
      ON posts.id = comments.post_id
  WHERE posts.created_at < '2015-01-01';
  -- LIMIT 100;

\echo Queries across multiple tables 9.
SELECT  posts.title AS post_title,
        posts.url AS post_url,
        comments.body AS comment_body
  FROM posts
    INNER JOIN comments
      ON posts.id = comments.post_id
  WHERE posts.created_at > '2015-01-02';
  -- LIMIT 100;

\echo Queries across multiple tables 10.
SELECT  posts.title AS post_title,
        posts.url AS post_url,
        comments.body AS comment_body
  FROM posts
    INNER JOIN comments
      ON posts.id = comments.post_id
  WHERE comments.body LIKE '%USB%';

\echo Queries across multiple tables 11.
SELECT  posts.title AS post_title,
        users.first_name,
        users.last_name,
        comments.body AS comment_body
  FROM users
    INNER JOIN posts
      ON users.id = posts.user_id
    INNER JOIN comments
      ON posts.id = comments.post_id
    WHERE comments.body LIKE '%matrix%';

\echo Queries across multiple tables 12.
SELECT  users.first_name,
        users.last_name,
        comments.body AS comment_body
  FROM comments
    INNER JOIN posts
      ON comments.post_id = posts.id
    INNER JOIN users
      ON comments.user_id = users.id
    WHERE comments.body LIKE '%SSL%'
        AND posts.content LIKE '%dolorum%';

\echo Queries across multiple tables 13.
SELECT  users.first_name AS post_author_first_name,
        users.last_name AS post_author_last_name,
        c.post_title,
        c.comment_author_username,
        c.comment_body
  FROM users
    INNER JOIN
      (SELECT  posts.user_id AS id,
            cUsers.username AS comment_author_username,
            posts.title AS post_title,
            comments.body AS comment_body
      FROM  posts
        INNER JOIN comments
          ON posts.id = comments.post_id
          AND posts.content LIKE '%nemo%'
        INNER JOIN users AS cUsers
          ON comments.user_id = cUsers.id
      WHERE comments.body LIKE '%SSL%'
        OR comments.body LIKE '%firewall%') AS c
        ON users.id = c.id;


\c andrew;