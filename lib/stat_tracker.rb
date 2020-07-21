require 'CSV'
require './lib/season'

class StatTracker < Season

  attr_reader :data, :seasons, :game_team_rows,
              :game_rows, :body, :all_seasons_results2,
              :all_seasons_results1, :games_won, :games_lost,
              :max_goals, :games_won_games, :body1, :all_games

  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(data)
    self.read(data)
  end

  def team_info(id)
    hash = {}
    CSV.new(@body, :headers => true).to_a.map{ |row| row.to_hash}.find{ |hash| hash["team_id"] == "#{id}"}
  end

  def games_played(id)
    @game_team_rows.select{ |row| row[1] == "#{id}"}
  end

  def best_season(id)
    self.array_of_games_won_by_team(id)
    self.best_season_displayed(id)
  end

  def worst_season(id)
    self.array_of_lost_games_by_team(id)
    self.worst_season_displayed(id)
  end

  def average_win_percentage(id)
    self.best_season(id)
    self.worst_season(id)
    (all_seasons_results1.zip(all_seasons_results2).map do |w,l|
      w.to_f/(w.to_f+l.to_f)end.sum/(all_seasons_results1.zip(all_seasons_results2).map do
          |w,l| w.to_f/(w.to_f+l.to_f)end.length)).round(2)
  end

  def most_goals_scored(id)
    games = @game_rows.select{ |col| col[4] == "#{id}" || col[5] == "#{id}"}
    @max_goals = games.map do |row|
      if row[4] == "#{id}"
        row[6]
      elsif row[5] == "#{id}"
        row[7]
        end
      end.sort
      max_goals.max.to_i
  end

  def fewest_goals_scored(id)
    self.most_goals_scored(id)
    @max_goals[1].to_i
  end

  def favorite_opponent(id)
    self.array_of_opp_who_lose_most_to_team(id)
    freq = all_games.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    team_id = all_games.min_by { |v| freq[v] }
    @body1.select{ |rows| rows[0] == team_id}.flatten[2]
  end

  def rival(id)
    self.array_of_opp_who_win_most_to_team(id)
    freq = all_games.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    team_id = all_games.min_by { |v| freq[v] }
    @body1.select{ |rows| rows[0] == team_id}.flatten[2]
  end
end



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
# p stat_tracker.most_goals_scored(2)
