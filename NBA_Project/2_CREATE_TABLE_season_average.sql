/* 

Questions: How do we create a table that has the season averages for all the statsitical
categories we will be tracking?

This query grabs the averages for all 18 statisitcal categories/stats we will be tracking.
From here, we get a result that show all NBA teams and their season averages.

*/

DROP TABLE IF EXISTS team_season_averages;

CREATE TABLE team_season_averages AS
SELECT 
    TEAM_NAME,
    COUNT(*) AS games_played,
    ROUND(AVG(FGM)::numeric, 2) AS avg_fgm,
    ROUND(AVG(FGA)::numeric, 2) AS avg_fga,
    ROUND(AVG(FG_PCT)::numeric, 3) AS avg_fg_pct,
    ROUND(AVG(FG3M)::numeric, 2) AS avg_fg3m,
    ROUND(AVG(FG3A)::numeric, 2) AS avg_fg3a,
    ROUND(AVG(FG3_PCT)::numeric, 3) AS avg_fg3_pct,
    ROUND(AVG(FTM)::numeric, 2) AS avg_ftm,
    ROUND(AVG(FTA)::numeric, 2) AS avg_fta,
    ROUND(AVG(FT_PCT)::numeric, 3) AS avg_ft_pct,
    ROUND(AVG(OREB)::numeric, 2) AS avg_oreb,
    ROUND(AVG(DREB)::numeric, 2) AS avg_dreb,
    ROUND(AVG(REB)::numeric, 2) AS avg_reb,
    ROUND(AVG(AST)::numeric, 2) AS avg_ast,
    ROUND(AVG(STL)::numeric, 2) AS avg_stl,
    ROUND(AVG(BLK)::numeric, 2) AS avg_blk,
    ROUND(AVG(TOV)::numeric, 2) AS avg_tov,
    ROUND(AVG(PF)::numeric, 2) AS avg_pf,
    ROUND(AVG(PTS)::numeric, 2) AS avg_pts
FROM team_game_stats
GROUP BY TEAM_NAME;
