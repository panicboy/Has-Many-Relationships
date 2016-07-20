\c andrew;

\echo Setup schema and relationships 1.
DROP ROLE IF EXISTS has_many_user;
CREATE ROLE has_many_user;

\echo Setup schema and relationships 2.
DROP DATABASE IF EXISTS has_many_blogs;
CREATE DATABASE has_many_blogs;
ALTER DATABASE has_many_blogs OWNER TO has_many_user;
\c has_many_blogs;

DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users
(
  id SERIAL PRIMARY KEY NOT NULL,
  username VARCHAR(90) NOT NULL,
  first_name VARCHAR(90) NULL DEFAULT NULL,
  last_name VARCHAR(90) NULL DEFAULT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

DROP TABLE IF EXISTS posts;
CREATE TABLE IF NOT EXISTS posts
(
  id SERIAL PRIMARY KEY NOT NULL,
  title VARCHAR(180) NULL DEFAULT NULL,
  url VARCHAR(510) NULL DEFAULT NULL,
  content TEXT NULL DEFAULT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  user_id INTEGER REFERENCES users(id)
);

DROP TABLE IF EXISTS comments;
CREATE TABLE IF NOT EXISTS comments
(
  id SERIAL PRIMARY KEY NOT NULL,
  body VARCHAR(510) NULL DEFAULT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  user_id INTEGER REFERENCES users(id),
  post_id INTEGER REFERENCES posts(id)
);

\i scripts/blog_data.sql


\c andrew;