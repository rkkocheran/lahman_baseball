/* Q9: Which managers have won the TSN Manager of the Year award in both the National League (NL) 
       and the American League (AL)? Give their full name and the teams that they were managing when 
       they won the award. 
       
     A: "Jim Leyland" won in the NL in 1988, 1990, 1992 with the "Pittsburgh Pirates";
         and in the AL in 2006 with the "Detroit Tigers".
        "Davey Johnson" won in the NL in 2012 with the "Washington Nationals";
         and in the AL in 1997 with the "Baltimore Orioles". */

WITH nl_managers AS (
      SELECT DISTINCT playerid,
             CONCAT(namefirst, ' ', namelast) AS name,
             t.name AS nl_team,
             am.yearid AS nl_year,
             am.lgid AS nl_lg
      FROM awardsmanagers AS am
      INNER JOIN people AS p USING (playerid)
      INNER JOIN managers AS m USING (playerid, yearid, lgid)
      INNER JOIN teams AS t USING (yearid, lgid, teamid)
      WHERE awardid ILIKE 'TSN Manager of the Year'
            AND lgid ILIKE 'NL'
),
al_managers AS (
      SELECT DISTINCT playerid,
             CONCAT(namefirst, ' ', namelast) AS name,
             t.name AS al_team,
             yearid AS al_year, 
             lgid AS al_lg
      FROM awardsmanagers AS am
      INNER JOIN people AS p USING (playerid)
      INNER JOIN managers AS m USING (playerid, yearid, lgid)
      INNER JOIN teams AS t USING (yearid, lgid, teamid)
      WHERE awardid ILIKE 'TSN Manager of the Year'
            AND lgid ILIKE 'AL'
)

SELECT nl.name, nl_year, nl_team, al_year, al_team
FROM nl_managers AS nl
INNER JOIN al_managers AS al USING (playerid)
ORDER BY nl_year, al_year;
