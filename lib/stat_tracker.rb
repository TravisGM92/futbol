require 'CSV'

class StatTracker
  attr_reader :data

  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(data)
    @data = data
  end

  def game_teams_file
    CSV.parse(File.read(@data[:game_teams]), headers: true, header_converters: :symbol, converters: :numeric).by_row
  end

  def teams_file
    CSV.parse(File.read(@data[:teams]), headers: true, header_converters: :symbol, conversters: :numeric).by_row
  end

  def games_file
    CSV.parse(File.read(@data[:games]), headers: true, header_converters: :symbol, conversters: :numeric).by_row
  end

  def goals_by_game_id
    result = Hash.new{|hash,key| hash[key] = []}
    game_teams_file.each do |game|
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

  def build_team_hash
    teams_file.reduce(Hash.new) do |collector, team|
      team.each do |id|
        collector[team_data[0]] << team_data[2]
      end
      collector
    end
  end

##### Have to break out by key in Self
  def percentage_home_wins(team)
    data_by_row = CSV.parse(File.read(self.data), headers: true).by_row
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
