/* Q13
   It is thought that since left-handed pitchers are more rare, causing batters to face them less often,
   they are more effective. Investigate this claim and present evidence to either support or dispute this claim.
   First, determine just how rare left-handed pitchers are compared with right-handed pitchers.
   Are left-handed pitchers more likely to win the Cy Young Award (Best Pitcher in MLB)?
   Are they more likely to make it into the hall of fame? */
   
   
/* Analysis of pitchers, showing that about 26% of all pitchers are left-handed. */

WITH pitchers AS (
SELECT DISTINCT playerid
FROM pitching
UNION
SELECT DISTINCT playerid
FROM pitchingpost) 

SELECT throws,
       COUNT(*)::NUMERIC,
       round(COUNT(*) * 100 / SUM (COUNT (*)) OVER (), 1) AS percentage_total
FROM people
WHERE playerid IN (SELECT * FROM pitchers)
GROUP BY throws;


/* Analysis of CY Young Award winners, showing only 33% of winners were left-handed. */

WITH award_winners AS
      (SELECT *
       FROM awardsplayers
       WHERE awardid LIKE 'Cy Young Award')

SELECT throws,
       COUNT(*),
       ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(), 1) AS percentage_total
FROM award_winners AS a
LEFT JOIN people AS p USING (playerid)
GROUP BY throws;


/* Analysis of Hall of Fame winners, showing only about 23% of winners who 
   were pitchers were left-handed. */

WITH hof_winners AS
      (SELECT *
       FROM halloffame
       WHERE inducted = 'Y'),
pitchers AS
      (SELECT DISTINCT playerid
       FROM pitching
       UNION SELECT DISTINCT playerid
       FROM pitchingpost)
      
SELECT throws,
       COUNT(*),
       ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(), 1) AS percentage_total
FROM hof_winners AS a
LEFT JOIN people AS p USING (playerid)
WHERE p.playerid IN (SELECT * FROM pitchers)
GROUP BY throws;


/* IN PROGRESS: What percentage of homeruns were allowed by left-handed pitchers? */
SELECT hr
FROM pitching

