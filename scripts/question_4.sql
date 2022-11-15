/* Q4: Using the fielding table, group players into three groups based on their position: label players with 
       position OF as "Outfield", those with position "SS", "1B", "2B", and "3B" as "Infield", and those with 
       position "P" or "C" as "Battery". Determine the number of putouts made by each of these three groups in 2016.
     
    A: "Infield" with 58934 putouts, "Battery" with 41424, "Outfield" with 29560. */
    
SELECT yearid, SUM(po) AS putouts,
       CASE WHEN pos = 'OF' THEN 'Outfield'
	      WHEN pos ILIKE '%B' 
                 OR pos ILIKE 'SS' THEN 'Infield'
 	      ELSE 'Battery' 
            END AS position
FROM fielding
WHERE yearid = 2016
GROUP BY yearid, position
ORDER BY putouts DESC;