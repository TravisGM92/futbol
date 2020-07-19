require 'CSV'

class StatTracker
  attr_reader :data

  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(data)
    @data = data
    @game_teams_file = CSV.parse(File.read(@data[:game_teams]), headers: true, converters: :numeric).by_row
    @teams_file = CSV.parse(File.read(@data[:teams]), headers: true).by_row
    @games_file = CSV.parse(File.read(@data[:games]), headers: true, header_converters: :symbol, converters: :numeric).by_row
  end

  def goals_by_game_id
    result = Hash.new{|hash,key| hash[key] = []}
    @game_teams_file.each do |game|
      result[game[0]] << game[6]
    end
    result
  end

  def game_total_score
    goals_by_game_id.transform_values! {|score| score.sum}
  end

##### Need to return team name
  def highest_total_score
    game_total_score.values.max
  end

  ##### Need to return team name
  def lowest_total_score
    game_total_score.values.min
  end

  def find_team_id(team)
    results = @teams_file.find {|row| row[2] == team}
    results[0]
  end



  def count_home_games(team)
    home_games = []
    team_id = find_team_id(team).to_i
    @game_teams_file.each do |game|
      if team_id == game[1].to_i && game[2].to_s == 'home'
        home_games << game
      end
    end
    count_home_wins(home_games)
  end

  def count_home_wins(home_games)
    home_wins = []
    home_games.each do |game|
      home_wins << game if game[3].to_s == 'WIN'
    end
    home_wins
    ((home_wins.count.to_f/home_games.count.to_f)*100).round(2)
  end

  def percentage_home_wins(team)
    count_home_games(team)
  end

end

# game_path = './data/games_sample.csv'
# team_path = './data/teams_sample.csv'
# game_teams_path = './data/game_teams_sample.csv'
#
# locations = {
#             games: game_path,
#             teams: team_path,
#             game_teams: game_teams_path
#             }
