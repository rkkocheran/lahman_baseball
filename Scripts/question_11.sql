/* Q11
   Is there any correlation between number of wins and team salary? Use data from 2000 and later to answer this question. 
   As you do this analysis, keep in mind that salaries across the whole league tend to increase together, so you may want 
   to look on a year-by-year basis. */

SELECT teamid,
       g,
       w,
       l,
       t.lgid,
       s.playerid,
       s.yearid,
       salary,
       (AVG(salary) OVER (PARTITION BY teamid, s.yearid))::NUMERIC::MONEY AS avg_salary
FROM teams AS t
INNER JOIN salaries AS s USING (teamid)
WHERE t.yearid >= 2000
      AND t.yearid = s.yearid
