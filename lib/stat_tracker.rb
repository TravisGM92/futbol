require 'CSV'

class StatTracker

  attr_reader :data, :seasons,
              :game_team_rows,
              :game_rows, :body,
              :all_seasons_results2,
              :all_seasons_results1,
              :games_won, :games_lost

  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(data)
    @data = data
    @game_team_rows = CSV.parse(File.read(@data[:game_teams]))
    @game_rows = CSV.parse(File.read(@data[:games]))
    @seasons = CSV.parse(File.read(@data[:games]), headers: true).map do |col|
      col[1]
    end.uniq.sort!
    @body = File.read(@data[:teams])
    @all_seasons_results2 = all_seasons_results2
    @all_seasons_results1 = all_seasons_results1
    @games_won = games_won
    @games_lost = games_lost
  end

  def team_info(id)
    hash = {}
    CSV.new(@body, :headers => true).to_a.map{ |row| row.to_hash}.find{ |hash| hash["team_id"] == "#{id}"}
  end

  def games_played(id)
    @game_team_rows.select{ |row| row[1] == "#{id}"}
  end

  def best_season(id)
    @games_won = self.games_played(id).select{ |row| row[3] == "WIN"}.map{ |row| row[0]}
    games_won_games = @games_won.map{ |games| @game_rows.select{ |row| row[0] == games}}.map{ |game| game.flatten}
    @all_seasons_results1 = [games_won_games.select{ |row| row[1] == "20122013"}.length,
    games_won_games.select{ |row| row[1] == "20132014"}.length,
    games_won_games.select{ |row| row[1] == "20142015"}.length,
    games_won_games.select{ |row| row[1] == "20152016"}.length,
     games_won_games.select{ |row| row[1] == "20162017"}.length,
     games_won_games.select{ |row| row[1] == "20172018"}.length]
      if all_seasons_results1[0] == all_seasons_results1.sort[-1]
        "20122013"
      elsif all_seasons_results1[1] == all_seasons_results1.sort[-1]
        "20132014"
      elsif all_seasons_results1[2] == all_seasons_results1.sort[-1]
        "20142015"
      elsif all_seasons_results1[3] == all_seasons_results1.sort[-1]
        "20152016"
      elsif all_seasons_results1[4] == all_seasons_results1.sort[-1]
        "20162017"
      elsif all_seasons_results1[5] == all_seasons_results1.sort[-1]
        "20172018"
      end
    end

    def worst_season(id)
      @games_lost = self.games_played(id).select{ |row| row[3] == "LOSS" || row[3] == "TIE"}.map{ |row| row[0]}
      games_lost_games = @games_lost.map{ |games| @game_rows.select{ |row| row[0] == games}}.map{ |game| game.flatten}
      @all_seasons_results2 = [games_lost_games.select{ |row| row[1] == "20122013"}.length,
      games_lost_games.select{ |row| row[1] == "20132014"}.length,
      games_lost_games.select{ |row| row[1] == "20142015"}.length,
      games_lost_games.select{ |row| row[1] == "20152016"}.length,
      games_lost_games.select{ |row| row[1] == "20162017"}.length,
      games_lost_games.select{ |row| row[1] == "20172018"}.length]
      self.best_season(id)
      if all_seasons_results2[0] == all_seasons_results2.sort[-1]
        "20122013"
      elsif all_seasons_results2[1] == all_seasons_results2.sort[-1]
        "20132014"
      elsif all_seasons_results2[2] == all_seasons_results2.sort[-1]
        "20142015"
      elsif all_seasons_results2[3] == all_seasons_results2.sort[-1]
        "20152016"
      elsif all_seasons_results2[4] == all_seasons_results2.sort[-1]
        "20162017"
      elsif all_seasons_results2[5] == all_seasons_results2.sort[-1]
        "20172018"
      end
    end

    def average_win_percentage(id)
      self.worst_season(id)
      (@all_seasons_results1.zip(@all_seasons_results2).map do
         |w,l| w.to_f/(w.to_f+l.to_f)end.sum/(@all_seasons_results1.zip(@all_seasons_results2).map do
            |w,l| w.to_f/(w.to_f+l.to_f)end.length)).round(2)
    end

end

# it "#average_win_percentage" do
#     expect(@stat_tracker.average_win_percentage("6")).to eq 0.49

# game_path = './data/games.csv'
# team_path = './data/teams.csv'
# game_teams_path = './data/game_teams.csv'
#
# locations = {
#   games: game_path,
#   teams: team_path,
#   game_teams: game_teams_path
# }
# stat_tracker = StatTracker.from_csv(locations)
# stat_tracker.average_win_percentage(6)
