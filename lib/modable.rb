module Modable

  def fav_opp(id)
    freq = @teams1.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    numbs = @teams1.min_by { |v| freq[v] }
    @teams_array.select{ |team| team.team_id == numbs}[0].team_name
  end

  def fav_opp2(id)
    @teams1 = []
    @array1 = @all_games.select do |rows|
      if rows.home_team_id == "#{id}"
        if rows.away_goals > rows.home_goals
          @teams1 << rows.away_team_id
        end
      elsif rows.away_team_id == "#{id}"
        if rows.away_goals == rows.home_goals
          @teams1 << rows.home_team_id
        end
      end
    end
    self.fav_opp(id)
  end

  def rival1(id)
    @teams2 = []
    self.best_season(id)
    @all_games.each do |game|
      if game.away_team_id == "#{id}"
        @teams2 << game.home_team_id
      elsif game.home_team_id == "#{id}"
        @teams2 << game.away_team_id
      end
    end
  end

  def rival2(id)
    @teams1 = []
    @all_games.each do |game|
      if game.away_team_id == "#{id}"
        if game.away_goals < game.home_goals
          @teams1 << game.home_team_id
        end
      elsif game.home_team_id == "#{id}"
        if game.away_goals > game.home_goals
          @teams1 << game.away_team_id
        end
      end
    end
  end


  def goals(id)
    @away = @all_games.map{ |rows| rows.away_goals}
    @home = @all_games.map{ |rows| rows.home_goals}
  end

  def season_games(id)
    @all_games = @games_array.select do |row| row.away_team_id == "#{id}" || row.home_team_id == "#{id}"
    end
    @away_wins = @all_games.select do |row| row.away_team_id == "#{id}" && row.away_goals > row.home_goals
    end
    @home_wins = @all_games.select do |row| row.home_team_id == "#{id}" && row.away_goals < row.home_goals
    end
    @seasons = (@away_wins + @home_wins).map{ |x| x.season}
  end

end
