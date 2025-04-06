/* 

Question: How do we get the season avgs. of each
NBA team?

This is a sample query to ensure we can effectively 
get all the data from each indiviudal team in the NBA.
We get 28 columns, but eventually will break this down
to 18 stats that we will measure.

*/

-- All games for the Golden State Warriors
SELECT * FROM team_game_stats
WHERE team_name = 'Golden State Warriors';

-- Average points per game per team
SELECT team_name, AVG(pts) AS avg_points
FROM team_game_stats
GROUP BY team_name
ORDER BY avg_points DESC;

-- Wins vs Losses count per team
SELECT team_name, wl, COUNT(*) AS games
FROM team_game_stats
GROUP BY team_name, wl
ORDER BY team_name, wl;
