require 'CSV'

class StatTracker

  attr_reader :data, :seasons, :game_team_rows, :game_rows, :team_rows, :team_cols, :body
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
    @headers = CSV.parse(File.read(@data[:teams]),
      headers: false)[0]
    @body = File.read(@data[:teams])
    @team_cols = CSV.parse(File.read(@data[:teams]), headers: false)
  end

  def team_info(id)
    hash = {}
    csv = CSV.new(@body, :headers => true, :header_converters => :symbol)
    teams_hash = csv.to_a.map{ |row| row.to_hash}
    teams_hash.find{ |hash| hash[:team_id] == "#{id}"}
  end

  def best_season(id)
    games_played = @game_team_rows.select{ |row| row[1] == "#{id}"}
    games_won = games_played.select{ |row| row[3] == "WIN"}
    games_won_ids = games_won.map{ |row| row[0]}
    games_won_games = games_won_ids.map{ |x| @game_rows.select{ |row| row[0] == x}}.map{ |x| x.flatten}
    season_20122013 = games_won_games.select{ |row| row[1] == "20122013"}.length
    season_20132014 = games_won_games.select{ |row| row[1] == "20132014"}.length
    season_20142015 = games_won_games.select{ |row| row[1] == "20142015"}.length
    season_20152016 = games_won_games.select{ |row| row[1] == "20152016"}.length
    season_20162017 = games_won_games.select{ |row| row[1] == "20162017"}.length
    season_20172018 = games_won_games.select{ |row| row[1] == "20172018"}.length
    all_seasons_results = [season_20122013, season_20132014, season_20142015, season_20152016, season_20162017, season_20172018]
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
