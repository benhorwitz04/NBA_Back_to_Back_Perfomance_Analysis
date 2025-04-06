/*

This is our final report query.
Here we create a table that shows a summary
of the averages and their deviation compared to their season avg.
It also provides an answer to our question:
How do teams preform in the second day of
a back-to-back contest, compared against their end of season avg.
We also order the breakdown from biggest changes in descending order.

*/

CREATE TABLE back_to_back_stat_deviation_summary AS
WITH base AS (
    SELECT *
    FROM team_back_to_back_avg_diffs_summary
),
season AS (
    SELECT
        'fgm' AS stat, ROUND(AVG(avg_fgm), 2) AS season_avg FROM team_season_averages
    UNION ALL SELECT 'fga', ROUND(AVG(avg_fga), 2) FROM team_season_averages
    UNION ALL SELECT 'fg_pct', ROUND(AVG(avg_fg_pct), 3) FROM team_season_averages
    UNION ALL SELECT 'fg3m', ROUND(AVG(avg_fg3m), 2) FROM team_season_averages
    UNION ALL SELECT 'fg3a', ROUND(AVG(avg_fg3a), 2) FROM team_season_averages
    UNION ALL SELECT 'fg3_pct', ROUND(AVG(avg_fg3_pct), 3) FROM team_season_averages
    UNION ALL SELECT 'ftm', ROUND(AVG(avg_ftm), 2) FROM team_season_averages
    UNION ALL SELECT 'fta', ROUND(AVG(avg_fta), 2) FROM team_season_averages
    UNION ALL SELECT 'ft_pct', ROUND(AVG(avg_ft_pct), 3) FROM team_season_averages
    UNION ALL SELECT 'oreb', ROUND(AVG(avg_oreb), 2) FROM team_season_averages
    UNION ALL SELECT 'dreb', ROUND(AVG(avg_dreb), 2) FROM team_season_averages
    UNION ALL SELECT 'reb', ROUND(AVG(avg_reb), 2) FROM team_season_averages
    UNION ALL SELECT 'ast', ROUND(AVG(avg_ast), 2) FROM team_season_averages
    UNION ALL SELECT 'stl', ROUND(AVG(avg_stl), 2) FROM team_season_averages
    UNION ALL SELECT 'blk', ROUND(AVG(avg_blk), 2) FROM team_season_averages
    UNION ALL SELECT 'tov', ROUND(AVG(avg_tov), 2) FROM team_season_averages
    UNION ALL SELECT 'pf', ROUND(AVG(avg_pf), 2) FROM team_season_averages
    UNION ALL SELECT 'pts', ROUND(AVG(avg_pts), 2) FROM team_season_averages
)
SELECT 
    b.stat,
    b.avg_diff,
    s.season_avg,
    ROUND(b.avg_diff / NULLIF(s.season_avg, 0) * 100, 2) AS percent_change,
    ROUND(ABS(b.avg_diff), 3) AS deviation_magnitude,
    b.impact
FROM base b
JOIN season s ON b.stat = s.stat
ORDER BY deviation_magnitude DESC;
