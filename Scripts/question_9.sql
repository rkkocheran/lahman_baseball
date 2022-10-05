/* Which managers have won the TSN Manager of the Year award in both the National League (NL) 
and the American League (AL)? Give their full name and the teams that they were managing when 
they won the award. */

/*
SELECT DISTINCT *
FROM awardsmanagers
WHERE awardsmanagers.awardid = 'TSN Manager of the Year' AND (lgid ILIKE('AL') OR 
	lgid ILIKE('NL'))
ORDER BY playerid;
*/

SELECT nl_playerid, nl_yearid, al_yearid, namefirst, namelast--, nl_team, al_team
FROM (SELECT playerid AS nl_playerid,
			awardid AS nl_awardid,
			yearid AS nl_yearid
	FROM awardsmanagers
	WHERE lgid = 'NL' AND awardid = 'TSN Manager of the Year') AS nl_tsn
INNER JOIN (SELECT playerid AS al_playerid,
			awardid AS al_awardid,
			yearid AS al_yearid
	FROM awardsmanagers
	WHERE lgid = 'AL' AND awardid = 'TSN Manager of the Year') AS al_tsn
ON nl_playerid = al_playerid
INNER JOIN people ON nl_playerid = people.playerid;


SELECT DISTINCT managers.playerid, namefirst, namelast, managers.yearid, managers.teamid, name
FROM managers INNER JOIN teams ON managers.teamid = teams.teamid
INNER JOIN people ON people.playerid = managers.playerid
WHERE (managers.playerid = 'leylaji99' AND (managers.yearid = 1988 OR managers.yearid =1990 OR 
								   managers.yearid = 1992 OR managers.yearid = 2006))
		OR (managers.playerid = 'johnsda02' AND (managers.yearid =1997 OR managers.yearid = 2012))
ORDER BY managers.yearid;