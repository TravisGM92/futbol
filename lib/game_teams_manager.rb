require_relative '../lib/game_teams'

class GameTeamsManager

  attr_reader :game_teams_array

  def initialize(game_teams_path)
    @game_teams_array = []

    CSV.foreach(game_teams_path, headers: true) do |row|
      @game_teams_array << GameTeam.new(row)
    end
  end

  def team_average_goals(team_id)
    teams_by_id = @game_teams_array.find_all do |gameteam|
      gameteam.team_id == team_id
    end

    total_goals = teams_by_id.sum do |team|
      team.goals.to_i
    end
    (total_goals.to_f / teams_by_id.size).round(2)
  end

  def teams_sort_by_average_goal
    average = @game_teams_array.sort_by do |team|
      team_average_goals(team.team_id)
    end
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

  def worst_coach(all_games)
    array = []
    game_teams_array.each{ |game|
      if all_games.include?(game.game_id)
        array << game
      end
    }
    hash = array.group_by{ |game| game.head_coach}
    games_played = hash.each{ |k,v| hash[k] = v.length}
    array
    games_lost = array.select{ |game| game.result == "LOSS" || game.result == "TIE"}
    games_lost_hash = games_lost.group_by{ |game| game.head_coach}
    numb_games_lost = games_lost_hash.each{ |k,v| games_lost_hash[k] = v.length}
    numbers = []
    @result = {}
    numb_games_lost.each{ |k,v| games_played.each{ |k1,v1|
      if k == k1
        @result[k] = (v.to_f/v1.to_f).round(4)
      end
    }
  }
  @result.sort_by{ |key, value| value}[-1].first
end

  def most_accurate_team(all_games)
    array = []
    game_teams_array.each{ |game|
      if all_games.include?(game.game_id)
        array << game
      end
    }
    hash = array.group_by{ |game| game.team_id}
    hash1 = array.group_by{ |game| game.team_id}
    @all_goals = hash1.each{ |k,v| hash1[k] = v.map{ |game|
      game.goals.to_i
    }.sum
  }
  all_shots = hash.each{ |k,v| hash[k] = v.map{ |game|
    game.shots.to_i
  }.sum
}
    all_shots.each{ |k,v| @all_goals.each{ |k1,v1|
      if k == k1
      @all_goals[k] = (v1.to_f/v.to_f)
      end
    }
    @all_goals
  }
    @all_goals.sort_by{ |key, value| value}
  end

  def most_tackles(all_games)
    array = []
    game_teams_array.each{ |game|
      if all_games.include?(game.game_id)
        array << game
      end
    }
    hash = array.group_by{ |game| game.team_id}
    @all_tackles = hash.each{ |k,v| hash[k] = v.map{ |game|
        game.tackles.to_i
      }.sum
    }
    @all_tackles.sort_by{ |key, value| value}
  end
end
