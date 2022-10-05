--QUESTION 10

WITH players_w_2016_hr AS (SELECT *, ((finalgame::date-debut::date)/365) as years_playing, MAX(batting.hr) OVER(PARTITION BY playerid) as career_high
					  FROM people
					  INNER JOIN batting USING (playerid)
					  WHERE yearid = 2016
					  AND hr >= 1)
SELECT DISTINCT playerid, namefirst, namelast, batting.hr as homeruns_2016
FROM batting
INNER JOIN players_w_2016_hr USING (playerid)
WHERE years_playing >= 10
AND batting.hr >= career_high
AND batting.yearid = 2016
ORDER BY homeruns_2016 ASC;

