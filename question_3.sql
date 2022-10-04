--QUESTION 3
WITH vandy_players AS (SELECT DISTINCT playerid
					   FROM schools
					   INNER JOIN collegeplaying USING (schoolid)
					   WHERE schoolname ILIKE '%Vanderbilt%')
SELECT DISTINCT playerid, namefirst, namelast, (SUM(salary::numeric))::money AS pro_salary
FROM vandy_players
INNER JOIN people USING (playerid)
INNER JOIN salaries USING (playerid)
GROUP BY DISTINCT playerid, namefirst, namelast
ORDER BY pro_salary DESC;