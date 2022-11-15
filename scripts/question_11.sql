/* Q11: Is there any correlation between number of wins and team salary? Use data from 2000 and later to answer this 
        question. As you do this analysis, keep in mind that salaries across the whole league tend to increase together, 
        so you may want to look on a year-by-year basis. 

     A: Used a calculated field to determine the average salary for each team and year. With an addition calculated field, 
        dol_per_win_thous, to determine the dollars per win in 'thousands' for each team and year, showing how salary has 
        increased over time. Using pivot tables/charts to analyze the data indicates there does appear to be a loose 
        correlation between wins and salary. */
   
SELECT DISTINCT teamid,
                s.yearid,
                w,
                (AVG(salary) OVER(PARTITION BY teamid, s.yearid))::NUMERIC::MONEY AS avg_salary,
                (((AVG(salary) OVER(PARTITION BY teamid, s.yearid))::NUMERIC / w) / 1000.0)::MONEY AS dol_per_win_thous
FROM teams AS t
INNER JOIN salaries AS s USING (teamid)
WHERE t.yearid >= 2000
      AND t.yearid = s.yearid
ORDER BY teamid, s.yearid