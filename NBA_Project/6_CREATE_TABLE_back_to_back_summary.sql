/* 

Question: How do we start to break down and organize
perfromance from the tables and data we created?

Here we start our summary process. First we need to
clarify what is considered postive vs. a negative when 
comparing back-to-back contest against season avg.
Within that, we need to make sure the data is accuratley
judged as an improvement or decline. 

✅ Step 1: Stat Classification
We'll group stats into two categories:

“Higher = Better” stats:
fgm, fga, fg_pct
fg3m, fg3a, fg3_pct
ftm, fta, ft_pct
oreb, dreb, reb
ast, stl, blk, pts

16 total statistical categories

❌ “Higher = Worse” stats:
tov, pf

2 total statistical categories


To make the interpretation much more intuitive from the query below:

Positive value → teams performed better on second day.

Negative value → teams performed worse on second day.

For TOV and PF, we’ll still reverse the logic because lower values are better.

*/

CREATE TABLE team_back_to_back_avg_diffs_summary AS
WITH diffs AS (
    SELECT
        ROUND(AVG(-fgm_diff), 2) AS fgm,
        ROUND(AVG(-fga_diff), 2) AS fga,
        ROUND(AVG(-fg_pct_diff), 3) AS fg_pct,
        ROUND(AVG(-fg3m_diff), 2) AS fg3m,
        ROUND(AVG(-fg3a_diff), 2) AS fg3a,
        ROUND(AVG(-fg3_pct_diff), 3) AS fg3_pct,
        ROUND(AVG(-ftm_diff), 2) AS ftm,
        ROUND(AVG(-fta_diff), 2) AS fta,
        ROUND(AVG(-ft_pct_diff), 3) AS ft_pct,
        ROUND(AVG(-oreb_diff), 2) AS oreb,
        ROUND(AVG(-dreb_diff), 2) AS dreb,
        ROUND(AVG(-reb_diff), 2) AS reb,
        ROUND(AVG(-ast_diff), 2) AS ast,
        ROUND(AVG(-stl_diff), 2) AS stl,
        ROUND(AVG(-blk_diff), 2) AS blk,
        ROUND(AVG(-tov_diff), 2) AS tov,
        ROUND(AVG(-pf_diff), 2) AS pf,
        ROUND(AVG(-pts_diff), 2) AS pts
    FROM team_back_to_back_diffs
)

SELECT
    stat,
    avg_diff,
    CASE
        WHEN stat IN ('tov', 'pf') THEN  -- Special handling for TOV and PF
            CASE
                WHEN avg_diff < 0 THEN 'Better'  -- Lower turnovers/fouls are better
                WHEN avg_diff > 0 THEN 'Worse'  -- Higher turnovers/fouls are worse
                ELSE 'No Change'
            END
        ELSE  -- General case for other statistics
            CASE
                WHEN avg_diff > 0 THEN 'Better'
                WHEN avg_diff < 0 THEN 'Worse'
                ELSE 'No Change'
            END
    END AS impact
FROM (
    SELECT 'fgm' AS stat, fgm AS avg_diff FROM diffs
    UNION ALL
    SELECT 'fga', fga FROM diffs
    UNION ALL
    SELECT 'fg_pct', fg_pct FROM diffs
    UNION ALL
    SELECT 'fg3m', fg3m FROM diffs
    UNION ALL
    SELECT 'fg3a', fg3a FROM diffs
    UNION ALL
    SELECT 'fg3_pct', fg3_pct FROM diffs
    UNION ALL
    SELECT 'ftm', ftm FROM diffs
    UNION ALL
    SELECT 'fta', fta FROM diffs
    UNION ALL
    SELECT 'ft_pct', ft_pct FROM diffs
    UNION ALL
    SELECT 'oreb', oreb FROM diffs
    UNION ALL
    SELECT 'dreb', dreb FROM diffs
    UNION ALL
    SELECT 'reb', reb FROM diffs
    UNION ALL
    SELECT 'ast', ast FROM diffs
    UNION ALL
    SELECT 'stl', stl FROM diffs
    UNION ALL
    SELECT 'blk', blk FROM diffs
    UNION ALL
    SELECT 'tov', tov FROM diffs
    UNION ALL
    SELECT 'pf', pf FROM diffs
    UNION ALL
    SELECT 'pts', pts FROM diffs
) AS summary;

