/* Q2: Find the name and height of the shortest player in the database. 
       How many games did he play in? What is the name of the team for which he played?
       
    A: Eddie Gaedel, 43in tall, 1 total game played in 1951 for the St. Louis Browns. */

WITH shortest_player AS (
      SELECT playerid,
             namefirst,
             namelast,
             height
      FROM people
      WHERE height = (SELECT MIN(height) FROM people)
)

SELECT namefirst,
       namelast,
       height,
       g_all AS games_played,
       teams.name,
       teams.yearid
FROM appearances
INNER JOIN shortest_player USING (playerid)
INNER JOIN teams USING (teamid)
WHERE appearances.yearid = teams.yearid;