require_relative '../lib/game'
require_relative '../lib/game_manager_helper'

class GameManager
  include GameManagerHelper

  attr_reader :games_array
  def initialize(game_path)
    @games_array = []
    CSV.foreach(game_path, headers: true){ |row|
      @games_array << Game.new(row)}
  end

  def highest_total_score
    @all_goals_max = []
    @games_array.each{ |game|
      total_goals = game.away_goals.to_i + game.home_goals.to_i
      @all_goals_max << total_goals
    }
    @all_goals_max.max
  end

  def lowest_total_score
    @all_goals_min = []
    @games_array.each{ |game|
      total_goals = game.away_goals.to_i + game.home_goals.to_i
      @all_goals_min << total_goals
    }
    @all_goals_min.min
  end

  def create_games_by_season_array
    games_by_season = {}
    @games_array.each{ |game|
      games_by_season[game.season] = []}
    @games_array.each{ |game|
      games_by_season[game.season]<< game.game_id}
    games_by_season
  end

  def count_of_games_by_season(games_by_season)
    games_by_season.each{ |k, v| games_by_season[k] = v.count}
  end

  def collect_all_goals
    total_goals = []
    @games_array.each{ |game|
      total_goals << game.away_goals.to_i
      total_goals << game.home_goals.to_i
    }
    total_goals
  end

    def average_goals_per_game(total_goals)
    (total_goals.sum.to_f/(total_goals.size/2)).round(2)
  end

  def collect_goals_by_season
    season_goals = Hash.new { |hash, key| hash[key] = [] }
    @games_array.each{ |game|
      season_goals[game.season] = []
      season_goals[game.season] = []
    }
    @games_array.each{ |game|
      season_goals[game.season] << game.home_goals.to_i
      season_goals[game.season] << game.away_goals.to_i
    }
    season_goals
  end

  def average_goals_by_season(season_goals)
    season_goals.keys.each{ |season|
      season_goals[season] = (season_goals[season].sum.to_f/(season_goals[season].size)*2).round(2)}
    season_goals
  end

  def best_season(id)
    @all_games = @games_array.select{ |row|
      row.away_team_id == "#{id}" || row.home_team_id == "#{id}"}
    @away_wins = @all_games.select{ |row|
      row.away_team_id == "#{id}" && row.away_goals > row.home_goals}
    @home_wins = @all_games.select{ |row|
      row.home_team_id == "#{id}" && row.away_goals < row.home_goals}
    @seasons = (@away_wins + @home_wins).map{ |x| x.season}
    freq = @seasons.inject(Hash.new(0)){ |h,v| h[v] += 1; h}
    @seasons.max_by{ |v| freq[v] }
  end

  def worst_season(id)
    self.best_season(id)
    freq = @seasons.inject(Hash.new(0)){ |h,v| h[v] += 1; h}
    @seasons.min_by{ |v| freq[v]}
  end

  def average_win_percentage(id)
    @all_games = @games_array.select{ |row|
      row.away_team_id == "#{id}" || row.home_team_id == "#{id}"}
    @away_wins = @all_games.select{ |row|
      row.away_team_id == "#{id}" && row.away_goals > row.home_goals}
    @home_wins = @all_games.select{ |row|
      row.home_team_id == "#{id}" && row.away_goals < row.home_goals}
    @all_wins = (@away_wins + @home_wins)
    (@all_wins.length.to_f/@all_games.length.to_f).round(2)
  end

  def most_goals_scored(id)
    self.average_win_percentage(id)
    @away = @away_wins.map{ |game| game.away_goals}
    @home = @home_wins.map{ |game| game.home_goals}
    (@away + @home).sort[-1].to_i
  end

  def fewest_goals_scored(id)
    self.average_win_percentage(id)
    @all_games = @games_array.select{ |row|
      row.away_team_id == "#{id}" || row.home_team_id == "#{id}"}
    goals = []
    @all_games.each{ |game|
      if game.home_team_id == "#{id}"
        goals << game.home_goals
      elsif game.away_team_id == "#{id}"
        goals << game.away_goals
      end
    }
    goals.min.to_i
  end

 def games_by_season(season)
   @games_array.select{ |game| game.season == season}.map{ |game| game.game_id}
 end
end
