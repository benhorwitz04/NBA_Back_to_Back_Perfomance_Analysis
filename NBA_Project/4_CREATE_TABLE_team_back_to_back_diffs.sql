/* 

Question: How do we create a table that provides
us with the differences of performance between
regular season games and 2nd games after a back-to-back
contest?


Creates a table of season averages and the 
back-to-back second-day averages differences. We run this
query to make it effectively gives us the information.

*/

CREATE TABLE team_back_to_back_diffs AS
SELECT 
    s.TEAM_NAME,
    s.avg_fgm - b.avg_fgm AS fgm_diff,
    s.avg_fga - b.avg_fga AS fga_diff,
    s.avg_fg_pct - b.avg_fg_pct AS fg_pct_diff,
    s.avg_fg3m - b.avg_fg3m AS fg3m_diff,
    s.avg_fg3a - b.avg_fg3a AS fg3a_diff,
    s.avg_fg3_pct - b.avg_fg3_pct AS fg3_pct_diff,
    s.avg_ftm - b.avg_ftm AS ftm_diff,
    s.avg_fta - b.avg_fta AS fta_diff,
    s.avg_ft_pct - b.avg_ft_pct AS ft_pct_diff,
    s.avg_oreb - b.avg_oreb AS oreb_diff,
    s.avg_dreb - b.avg_dreb AS dreb_diff,
    s.avg_reb - b.avg_reb AS reb_diff,
    s.avg_ast - b.avg_ast AS ast_diff,
    s.avg_stl - b.avg_stl AS stl_diff,
    s.avg_blk - b.avg_blk AS blk_diff,
    s.avg_tov - b.avg_tov AS tov_diff,
    s.avg_pf - b.avg_pf AS pf_diff,
    s.avg_pts - b.avg_pts AS pts_diff
FROM team_season_averages s
JOIN team_back_to_back_averages b ON s.TEAM_NAME = b.TEAM_NAME;


/* 

Explanation:

s: Aliased for team_season_averages (the season averages).

b: Aliased for team_back_to_back_averages (the second-day back-to-back averages).

For each stat (e.g., avg_fgm, avg_pts), we're calculating the difference between the 
season average (s.avg_fgm) and the back-to-back second-day average (b.avg_fgm).
The result will show the change (positive or negative) in each of these statistics.


Additional notes about the inforamtion that is produced:

For stats like avg_tov (turnovers, personal fouls), where a higher
value is considered worse performance, the difference in the query
(s.avg_tov - b.avg_tov) reflects that a negative difference indicates
worse performance (more turnovers) on the second day of a back-to-back contest,
and a positive difference indicates better performance (fewer turnovers).

To clarify:

If the result for tov_diff is positive (e.g., 1.5), it means the team had fewer turnovers
on the second day of a back-to-back, which is an improvement.

If the result for tov_diff is negative (e.g., -1.5), it means the team had more turnovers
on the second day of a back-to-back, which is worse performance.

The same reasoning can be applied to personal fouls.

*/
