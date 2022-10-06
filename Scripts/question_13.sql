/* Q13
   It is thought that since left-handed pitchers are more rare, causing batters to face them less often,
   they are more effective. Investigate this claim and present evidence to either support or dispute this claim.
   First, determine just how rare left-handed pitchers are compared with right-handed pitchers.
   Are left-handed pitchers more likely to win the Cy Young Award (Best Pitcher in MLB)?
   Are they more likely to make it into the hall of fame? */
   
   
   
/* Analysis of pitchers, showing that about 27% of all pitchers are left-handed. */

SELECT throws,
       count(*)::NUMERIC,
       round(count(*) * 100 / SUM (COUNT (*)) OVER (), 1) AS percentage_total
FROM people
WHERE playerid IN
            (SELECT DISTINCT playerid
             FROM pitching)
GROUP BY throws;



/* Analysis of CY Young Award winners: 33% of winners were left-handed. This shows that 
   the percentage of left-handed pitchers who won the award is about 6% higher than the 
   overall percentage of left-handed pitchers who've ever played. */

WITH award_winners AS
      (SELECT playerid
       FROM awardsplayers
       WHERE awardid LIKE 'Cy Young Award')

SELECT throws,
       COUNT(*),
       ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(), 1) AS percentage_total
FROM award_winners
LEFT JOIN people USING (playerid)
GROUP BY throws;



/* Analysis of Hall of Fame winners: about 23% of winners who 
   were pitchers were left-handed, indicating no correlation between being 
   left-handed and being inducted into the Hall of Fame. */

WITH hof_winners AS
      (SELECT playerid
       FROM halloffame
       WHERE inducted = 'Y')
      
SELECT throws,
       COUNT(*),
       ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(), 1) AS percentage_total
FROM hof_winners
LEFT JOIN people USING (playerid)
WHERE people.playerid IN (SELECT DISTINCT playerid FROM pitching)
GROUP BY throws;



/* What percentage of strikeouts were achieved by left-handed pitchers?
   Conclusion: 27% of total strikeouts were achieved by left-handed pitchers, which 
   correlates closely with the total % of left-handed pitchers who've ever played. 
   Therefore there seems to be no correlation between pitching left-handed and 
   achieving strikeouts. A similar lack of correlation seems to exist for most other 
   relevent pitching stats, disproving the theory that left-handed pitchers are more 
   effective. */
   
WITH pitcher_so AS 
(SELECT playerid,
       sum(so) AS total_so,
       CASE
           WHEN throws = 'R' THEN 'R'
           WHEN throws = 'L' THEN 'L'
           ELSE 'other'
       END AS throwing_hand
FROM pitching
INNER JOIN people USING (playerid)
GROUP BY playerid,
         throwing_hand
ORDER BY playerid)

SELECT pitcher_so.throwing_hand,
       sum(total_so) AS sum_so,
       ROUND(count(*) * 100 / sum(count(*)) OVER(), 1) as percentage_total
FROM pitcher_so
GROUP BY pitcher_so.throwing_hand;

