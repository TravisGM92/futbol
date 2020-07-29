require_relative '../lib/game_teams'

class GameTeamsManager

  attr_reader :game_teams_array

  def initialize(game_teams_path)
    @game_teams_array = []

    CSV.foreach(game_teams_path, headers: true) do |row|
      @game_teams_array << GameTeam.new(row)
    end
  end

  def assign_goals_by_team
    team_goals = Hash.new { |hash, key| hash[key] = [] }
    @game_teams_array.each do |gameteam|
      team_goals[gameteam.team_id] = []
    end
    @game_teams_array.each do |gameteam|
      team_goals[gameteam.team_id] << gameteam.goals.to_i
    end
    team_goals
  end
  
  def average_goals_by_team
    team_goals = assign_goals_by_team
    team_goals.keys.each{|team|
      team_goals[team] = (team_goals[team].sum.to_f/(team_goals[team].size)).round(2)}
      team_goals
  end

  def teams_max_by_average_goal
    average_goals_by_team.max_by {|k,v| v}.first
  end

  def teams_min_by_average_goal
    average_goals_by_team.min_by{|k,v| v}.first
  end

  def home_game_results
    home_wins = []
    home_losses = []
    tie_games = []
    results = {}
    find_all_home_games.each do |game|
      home_wins << game.game_id if game.result.to_s == 'WIN'
      home_losses << game.game_id if game.result.to_s == 'LOSS'
      tie_games << game.game_id if game.result.to_s == 'TIE'

    end
    results[:wins] = home_wins
    results[:losses] = home_losses
    results[:ties] = tie_games
    results
  end

  def find_all_away_games
    @game_teams_array.find_all do |gameteam|
      gameteam.hoa == "away"
    end
  end

  def away_games_by_team_id
    find_all_away_games.group_by do |game|
      game.team_id
    end
  end

  def highest_visitor_team
    away_games_by_team_id.max_by do |team_id, gameteam|
      gameteam.sum{|game1| game1.goals.to_i} / gameteam.count.to_f
    end
  end

  def lowest_visitor_team
    away_games_by_team_id.min_by do |team_id, gameteam|
      gameteam.sum{|game1| game1.goals.to_i} / gameteam.count.to_f
    end
  end

  def find_all_home_games
    @game_teams_array.find_all do |gameteam|
      gameteam.hoa == "home"
    end
  end

  def home_games_by_team_id
    find_all_home_games.group_by do |game|
      game.team_id
    end
  end

  def highest_home_team
    home_games_by_team_id.max_by do |team_id, gameteam|
      gameteam.sum{|game1| game1.goals.to_i} / gameteam.count.to_f
    end
  end

  def lowest_home_team
    home_games_by_team_id.min_by do |team_id, gameteam|
      gameteam.sum{|game1| game1.goals.to_i} / gameteam.count.to_f
    end
  end

  def percentage_home_wins
    (home_game_results[:wins].count.to_f/find_all_home_games.count.to_f).round(2)
  end

  def percentage_visitor_wins
    (home_game_results[:losses].count.to_f/find_all_home_games.count.to_f).round(2)
  end

  def percentage_ties
    (home_game_results[:ties].count.to_f/find_all_home_games.count.to_f).round(2)
  end
end
