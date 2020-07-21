# require './lib/stat_tracker'
require './lib/readfiles'

class Season < ReadFiles

  attr_reader :stat_tracker, :all_seasons_results1,
              :all_seasons_results2

  def array_of_lost_games_by_team(id)
    @games_lost = self.games_played(id).select{ |row| row[3] == "LOSS" || row[3] == "TIE"}.map{ |row| row[0]}
    games_lost_games = @games_lost.map{ |games| @game_rows.select{ |row| row[0] == games}}.map{ |game| game.flatten}
    @all_seasons_results2 = [games_lost_games.select{ |row| row[1] == "20122013"}.length,
    games_lost_games.select{ |row| row[1] == "20132014"}.length,
    games_lost_games.select{ |row| row[1] == "20142015"}.length,
    games_lost_games.select{ |row| row[1] == "20152016"}.length,
    games_lost_games.select{ |row| row[1] == "20162017"}.length,
    games_lost_games.select{ |row| row[1] == "20172018"}.length]
  end

  def array_of_games_won_by_team(id)
    @games_won = self.games_played(id).select{ |row| row[3] == "WIN"}.map{ |row| row[0]}
    @games_won_games = @games_won.map{ |games| @game_rows.select{ |row| row[0] == games}}.map{ |game| game.flatten}
    @all_seasons_results1 = [@games_won_games.select{ |row| row[1] == "20122013"}.length,
    @games_won_games.select{ |row| row[1] == "20132014"}.length,
    @games_won_games.select{ |row| row[1] == "20142015"}.length,
    @games_won_games.select{ |row| row[1] == "20152016"}.length,
     @games_won_games.select{ |row| row[1] == "20162017"}.length,
     @games_won_games.select{ |row| row[1] == "20172018"}.length]
  end

  def best_season_displayed(id)
    self.array_of_games_won_by_team(id)
    if all_seasons_results1[0] == all_seasons_results1.sort[-1]
      "20122013"
    elsif all_seasons_results1[1] == all_seasons_results1.sort[-1]
      "20132014"
    elsif all_seasons_results1[2] == all_seasons_results1.sort[-1]
      "20142015"
    elsif all_seasons_results1[3] == all_seasons_results1.sort[-1]
      "20152016"
    elsif all_seasons_results1[4] == all_seasons_results1.sort[-1]
      "20162017"
    elsif all_seasons_results1[5] == all_seasons_results1.sort[-1]
      "20172018"
    end

  end

  def worst_season_displayed(id)
    self.array_of_lost_games_by_team(id)
    if all_seasons_results2[0] == all_seasons_results2.sort[-1]
      "20122013"
    elsif all_seasons_results2[1] == all_seasons_results2.sort[-1]
      "20132014"
    elsif all_seasons_results2[2] == all_seasons_results2.sort[-1]
      "20142015"
    elsif all_seasons_results2[3] == all_seasons_results2.sort[-1]
      "20152016"
    elsif all_seasons_results2[4] == all_seasons_results2.sort[-1]
      "20162017"
    elsif all_seasons_results2[5] == all_seasons_results2.sort[-1]
      "20172018"
    end
  end

  def array_of_opp_who_lose_most_to_team(id)
    @all_games = @game_rows.map do |rows|
      index = rows.find_index("#{id}")
      if index == 4
        if rows[7] > rows[6]
          rows[5]
        end
      elsif index == 5
        if rows[6] == rows[7]
          rows[4]
        end
      end
    end.compact
  end

  def array_of_opp_who_win_most_to_team(id)
    @all_games = @game_rows.map do |rows|
      index = rows.find_index("#{id}")
      if index == 4
        if rows[6] > rows[7]
          rows[5]
        end
      elsif index == 5
        if rows[6] < rows[7]
          rows[4]
        end
      end
    end.compact.sort
  end
end

# season = Season.new
# p season.test(3)
