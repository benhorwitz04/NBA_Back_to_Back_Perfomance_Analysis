/*

Question: How do we create a table that contains all
the averages of ONLY 2nd day games, after a back-to-back
contest for each NBA team?

This query allows us to create a table
that will gather all the averages for teams
on the 2nd day of a back-to-back contest.

*/

CREATE TABLE team_back_to_back_averages AS
WITH second_day_games AS (
    SELECT 
        t1.TEAM_NAME,
        t1.game_date,
        t1.FGM, t1.FGA, t1.FG_PCT, t1.FG3M, t1.FG3A, t1.FG3_PCT,
        t1.FTM, t1.FTA, t1.FT_PCT, t1.OREB, t1.DREB, t1.REB,
        t1.AST, t1.STL, t1.BLK, t1.TOV, t1.PF, t1.PTS,
        -- Get the previous game's date for the same team using LAG()
        LAG(t1.game_date) OVER (PARTITION BY t1.TEAM_NAME ORDER BY t1.game_date) AS prev_game_date
    FROM team_game_stats t1
)
-- Now, filter out the second games of back-to-backs
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
FROM second_day_games
WHERE prev_game_date IS NOT NULL  -- Ensure there is a previous game to compare
AND AGE(game_date, prev_game_date) = INTERVAL '1 day'  -- Use AGE() function to get the interval difference
GROUP BY TEAM_NAME;
