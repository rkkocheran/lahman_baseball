/* Q3: Find all players in the database who played at Vanderbilt University. Create a list showing each player’s 
       first and last names as well as the total salary they earned in the major leagues. Sort this list in descending 
       order by the total salary earned. Which Vanderbilt player earned the most money in the majors?

    A: David Price. */
    
WITH vandy_players AS (
      SELECT DISTINCT playerid
	FROM schools
	INNER JOIN collegeplaying USING (schoolid)
      WHERE schoolname ILIKE '%Vanderbilt%'
)

SELECT DISTINCT playerid,
                namefirst,
                namelast,
                (SUM(salary::NUMERIC))::MONEY AS pro_salary
FROM vandy_players
INNER JOIN people USING (playerid)
INNER JOIN salaries USING (playerid)
GROUP BY DISTINCT playerid, namefirst, namelast
ORDER BY pro_salary DESC;