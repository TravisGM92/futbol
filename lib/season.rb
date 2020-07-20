require './lib/stat_tracker'

class Season

  attr_reader :stat_tracker
  def initialize
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test(id)
    @stat_tracker.best_season(id)
    @stat_tracker.all_seasons_results
    if @stat_tracker.all_seasons_results[0] == @stat_tracker.all_seasons_results.sort[-1]
      "20122013"
    elsif @stat_tracker.all_seasons_results[1] == @stat_tracker.all_seasons_results.sort[-1]
      "20132014"
    elsif @stat_tracker.all_seasons_results[2] == @stat_tracker.all_seasons_results.sort[-1]
      "20142015"
    elsif @stat_tracker.all_seasons_results[3] == @stat_tracker.all_seasons_results.sort[-1]
      "20152016"
    elsif @stat_tracker.all_seasons_results[4] == @stat_tracker.all_seasons_results.sort[-1]
      "20162017"
    elsif @stat_tracker.all_seasons_results[5] == @stat_tracker.all_seasons_results.sort[-1]
      "20172018"
    end
  end
end

# season = Season.new
# p season.test(3)
