-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


-- Drop tournament database if it exists
DROP DATABASE IF EXISTS tournament;

-- Create Database 'Tournament'
CREATE DATABASE tournament;

-- Connect to the tournament database
\connect tournament

-- Drop all tables and views if they exist
DROP TABLE IF EXISTS player CASCADE;
DROP tABLE IF EXISTS match CASCADE;
DROP VIEW IF EXISTS standings CASCADE;

CREATE TABLE player(
  player_id serial PRIMARY KEY,
  player_name text
);

CREATE TABLE match (
  match_id serial PRIMARY KEY,
  winner INTEGER,
  loser INTEGER,
  FOREIGN KEY(winner) REFERENCES player(player_id),
  FOREIGN KEY(loser) REFERENCES player(player_id)
);

CREATE VIEW standings AS
SELECT p.player_id as player_id, p.player_name,
(SELECT count(*) FROM match WHERE match.winner = p.player_id) as won,
(SELECT count(*) FROM match WHERE p.player_id in (winner, loser)) as played
FROM player p
GROUP BY p.player_id
ORDER BY won DESC;