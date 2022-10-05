--QUESTION 4
SELECT SUM(po) AS putouts,
  CASE WHEN pos = 'OF' THEN 'Outfield'
	 WHEN pos ILIKE '%B' OR pos ILIKE 'SS' THEN 'Infield'
 	 ELSE 'Battery' END AS position
FROM fielding
WHERE yearid = 2016
GROUP BY position;