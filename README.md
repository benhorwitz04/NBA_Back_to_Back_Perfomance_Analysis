# NBA Back-to-Back Game Performance Analysis

## Overview

This project analyzes how NBA teams perform on the second day of back-to-back games compared to their averages during 2023-2024 season. The analysis includes various key statistics such as points scored, turnovers, field goals made, rebounds, and more. By comparing these metrics, we aim to identify how fatigue affects team performance and determine if there are consistent patterns across teams.

## Background

This project was initially constructed as a way to dive deeper into the world of data analytics. For the past five years, I've worked as a basketball coach at Hobart College. One of the unique aspects of the Liberty League conference we compete in is the schedule for our conference games. We play 18 games each year, with 16 of those contests being scheduled as back-to-back competitions for leauge play. This is a rare scheduling decision in college basketball, as many other conferences decide to split up games by at least 1 or more days. 

I wanted to explore how the performance of the second game of a back-to-back contest compares to the rest of the season averages. The NBA presents a much larger scale of data to pull from and provides a glimpse into how team performance is affected by scheduling. I used data from the 2023-2024 season, as it is the most recently completed NBA regular season. I did not include playoff games, and focused on the typical 82 regular game season. 
*Pleaese note that not all teams have the same amount of back-to-back games scheduled duirng there season.

## Project Structure

- **data/**: Contains raw data files, including team statistics and game-by-game performance data. Create the database on pgAdmin4 (a popular, open-source, graphical management tool for PostgreSQL).
- **python/**: Python scripts for scraping data from nba.api.stats were executed on VS Code (an open-source, and highly customizable code editor developed by Microsoft)
- **sql/**: SQL scripts for creating and querying databases.
- **results/**: Final analysis, including summary tables and queries published here on GitHub.
- **README.md**: The readme file you are currently reading!

## Key Tables Created

1. **team_season_averages**: A table containing the season averages for each team in various statistics (points, rebounds, turnovers, etc.).
2. **team_back_to_back_avgs**: A table showing the average performance for each team on the second day of back-to-back contests.

   <img width="398" alt="image" src="https://github.com/user-attachments/assets/120c90f5-5865-43be-b63d-297dd597accb" />

3. **team_back_to_back_diffs**: A table showing us season averages minus back-to-back second-day averages.

   <img width="357" alt="image" src="https://github.com/user-attachments/assets/e61a3c8e-6027-459d-94ff-40268e618384" />

4. **deviation__summary**: A table highlighting the largest deviations in performance across teams, focusing on both positive and negative performance changes.

![b2b_deviation_magnitude_plot_fixed](https://github.com/user-attachments/assets/3bc9897d-2f44-49a7-8218-25c1bb6e201f)

5. **percentage_summary**: A pie chart focusing on the top 7 categories based on percentage change.

![percentage_chart](https://github.com/user-attachments/assets/ba15f820-1e08-4093-9fe3-56c22f00ef5d)

## Data Analysis

- **Statistical Analysis**: The performance data for each team was compared to their season averages, with a focus on stats that are considered **positive when higher** (e.g., points scored, field goal percentage) and **negative when higher** (e.g., turnovers, personal fouls).
- **Deviation Calculation**: The difference between a team’s performance on the second day of back-to-back games and their season average was computed to determine how each team’s performance changes under fatigue/scheduling.
- **Key Findings**: The analysis identified which stats are most affected by fatigue and how different teams generally respond to the demands of back-to-back scheduling.

## How to Use

### 1. **Set up the database:**
The SQL scripts provided create the necessary tables to analyze the data. Run the scripts in your pgAdmin4 database to generate the required tables.

### 2. **Data Source:**
The data for this analysis comes from the official NBA stats and game logs, which are organized into team performance metrics such as points, turnovers, rebounds, etc.

### 3. **Running Queries:**
The queries used in the analysis can be found in the in the folder. These queries will allow you to:
- Compile the season averages of specific game stats across the NBA.
- Compare season averages to performance on the second day of back-to-back games.
- Calculate the deviation for each statistic and find which teams show the most noticeable differences in performance.

## Insights & Analysis

### Key Findings
**Impact of Fatigue**: As expected, teams tend to show a decline in many performance metrics, such as points scored and rebounds, on the second day of back-to-back games. Points scored had the largest deviation from the season average (-0.98), more than twice the deviation of the next closest category.

**Improved Performance in Some Areas**: Interestingly, some teams demonstrated **improved performance** in categories like **turnovers** and **personal fouls**. This may be attributed to strategic game planning or more efficient player rotations during the back-to-back scheduling.

**Neutral Performance in Offensive Efficiency**: One of the more surprising findings was that offensive efficiency metrics, such as **field goal percentage (FG%)** (-0.005) and **three-point percentage** (3PT%) (0.00), were largely unaffected when it came to deviations. While overall points decreased, teams maintained relatively consistent performance in these efficiency metrics.

**Negative Performance in Defensive Categories**: Defensive statistics showed a clear decline, with **defensive rebounds** (-0.29), **blocks** (-0.13), and **steals** (-0.07) all decreasing. Blocks, in particular, were most affected, dropping by -2.53% compared to regular season averages.

## Next Steps / Future Work

- **Extended Analysis to Hobart Basketball**: Perform an analysis over multiple seasons to understand how trends might change for college program.
- **Player-Level Insights**: Dive deeper into individual player performance on the second day of back-to-back games to identify outliers.
- **Additional Analysis**: Look at wins and which teams are able to secure the best record from second day back-to-back contests.
