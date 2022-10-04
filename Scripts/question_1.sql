--1. What range of years for baseball games played does the provided database cover?
SELECT DISTINCT MIN(yearid) AS first_year, MAX(yearid) AS last_year
FROM appearances;