require 'CSV'

class StatTracker

  attr_reader :data, :seasons, :game_team_rows, :game_rows, :body
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
  end

  def team_info(id)
    hash = {}
    CSV.new(@body, :headers => true).to_a.map{ |row| row.to_hash}.find{ |hash| hash["team_id"] == "#{id}"}
  end

  def best_season(id)
    games_played = @game_team_rows.select{ |row| row[1] == "#{id}"}
    games_won = games_played.select{ |row| row[3] == "WIN"}.map{ |row| row[0]}
    games_won_games = games_won.map{ |x| @game_rows.select{ |row| row[0] == x}}.map{ |x| x.flatten}
    all_seasons_results = [games_won_games.select{ |row| row[1] == "20122013"}.length,
    games_won_games.select{ |row| row[1] == "20132014"}.length,
    games_won_games.select{ |row| row[1] == "20142015"}.length,
    games_won_games.select{ |row| row[1] == "20152016"}.length,
     games_won_games.select{ |row| row[1] == "20162017"}.length,
     games_won_games.select{ |row| row[1] == "20172018"}.length]
      if all_seasons_results[0] == all_seasons_results.sort[-1]
        "20122013"
      elsif all_seasons_results[1] == all_seasons_results.sort[-1]
        "20132014"
      elsif all_seasons_results[2] == all_seasons_results.sort[-1]
        "20142015"
      elsif all_seasons_results[3] == all_seasons_results.sort[-1]
        "20152016"
      elsif all_seasons_results[4] == all_seasons_results.sort[-1]
        "20162017"
      elsif all_seasons_results[5] == all_seasons_results.sort[-1]
        "20172018"
      end
    end
  end
