# Question: How do we compile the necessary data for this project?

# We are using a python scraping code to get the CSV info from nba.api.stats. 
# This successfully wokred to get 29 of the 30 teams. Indiana Pacers were the
# only team that the code was unable to get.

import time
from nba_api.stats.endpoints import teamgamelog
from nba_api.stats.static import teams
import pandas as pd

# List of teams you want to retry fetching
retry_teams = ['Orlando Magic', 'Indiana Pacers']

# Create an empty list to store the data
all_teams_data = []

# Fetch data for all other teams except for Orlando Magic and Indiana Pacers (already fetched)
nba_teams = teams.get_teams()

# Loop through all teams and get their game logs
for team in nba_teams:
    team_name = team['full_name']
    
    # Skip the retry teams
    if team_name in retry_teams:
        continue

    team_id = team['id']
    print(f"Fetching data for {team_name}...")

    try:
        game_log = teamgamelog.TeamGameLog(
            team_id=team_id,
            season='2023-24',
            season_type_all_star='Regular Season',
            timeout=60  # Increased timeout
        )
        
        df = game_log.get_data_frames()[0]
        df['TEAM_NAME'] = team_name
        all_teams_data.append(df)
        
        # Introduce a small delay between requests
        time.sleep(1)

    except Exception as e:
        print(f"Error fetching data for {team_name}: {e}")

# Now try fetching data for the Orlando Magic and Indiana Pacers individually
for team_name in retry_teams:
    team_id = next((team['id'] for team in nba_teams if team['full_name'] == team_name), None)
    
    if team_id:
        print(f"Retrying data for {team_name}...")

        try:
            game_log = teamgamelog.TeamGameLog(
                team_id=team_id,
                season='2023-24',
                season_type_all_star='Regular Season',
                timeout=120  # Further increased timeout for retry
            )
            
            df = game_log.get_data_frames()[0]
            df['TEAM_NAME'] = team_name
            all_teams_data.append(df)
            
            # Introduce a small delay between requests
            time.sleep(1)
        except Exception as e:
            print(f"Error fetching data for {team_name}: {e}")
    else:
        print(f"Team {team_name} not found.")

# Combine all teams' data into one large DataFrame
all_teams_df = pd.concat(all_teams_data, ignore_index=True)

# Save the combined dataset to a CSV file
csv_filename = "nba_team_game_stats_2023_24.csv"
all_teams_df.to_csv(csv_filename, index=False)

print(f"\nSaved full game log for all teams to: {csv_filename}")
