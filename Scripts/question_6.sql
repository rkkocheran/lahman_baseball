/* Q6
   Find the player who had the most success stealing bases in 2016, 
   where __success__ is measured as the percentage of stolen base attempts which are successful. 
   (A stolen base attempt results either in a stolen base or being caught stealing.) 
   Consider only players who attempted _at least_ 20 stolen bases.
   
   A: Chris Owings with 21 successfully stolen bases and 23 total attempts (91.3% success rate). */

SELECT namefirst,
       namelast,
       ROUND((SUM(sb)::numeric / (SUM(sb) + SUM(cs)) * 100.0), 1) AS percent_success,
       (SUM(sb) + SUM(cs)) AS n_attempts,
       SUM(sb) AS n_success,
       SUM(cs) AS n_fail
FROM batting AS b
INNER JOIN people USING (playerid)
WHERE b.yearid = 2016
GROUP BY playerid,
         namefirst,
         namelast
HAVING (SUM(sb) + SUM(cs)) >= 20
ORDER BY percent_success DESC
LIMIT 1;