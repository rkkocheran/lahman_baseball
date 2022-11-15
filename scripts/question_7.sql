/* Q7: From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? 
       What is the smallest number of wins for a team that did win the world series? Doing this will probably 
       result in an unusually small number of wins for a world series champion – determine why this is the case. 
       Then redo your query, excluding the problem year. How often from 1970 – 2016 was it the case that a team 
       with the most wins also won the world series? What percentage of the time? */

--Largest # of Wins w/o World Series Win
SELECT yearid,
       teams.lgid,
       teams.teamid,
       w
FROM teams
WHERE yearid >= 1970 AND yearid <= 2016
AND wswin = 'N'
ORDER BY w DESC
LIMIT 1;

--Smallest # of Wins w/ World Series Win
SELECT yearid,
       teams.lgid,
       teams.teamid,
       w
FROM teams
WHERE yearid >= 1970 AND yearid <= 2016
AND wswin = 'Y'
ORDER BY w ASC
LIMIT 1;

--1981: Least amount of total games due to MLB Strike
SELECT yearid, 
       SUM(g) AS total_games
FROM teams
WHERE yearid >= 1970 
      AND yearid <= 2016
GROUP BY yearid
ORDER BY total_games ASC;

--Smallest # of Wins w/ World Series Win **EXCLUDING 1981**
SELECT yearid,
       teams.lgid,
       teams.teamid,
       w
FROM teams
WHERE yearid >= 1970 
      AND yearid <= 2016 
      AND yearid <> 1981
AND wswin = 'Y'
ORDER BY w ASC
LIMIT 1;

--Percent of games between 1970-2016 where the team with the most wins also won the world series
WITH teams_with_maxwins AS (
      SELECT DISTINCT yearid,
                teamid,
                wswin,
                w,
                MAX(w) OVER(PARTITION BY yearid) AS max_wins
	FROM teams
	WHERE yearid >= 1970 AND yearid <= 2016
	GROUP BY yearid, teamid, wswin, w
	ORDER BY yearid
)

SELECT ROUND((COUNT(*)::NUMERIC/46)::DECIMAL,2) AS percent_of_wins
FROM teams_with_maxwins
WHERE wswin = 'Y'
AND w >= max_wins;