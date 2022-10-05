--QUESTION 10

WITH years_played AS (SELECT *, ((finalgame::date-debut::date)/365) as years_playing
					  FROM people),
WITH tenyr_players AS (SELECT *
						FROM batting
						INNER JOIN years_played USING (playerid)
						WHERE years_playing >= 10
						AND yearid = 2016
						AND hr >= 1)
SELECT *
FROM


