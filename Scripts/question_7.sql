--QUESTION 7

--Largest # of Wins w/o World Series Win
SELECT yearid, teams.lgid, teams.teamid, w
FROM teams
WHERE yearid >= 1970 AND yearid <= 2016
AND wswin = 'N'
ORDER BY w DESC
LIMIT 1;

--Smallest # of Wins w/ World Series Win
SELECT yearid, teams.lgid, teams.teamid, w
FROM teams
WHERE yearid >= 1970 AND yearid <= 2016
AND wswin = 'Y'
ORDER BY w ASC
LIMIT 1;

--1981 least amount of total games
SELECT yearid, sum(g) AS total_games
FROM teams
WHERE yearid >= 1970 AND yearid <= 2016
GROUP BY yearid
ORDER BY total_games ASC;

--Smallest # of Wins w/ World Series Win **EXCLUDING 1981**
SELECT yearid, teams.lgid, teams.teamid, w
FROM teams
WHERE yearid >= 1970 AND yearid <= 2016 AND yearid <> 1981
AND wswin = 'Y'
ORDER BY w ASC
LIMIT 1;

--Percent of games between 1970-2016 where the team with the most wins also won the world series
WITH teams_with_maxwins AS (SELECT DISTINCT yearid, teamid, wswin, w, MAX(w) OVER(PARTITION BY yearid) AS max_wins
							FROM teams
							WHERE yearid >= 1970 AND yearid <= 2016
						    GROUP BY yearid, teamid, wswin, w
						    ORDER BY yearid)
SELECT ROUND((COUNT(*)::numeric/46)::decimal,2) AS percent_of_wins
FROM teams_with_maxwins
WHERE wswin = 'Y'
AND w >= max_wins;








