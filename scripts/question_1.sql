/* Q1: What range of years for baseball games played does the provided database cover? 
    
    A: 1871 to 2016, with 145 total years. */

SELECT DISTINCT MIN(yearid) AS first_year, 
       MAX(yearid) AS last_year,
       (MAX(yearid) - MIN(yearid)) AS total_years
FROM teams;