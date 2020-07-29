# Futbol

Starter repository for the [Turing School](https://turing.io/) Futbol project.

## Refactoring

For our team, we initially built our methods within the StatTracker class by dividing between each group of methods, game, team, league, season. We would create Pull Requests which were reviewed via screenshare with the team. Once we were along in the process we noticed that we were creating some similar helper methods as well as needing to call methods on different objects of games, game_teams, or teams to obtain the data we needed. We decided it best to split our methods into classes associated with those objects. For this reason we created...

### 3 Classes - responsible for initializing each row of the CSV data as objects to be manipulated
- Games
- GameTeams
- Teams

### 3 Managers - responsible for manipulating the object data
- GamesManager
- GameTeamsManager
- TeamManager

### 1 StatTracker Class - Responsible for calling the managers who would deliver the data to StatTracker

### 1 Module - Modable - used to shorten manager classes to below 150 lines

After creating these various files and finishing our methods, we looked through for opportunity to create more helper methods to reduce nesting and to improve our test speed by not iterating through the CSV repeatedly. After refactoring these issues, we were able to get our spec harness to run under 5 seconds, therefore we decided not to implement any mocks or stubs.
