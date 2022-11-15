/* Q8: Using the attendance figures from the homegames table, find the teams and parks which had the top 5 average 
       attendance per game in 2016 (where average attendance is defined as total attendance divided by number of games). 
       Only consider parks where there were at least 10 games played. Report the park name, team name, and average 
       attendance. Repeat for the lowest 5 average attendance. */

-- Park names, team names and attendance per game for the top-5 highest average attendance
SELECT park_name,
       name AS team_name,
       ROUND((h.attendance / games::NUMERIC), 0) AS avg_att_per_game
FROM homegames AS h
INNER JOIN teams AS t ON h.team = t.teamid
INNER JOIN parks AS p ON h.park = p.park
WHERE YEAR = 2016
      AND yearid = 2016
      AND games >= 10
ORDER BY avg_att_per_game DESC
LIMIT 5;

-- Park names, team names and attendance per game for the top-5 lowest average attendance
SELECT park_name,
       name AS team_name,
       ROUND((h.attendance / games::NUMERIC), 0) AS avg_att_per_game
FROM homegames AS h
INNER JOIN teams AS t ON h.team = t.teamid
INNER JOIN parks AS p ON h.park = p.park
WHERE YEAR = 2016
      AND yearid = 2016
      AND games >= 10
ORDER BY avg_att_per_game
LIMIT 5;