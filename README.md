# NBA Back-to-Back Game Performance Analysis

# Overview

This project analyzes how NBA teams perform on the second day of back-to-back games compared to their averages during the 2023-2024 season. The analysis includes various key statistics such as points scored, turnovers, field goals made, rebounds, and more. By comparing these metrics, we aim to identify how fatigue affects team performance and determine if there are consistent patterns across teams.

# Background

This project was initially constructed as a way to dive deeper into the world of data analytics. For the past five years, I've worked as a basketball coach at Hobart College. One of the unique aspects of the Liberty League conference we compete in is the schedule for our conference games. We play 18 games each year, with 16 of those contests being scheduled as back-to-back competitions for leauge play. This is a rare scheduling decision in college basketball, as many other conferences decide to split up games by at least 1 or more days. 

I wanted to explore how the performance of the second game of a back-to-back contest compares to the rest of the season averages. The NBA presents a much larger scale of data to pull from and provides a glimpse into how team performance is affected by scheduling. I used data from the 2023-2024 season, as it is the most recently completed NBA regular season. I did not include playoff games, and focused on the typical 82 regular game season. 
*Pleaese note that not all teams have the same amount of back-to-back games scheduled duirng there season.

# Tools I Used & Project Structure

- **data**: Contains raw data files, including team statistics and game-by-game performance data.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **python**: Python scripts for scraping data from nba.api.stats were executed on VS Code (an open-source, and highly customizable code editor developed by Microsoft)
- **sql**: SQL scripts for creating and querying databases to provide answers and insights to our questions.
- **results**: Final analysis, including summary tables and queries published here on GitHub.
- **README.md**: The readme file you are currently reading!

# The Analysis

Each query for this project was aimed at breaking down the raw data in order to answer our questions. Here was my approach:


1. **Team Season Averages**: I first had to organize the key statistics for each team, and calculate their averages throughout the season.

```sql
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
```

Here we are able to create our 16 statistical categories for each team, and use the **ROUND(AVG)** to find the averages. This query was used to create a table containing all 29 teams that were analyzed.

2. **Back to Back Season Averages**:

The next phase of this process was to find our comparison of stats A.K.A the averages of all the back-to-back contests. With the help of Chat GPT, I was able to put together a query that could seperate the games based on the date they were played.

The key part of the code that allows it to retrieve data from different dates (specifically consecutive dates) lies in the use of:

The **LAG()** function: This function ensures that for each game, the system knows the date of the previous game for the same team. It creates a "shifted" view of the data, where you can access both the current game's statistics and the previous game's date.
The **AGE()** function: This function calculates the interval between the current game date (game_date) and the previous game date (prev_game_date). The condition AGE(game_date, prev_game_date) = INTERVAL '1 day' ensures that only games played one day apart are included in the results. This helps to isolate the second game of a back-to-back.

```sql
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
```

   | team_name |	games_played |	avg_fgm |	avg_fga |	avg_fg_pct |	avg_tov |
   |------| -------- | --------   | --------  | --------| -------- |
   | Atlanta Hawks |	15 |	42.60 |	92.47 |	0.463 |	12.27 |
   | Boston Celtics |	14 |	45.36 |	91.36 |	0.497 |	10.14 |
   | Brooklyn Nets |	14 |	39.50 |	89.07 |	0.444 |	11.79 |
   | Charlotte Hornets |	15 |	41.40  |	87.07 |	0.477 |	12.00 |
   | Chicago Bulls |	14	 | 41.50 |	91.21 |	0.457 |	10.93 |

*A table showing the average performance for teams on the second day of back-to-back contests.*

3. **Differences in Back-to-Back Games**: Getting closer to our goal, the next step focused on calculating the differences betweent the second day of a back-to-back contest against the overall avergaes of the team we found in step 1. The table we create from this query allow us to get a row for each of the 29 teams we are analyzing, along with the 16 stats we are focused on. An **INNER JOIN** is excuted here to ensure that the statistics are matched for the same team across both datasets.

**Additional notes about the inforamtion that is produced:**
For stats like avg_tov (turnovers, personal fouls), where a higher
value is considered worse performance, the difference in the query
(s.avg_tov - b.avg_tov) reflects that a negative difference indicates
worse performance (more turnovers) on the second day of a back-to-back contest,
and a positive difference indicates better performance (fewer turnovers).

```sql
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
```
   |team | fgm_diff |	fga_diff |	fg_pct_diff |	pts_diff	|tov_diff |
   |------| -------- | --------   | --------  | --------| -------- |
   | Atlanta Hawks | 0.44 |	0.02 |	0.003	| 2.66	| 0.49 |
   |Boston Celtics | -1.45 |	-1.16 |	-0.009 |	-2.86 |	1.13 |
   | Brooklyn Nets | 1.16 |	0.04 |	0.013 |	3.87 |	0.53 |
   | Charlotte Hornets	| -1.39 |	-0.08 |	-0.016 |	-0.54 | 0.99 |
   | Chicago Bulls	| 0.55 |	-1.71 |	0.014 |	0.06 |	0.74 |

*A table showing us season averages minus back-to-back second-day averages.*

4. **deviation__summary**: A table highlighting the largest deviations in performance across teams, focusing on both positive and negative performance changes.

![b2b_deviation_magnitude_plot_fixed](https://github.com/user-attachments/assets/32345c47-ece1-4d82-bc44-62fa149f6ee9)

5. **percentage_summary**: A pie chart focusing on the top 7 categories based on percentage change.
 
![percentage_chart](https://github.com/user-attachments/assets/b6761b5e-4c25-4455-96df-d534b5fd3786)

6. **best__preforming_teams**: A table showing the top 5 teams in the NBA with the best overall records on the second day of a back-to-back contest.

   <img width="419" alt="image" src="https://github.com/user-attachments/assets/49c99120-a087-4d40-beaf-9657541a0e9e" />


# Data Analysis

- **Statistical Analysis**: The performance data for each team was compared to their season averages, with a focus on stats that are considered **positive when higher** (e.g., points scored, field goal percentage) and **negative when higher** (e.g., turnovers, personal fouls).
- **Deviation Calculation**: The difference between a team’s performance on the second day of back-to-back games and their season average was computed to determine how each team’s performance changes under fatigue/scheduling.
- **Key Findings**: The analysis identified which stats are most affected by fatigue and how different teams generally respond to the demands of back-to-back scheduling.

# How to Use

### 1. **Set up the database:**
The SQL scripts provided create the necessary tables to analyze the data. Run the scripts in your pgAdmin4 database to generate the required tables.

### 2. **Data Source:**
The data for this analysis comes from the official NBA stats and game logs, which are organized into team performance metrics such as points, turnovers, rebounds, etc.

### 3. **Running Queries:**
The queries used in the analysis can be found in the in the folder. These queries will allow you to:
- Compile the season averages of specific game stats across the NBA.
- Compare season averages to performance on the second day of back-to-back games.
- Calculate the deviation for each statistic and find which teams show the most noticeable differences in performance.

# Insights & Analysis

### Key Findings
**Impact of Fatigue**: As expected, teams tend to show a decline in many performance metrics, such as points scored and rebounds, on the second day of back-to-back games. Points scored had the largest deviation from the season average (-0.98), more than twice the deviation of the next closest category.

**Improved Performance in Some Areas**: Interestingly, some teams demonstrated **improved performance** in categories like **turnovers** and **personal fouls**. This may be attributed to strategic game planning or more efficient player rotations during the back-to-back scheduling.

**Neutral Performance in Offensive Efficiency**: One of the more surprising findings was that offensive efficiency metrics, such as **field goal percentage (FG%)** (-0.005) and **three-point percentage** (3PT%) (0.00), were largely unaffected when it came to deviations. While overall points decreased, teams maintained relatively consistent performance in these efficiency metrics.

**Negative Performance in Defensive Categories**: Defensive statistics showed a clear decline, with **defensive rebounds** (-0.29), **blocks** (-0.13), and **steals** (-0.07) all decreasing. Blocks, in particular, were most affected, dropping by -2.53% compared to regular season averages.

**Winning Teams --> Winning Seasons**: Team's that performed well in back-to-back games, had sucess throughout the whole season. The only team in the top 5 for wins to not make the 2023-2024 playoffs was the Golden State Warriors. The Boston Celtics, which finished at the top in both **wins (12) and win percentage (85.7%)** would end up winning the NBA finals later that year.

# Next Steps / Future Work

- **Extended Analysis to Hobart Basketball**: Perform an analysis over multiple seasons to understand how trends might change for college program.
- **Player-Level Insights**: Dive deeper into individual player performance on the second day of back-to-back games to identify outliers.
