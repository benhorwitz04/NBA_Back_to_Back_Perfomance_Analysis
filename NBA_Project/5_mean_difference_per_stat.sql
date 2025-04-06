/* 

Question: How do we find the average differences of
all 29 NBA teams we examined so we can create
a general average for each statisical
category?

From the previously created table,
we have a query that provides us with the
mean difference per stat across the NBA.
We get one row with 18 categories/stats.

*/

SELECT
    ROUND(AVG(fgm_diff), 2) AS avg_fgm_diff,
    ROUND(AVG(fga_diff), 2) AS avg_fga_diff,
    ROUND(AVG(fg_pct_diff), 3) AS avg_fg_pct_diff,
    ROUND(AVG(fg3m_diff), 2) AS avg_fg3m_diff,
    ROUND(AVG(fg3a_diff), 2) AS avg_fg3a_diff,
    ROUND(AVG(fg3_pct_diff), 3) AS avg_fg3_pct_diff,
    ROUND(AVG(ftm_diff), 2) AS avg_ftm_diff,
    ROUND(AVG(fta_diff), 2) AS avg_fta_diff,
    ROUND(AVG(ft_pct_diff), 3) AS avg_ft_pct_diff,
    ROUND(AVG(oreb_diff), 2) AS avg_oreb_diff,
    ROUND(AVG(dreb_diff), 2) AS avg_dreb_diff,
    ROUND(AVG(reb_diff), 2) AS avg_reb_diff,
    ROUND(AVG(ast_diff), 2) AS avg_ast_diff,
    ROUND(AVG(stl_diff), 2) AS avg_stl_diff,
    ROUND(AVG(blk_diff), 2) AS avg_blk_diff,
    ROUND(AVG(tov_diff), 2) AS avg_tov_diff,
    ROUND(AVG(pf_diff), 2) AS avg_pf_diff,
    ROUND(AVG(pts_diff), 2) AS avg_pts_diff
FROM team_back_to_back_diffs;


/* We used the team_back_to_back_avg results to create this query.
What this executes is the avergae difference,
across the whole NBA. It will produce one row with the 18
columns/stats we orignally looked at. */
