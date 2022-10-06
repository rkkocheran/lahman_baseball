/*
In this question, you will explore the connection between number of wins and attendance.
      - Does there appear to be any correlation between attendance at home games and number of wins?   
      - Do teams that win the world series see a boost in attendance the following year? What about 
	  teams that made the playoffs? Making the playoffs means either being a division winner or a 
	  wild card winner.
*/

SELECT DISTINCT year, team, homegames.attendance, AVG(w) AS wins
FROM homegames INNER JOIN teams ON homegames.year = teams.yearid
GROUP BY year, team, homegames.attendance
ORDER BY team, attendance, year ASC;
--no apparent correlation between number of wins

--ws investigation

SELECT DISTINCT 
	yearid, 
	teamid, 
	--wswin, 
	--yearid + 1 AS next_year,
	attendance
FROM teams
WHERE wswin = 'Y'
ORDER BY yearid, teamid;
