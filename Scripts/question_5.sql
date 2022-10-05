/*5. Find the average number of strikeouts per game by decade since 1920. Round the numbers 
you report to 2 decimal places. Do the same for home runs per game. Do you see any trends?*/
--Strikeouts (so), Homeruns (hr) in pitching table

SELECT CONCAT(LEFT(yearid::text,3),'0''s') AS decade, 
	ROUND(AVG(so/g),2) AS avg_so_per_game,
	ROUND(AVG(hr/g),2) AS avg_hr_per_game
FROM pitching
WHERE LEFT(yearid::text,3)::integer >= 192
GROUP BY LEFT(yearid::text,3)
ORDER BY decade ASC;