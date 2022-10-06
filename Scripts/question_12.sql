/*
In this question, you will explore the connection between number of wins and attendance.
      - Does there appear to be any correlation between attendance at home games and number of wins?   
      - Do teams that win the world series see a boost in attendance the following year? What about 
	  teams that made the playoffs? Making the playoffs means either being a division winner or a 
	  wild card winner.
*/

SELECT DISTINCT 
	year, 
	team, 
	homegames.attendance, 
	AVG(w) AS wins
FROM homegames INNER JOIN teams ON homegames.year = teams.yearid
GROUP BY year, team, homegames.attendance
ORDER BY team, attendance, year ASC;
--no apparent correlation between number of wins



--ws investigation

WITH ws_winners AS 
	(SELECT DISTINCT 
		yearid, 
		teamid
	FROM teams 
	WHERE wswin = 'Y'
	)
	
SELECT DISTINCT *, post_win_yearly_count - win_yearly_count AS diff_attendance
FROM
	(SELECT DISTINCT teamid, yearid, SUM(attendance) AS win_yearly_count
	FROM ws_winners INNER JOIN homegames ON ws_winners.teamid = homegames.team
	GROUP BY yearid, teamid) AS ws_years
LEFT JOIN
	(SELECT DISTINCT yearid+1 AS yearid_plusone, SUM(attendance) AS post_win_yearly_count
	FROM ws_winners INNER JOIN homegames ON ws_winners.yearid+1 = homegames.year
	GROUP BY yearid + 1) AS ws_year_plusone
ON ws_years.yearid = ws_year_plusone.yearid_plusone - 1
ORDER BY yearid
--teams that won the WS saw a drop in attendance the following years



--playoffs investigation
WITH playoffs AS 
	(SELECT DISTINCT 
		yearid, 
		teamid
	FROM teams 
	WHERE divwin = 'Y' OR wcwin = 'Y')
	
SELECT DISTINCT *, post_playoffs_yearly_count - playoffs_yearly_count AS diff_attendance
FROM
	(SELECT DISTINCT teamid, yearid, SUM(attendance) AS playoffs_yearly_count
	FROM playoffs INNER JOIN homegames ON playoffs.teamid = homegames.team
	GROUP BY yearid, teamid) AS ws_years
LEFT JOIN
	(SELECT DISTINCT yearid+1 AS yearid_plusone, SUM(attendance) 
	 	AS post_playoffs_yearly_count
	FROM playoffs INNER JOIN homegames ON playoffs.yearid+1 = homegames.year
	GROUP BY yearid + 1 ) AS ws_year_plusone
ON ws_years.yearid = ws_year_plusone.yearid_plusone - 1
ORDER BY yearid
