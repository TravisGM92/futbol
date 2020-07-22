require 'CSV'
require './lib/game_manager'
require './lib/team_manager'
require './lib/game_teams_manager'

class StatTracker < GameManager

  attr_reader :games, :game_details, :teams

  game_path = './data/games.csv'
  team_path = './data/teams.csv'
  game_teams_path = './data/game_teams.csv'

  locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
  }

  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(locations)
    @game_teams_array = []
    CSV.foreach(locations[:game_teams], headers: true) do |row|
      @game_teams_array << GameTeam.new(row)
    end

    @games_array = []
    CSV.foreach(locations[:games], headers: true) do |row|
      @games_array << Game.new(row)
    end

    @teams_array = []
    CSV.foreach(locations[:teams], headers: true) do |row|
      @teams_array << Team.new(row)
    end
  end

  def highest_total_score
    @all_goals_max = []
    @games_array.each do |game|
      total_goals = game.away_goals.to_i + game.home_goals.to_i
      @all_goals_max << total_goals
    end
    @all_goals_max.max
  end

  #
  def lowest_total_score
    @all_goals_min = []
    @games_array.each do |game|
      total_goals = game.away_goals.to_i + game.home_goals.to_i
      @all_goals_min << total_goals
    end
    @all_goals_min.min
  end
  #
  #   def find_team_id(team)
  #     results = @teams_file.find {|row| row[2] == team}
  #     results[0]
  #   end
  #
  #
  # #### Need to figure out how to un-chain methods
  def count_home_games
    home_games = []
    @game_teams_array.each do |game|
      if game.hoa.to_s == 'home'
        home_games << game
      end
    end
    count_home_wins(home_games)
  end
  
  def count_home_wins(home_games)
    home_wins = []
    home_games.each do |game|
      home_wins << game if game.result.to_s == 'WIN'
    end
    home_wins
    (home_wins.count.to_f/home_games.count.to_f).round(2)
  end

  def percentage_home_wins
    count_home_games
  end
  #
  #   def count_home_games_for_visitor_wins(team)
  #     home_games = []
  #     team_id = find_team_id(team).to_i
  #     @game_teams_file.each do |game|
  #       if team_id == game[1].to_i && game[2].to_s == 'home'
  #         home_games << game
  #       end
  #     end
  #     count_visitor_wins(home_games)
  #   end
  #
  #   def count_visitor_wins(home_games)
  #     home_losses = []
  #     home_games.each do |game|
  #       home_wins << game if game[3].to_s == 'LOSS'
  #     end
  #     home_losses
  #     ((home_losses.count.to_f/home_games.count.to_f)*100).round(2)
  #   end
  #
  #   def percentage_visitor_wins(team)
  #     count_visitor_wins(team)
  #   end
  #



end
