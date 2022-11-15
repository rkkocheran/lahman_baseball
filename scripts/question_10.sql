/* Q10: Find all players who hit their career highest number of home runs in 2016. Consider only players who have 
        played in the league for at least 10 years, and who hit at least one home run in 2016. Report the players' 
        first and last names and the number of home runs they hit in 2016. 
        
     A:     name	                  max_hr
            "Edwin Encarnacion"	42
            "Robinson Cano"	      39
            "Mike Napoli"	      34
            "Angel Pagan"	      12
            "Rajai Davis"	      12
            "Adam Wainwright"	      2
            "Bartolo Colon"	      1
            "Francisco Liriano"	1
*/

WITH valid_players_max AS (
      SELECT playerid, 
             MAX(hr) AS max_hr
      FROM appearances
      INNER JOIN batting USING (playerid, yearid, teamid)
      GROUP BY playerid
      HAVING MAX(hr) >= 1
             AND (MAX(yearid) - MIN(yearid)) >= 10
      ORDER BY playerid
)

SELECT CONCAT(namefirst, ' ', namelast) AS name,
       max_hr
FROM batting
INNER JOIN people USING (playerid)
INNER JOIN valid_players_max USING (playerid)
WHERE hr >= 1 
      AND hr = max_hr 
      AND yearid = 2016
ORDER BY max_hr DESC, name;
