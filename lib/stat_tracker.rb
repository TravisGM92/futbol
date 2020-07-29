require 'CSV'
require_relative '../lib/game_manager'
require_relative '../lib/team_manager'
require_relative '../lib/game_teams_manager'
require_relative '../lib/modable'

class StatTracker
  include Modable

  attr_reader :game_manager, :game_teams_manager, :team_manager

  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(locations)
    game_path = locations[:games]
    team_path = locations[:teams]
    game_teams_path = locations[:game_teams]
    @game_teams_manager = GameTeamsManager.new(game_teams_path)
    @game_manager = GameManager.new(game_path)
    @team_manager = TeamManager.new(team_path)
  end

  def highest_total_score #game_manager -> highest_total_score method
    @game_manager.highest_total_score
  end

  def lowest_total_score   #game_manager -> lowest_total_score method
    @game_manager.lowest_total_score
  end

  def percentage_home_wins
    home_games = @game_teams_manager.count_home_games
    home_wins = @game_teams_manager.home_game_results(home_games)
    @game_teams_manager.percentage_home_wins(home_games, home_wins[:wins])
  end

  def percentage_visitor_wins
    home_games = @game_teams_manager.count_home_games
    home_losses = @game_teams_manager.home_game_results(home_games)
    @game_teams_manager.percentage_visitor_wins(home_games, home_losses[:losses])
  end

  def count_of_games_by_season
    games_by_season = @game_manager.create_games_by_season_array
    @game_manager.count_of_games_by_season(games_by_season)
  end

  def percentage_ties
    home_games = @game_teams_manager.count_home_games
    tie_games = @game_teams_manager.home_game_results(home_games)
    @game_teams_manager.percentage_ties(home_games, tie_games[:ties])
  end

  def average_goals_per_game
    total_goals = @game_manager.collect_all_goals
    @game_manager.average_goals_per_game(total_goals)
  end

  def average_goals_by_season
    season_goals = @game_manager.collect_goals_by_season
    @game_manager.average_goals_by_season(season_goals)
  end

  def team_info(id) #team_manager -> team_info(id)
    @team_manager.team_info(id)
  end

  def best_season(id) #game_manager -> best_season(id)
    @game_manager.best_season(id)
  end

  def worst_season(id) #game_manager -> worst_season(id)
    @game_manager.worst_season(id)
  end

  def average_win_percentage(id) #game_manager -> average_win_percentage(id)
    @game_manager.average_win_percentage(id)
  end

  def most_goals_scored(id) #game_manager -> most_goals_scored(id)
    @game_manager.most_goals_scored(id)
  end

  def fewest_goals_scored(id) #game_manager -> fewest_goals_scored(id)
    @game_manager.fewest_goals_scored(id)
  end

  def favorite_opponent(id)
    number = @game_manager.favorite_opponent(id)
    @team_manager.teams_array.select do |team| team.team_id == number
    end[0].team_name
  end

  def rival(id)
    number = @game_manager.rival(id)
    @team_manager.teams_array.select do |team| team.team_id == number
    end[0].team_name
  end

  def count_of_teams #team_manager -> count_of_teams
    @team_manager.size
  end

  def best_offense
   team_number = @game_teams_manager.teams_max_by_average_goal
   @team_manager.find_by_id(team_number).team_name
  end

  def worst_offense
    team_number = @game_teams_manager.teams_min_by_average_goal
    @team_manager.find_by_id(team_number).team_name
  end

  def highest_visitor_team
    team = @game_teams_manager.highest_visitor_team.first
    @team_manager.find_by_id(team).team_name
  end

  def lowest_visitor_team
    team = @game_teams_manager.lowest_visitor_team.first
    @team_manager.find_by_id(team).team_name
  end

  def lowest_home_team
    @game_teams_array.lowest_home_team
  end
  #season stats start here (Drew's)
  def winningest_coach(season)
    @all_games = @game_manager.games_by_season(season)
    self.winningest_coach1(season)
    @result.max_by(&:last).first
  end

  def worst_coach(season)
    @all_games1 = @game_manager.games_by_season(season)
    self.worst_coach1(season)
    @result.sort_by do |key, value| value
    end[-1].first
  end

  def most_accurate_team(season)
    @all_games2 = @game_manager.games_by_season(season)
    self.most_accurate_team1(season)
    @numb2 = @all_goals.sort_by do |key, value| value
    end[-1].first
    self.most_accurate_team2(season)
  end

  def highest_home_team
    team = @game_teams_manager.highest_home_team.first
    @team_manager.find_by_id(team).team_name
  end

  def lowest_home_team #game_teams_manager -> lowest_home_team
    team = @game_teams_manager.lowest_home_team.first
    @team_manager.find_by_id(team).team_name
  end


  def least_accurate_team(season)
    @all_games2 = @game_manager.games_by_season(season)
    self.most_accurate_team1(season)
    @numb2 = @all_goals.sort_by do |key, value| value
    end[0].first
    self.most_accurate_team2(season)
  end

  def most_tackles(season)
    @all_games = @game_manager.games_by_season(season)
    self.most_tackles1(season)
    @numb2 = @all_tackles.sort_by do |key, value| value
    end[-1].first
    self.most_accurate_team2(season)
  end

  def least_accurate_team(season)
    all_games = @game_manager.games_by_season(season)
    team = @game_teams_manager.most_accurate_team(all_games)[0].first
    @team_manager.find_by_id(team).team_name
  end

  def most_tackles(season)
    all_games = @game_manager.games_by_season(season)
    team = @game_teams_manager.most_tackles(all_games)[-1].first
    @team_manager.find_by_id(team).team_name
  end

  def fewest_tackles(season) #game_manager -> fewest_tackles
    all_games = @game_manager.games_by_season(season)
    team = @game_teams_manager.most_tackles(all_games)[0].first
    @team_manager.find_by_id(team).team_name
  end
end
