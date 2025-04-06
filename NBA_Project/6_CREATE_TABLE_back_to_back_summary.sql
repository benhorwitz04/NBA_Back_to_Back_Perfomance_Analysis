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

SELECT 'fgm' AS stat, fgm AS avg_diff,
    CASE WHEN fgm > 0 THEN 'Better'
         WHEN fgm < 0 THEN 'Worse'
         ELSE 'No Change' END AS impact
FROM diffs

UNION ALL SELECT 'fga', fga,
    CASE WHEN fga > 0 THEN 'Better'
         WHEN fga < 0 THEN 'Worse'
         ELSE 'No Change' END
FROM diffs

UNION ALL SELECT 'fg_pct', fg_pct,
    CASE WHEN fg_pct > 0 THEN 'Better'
         WHEN fg_pct < 0 THEN 'Worse'
         ELSE 'No Change' END
FROM diffs

UNION ALL SELECT 'fg3m', fg3m,
    CASE WHEN fg3m > 0 THEN 'Better'
         WHEN fg3m < 0 THEN 'Worse'
         ELSE 'No Change' END
FROM diffs

UNION ALL SELECT 'fg3a', fg3a,
    CASE WHEN fg3a > 0 THEN 'Better'
         WHEN fg3a < 0 THEN 'Worse'
         ELSE 'No Change' END
FROM diffs

UNION ALL SELECT 'fg3_pct', fg3_pct,
    CASE WHEN fg3_pct > 0 THEN 'Better'
         WHEN fg3_pct < 0 THEN 'Worse'
         ELSE 'No Change' END
FROM diffs

UNION ALL SELECT 'ftm', ftm,
    CASE WHEN ftm > 0 THEN 'Better'
         WHEN ftm < 0 THEN 'Worse'
         ELSE 'No Change' END
FROM diffs

UNION ALL SELECT 'fta', fta,
    CASE WHEN fta > 0 THEN 'Better'
         WHEN fta < 0 THEN 'Worse'
         ELSE 'No Change' END
FROM diffs

UNION ALL SELECT 'ft_pct', ft_pct,
    CASE WHEN ft_pct > 0 THEN 'Better'
         WHEN ft_pct < 0 THEN 'Worse'
         ELSE 'No Change' END
FROM diffs

UNION ALL SELECT 'oreb', oreb,
    CASE WHEN oreb > 0 THEN 'Better'
         WHEN oreb < 0 THEN 'Worse'
         ELSE 'No Change' END
FROM diffs

UNION ALL SELECT 'dreb', dreb,
    CASE WHEN dreb > 0 THEN 'Better'
         WHEN dreb < 0 THEN 'Worse'
         ELSE 'No Change' END
FROM diffs

UNION ALL SELECT 'reb', reb,
    CASE WHEN reb > 0 THEN 'Better'
         WHEN reb < 0 THEN 'Worse'
         ELSE 'No Change' END
FROM diffs

UNION ALL SELECT 'ast', ast,
    CASE WHEN ast > 0 THEN 'Better'
         WHEN ast < 0 THEN 'Worse'
         ELSE 'No Change' END
FROM diffs

UNION ALL SELECT 'stl', stl,
    CASE WHEN stl > 0 THEN 'Better'
         WHEN stl < 0 THEN 'Worse'
         ELSE 'No Change' END
FROM diffs

UNION ALL SELECT 'blk', blk,
    CASE WHEN blk > 0 THEN 'Better'
         WHEN blk < 0 THEN 'Worse'
         ELSE 'No Change' END
FROM diffs

-- Reversed logic for TOV: lower is better
UNION ALL SELECT 'tov', tov,
    CASE WHEN tov < 0 THEN 'Better'
         WHEN tov > 0 THEN 'Worse'
         ELSE 'No Change' END
FROM diffs

-- Reversed logic for PF: lower is better
UNION ALL SELECT 'pf', pf,
    CASE WHEN pf < 0 THEN 'Better'
         WHEN pf > 0 THEN 'Worse'
         ELSE 'No Change' END
FROM diffs

UNION ALL SELECT 'pts', pts,
    CASE WHEN pts > 0 THEN 'Better'
         WHEN pts < 0 THEN 'Worse'
         ELSE 'No Change' END
FROM diffs;
