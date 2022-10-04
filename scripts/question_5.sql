/*5. Find the average number of strikeouts per game by decade since 1920. Round the numbers 
you report to 2 decimal places. Do the same for home runs per game. Do you see any trends?*/
--Strikeouts (so), Homeruns (hr) in pitching table

SELECT CONCAT(LEFT(yearid::text,3),'0''s') AS decade, 
	ROUND(AVG(so),2) AS avg_so,
	ROUND(AVG(hr),2) AS avg_hr
FROM pitching
WHERE LEFT(yearid::text,3)::integer >= 192
GROUP BY LEFT(yearid::text,3)
ORDER BY decade ASC;