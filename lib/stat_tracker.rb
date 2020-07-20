require 'CSV'

class StatTracker

  attr_reader :data, :seasons,
              :game_team_rows,
              :game_rows, :body,
              :all_seasons_results2,
              :all_seasons_results1,
              :games_won, :games_lost,
              :max_goals, :games_won_games,
              :body1, :all_games

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
    @body = File.read(@data[:teams])
    @body1 = CSV.parse(File.read(@data[:teams]), headers: false)

    @all_seasons_results2 = all_seasons_results2
    @all_seasons_results1 = all_seasons_results1
    @games_won = games_won
    @games_lost = games_lost
    @max_goals = max_goals
    @games_won_games = games_won_games
    @all_games = all_games
  end

  def team_info(id)
    hash = {}
    CSV.new(@body, :headers => true).to_a.map{ |row| row.to_hash}.find{ |hash| hash["team_id"] == "#{id}"}
  end

  def games_played(id)
    @game_team_rows.select{ |row| row[1] == "#{id}"}
  end

  def best_season(id)
    @games_won = self.games_played(id).select{ |row| row[3] == "WIN"}.map{ |row| row[0]}
    @games_won_games = @games_won.map{ |games| @game_rows.select{ |row| row[0] == games}}.map{ |game| game.flatten}
    @all_seasons_results1 = [@games_won_games.select{ |row| row[1] == "20122013"}.length,
    @games_won_games.select{ |row| row[1] == "20132014"}.length,
    @games_won_games.select{ |row| row[1] == "20142015"}.length,
    @games_won_games.select{ |row| row[1] == "20152016"}.length,
     @games_won_games.select{ |row| row[1] == "20162017"}.length,
     @games_won_games.select{ |row| row[1] == "20172018"}.length]
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

    def worst_season(id)
      @games_lost = self.games_played(id).select{ |row| row[3] == "LOSS" || row[3] == "TIE"}.map{ |row| row[0]}
      games_lost_games = @games_lost.map{ |games| @game_rows.select{ |row| row[0] == games}}.map{ |game| game.flatten}
      @all_seasons_results2 = [games_lost_games.select{ |row| row[1] == "20122013"}.length,
      games_lost_games.select{ |row| row[1] == "20132014"}.length,
      games_lost_games.select{ |row| row[1] == "20142015"}.length,
      games_lost_games.select{ |row| row[1] == "20152016"}.length,
      games_lost_games.select{ |row| row[1] == "20162017"}.length,
      games_lost_games.select{ |row| row[1] == "20172018"}.length]
      self.best_season(id)
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

    def average_win_percentage(id)
      self.worst_season(id)
      (@all_seasons_results1.zip(@all_seasons_results2).map do
         |w,l| w.to_f/(w.to_f+l.to_f)end.sum/(@all_seasons_results1.zip(@all_seasons_results2).map do
            |w,l| w.to_f/(w.to_f+l.to_f)end.length)).round(2)
    end

    def most_goals_scored(id)
      goals = []
      games = @game_rows.select{ |col| col[4] == "#{id}" || col[5] == "#{id}"}
      @max_goals = games.map do |row|
        if row[4] == "#{id}"
          goals << row[6]
        elsif row[5] == "#{id}"
          goals << row[7]
          end
        end.flatten.sort
        max_goals.max.to_i
    end

    def fewest_goals_scored(id)
      self.most_goals_scored(id)
      @max_goals[1].to_i
    end

    def favorite_opponent(id)
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
      freq = all_games.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
      team_id = all_games.min_by { |v| freq[v] }
      @body1.select{ |rows| rows[0] == team_id}.flatten[2]
    end

    def rival(id)
    end
  end
