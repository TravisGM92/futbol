require "./test/test_helper.rb"
require './lib/stat_tracker'

class StatTrackerTest < MiniTest::Test


  def setup
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

    def test_highest_scores
      assert_equal 11, @stat_tracker.highest_total_score
    end

    def test_lowest_scores
      assert_equal 0, @stat_tracker.lowest_total_score
    end

    def test_percentage_home_wins
      assert_equal 0.44, @stat_tracker.percentage_home_wins
    end

    def test_percentage_visitor_wins
      assert_equal 0.36, @stat_tracker.percentage_visitor_wins
    end

    def test_percentage_ties
      assert_equal 0.20, @stat_tracker.percentage_ties
    end

    def test_count_of_games_by_season
      expected = {
        "20122013"=>806,
        "20162017"=>1317,
        "20142015"=>1319,
        "20152016"=>1321,
        "20132014"=>1323,
        "20172018"=>1355
      }
      assert_equal expected, @stat_tracker.count_of_games_by_season
    end

   def test_average_goals_per_game
     assert_equal 4.22, @stat_tracker.average_goals_per_game
   end

   def test_average_goals_by_season
     expected = {
       "20122013"=>4.12,
       "20162017"=>4.23,
       "20142015"=>4.14,
       "20152016"=>4.16,
       "20132014"=>4.19,
       "20172018"=>4.44
     }

     assert_equal expected, @stat_tracker.average_goals_by_season
   end

  def test_it_can_count_teams
    # skip
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_it_can_best_offense_team
    # skip
    assert_equal "Reign FC", @stat_tracker.best_offense
  end

  def test_it_can_worst_offense_team
    # skip
    assert_equal "Utah Royals FC", @stat_tracker.worst_offense
  end

  def test_it_can_get_highest_scoring_vistor_team
    # skip
    assert_equal "FC Dallas", @stat_tracker.highest_visitor_team
  end

  def test_it_can_get_lowest_scoring_visitor_team
    assert_equal "San Jose Earthquakes", @stat_tracker.lowest_visitor_team
  end

  def test_it_can_get_highest_scoring_home_team
    assert_equal "Reign FC", @stat_tracker.highest_home_team
  end

  def test_it_can_get_lowest_scoring_home_team
    assert_equal "Utah Royals FC", @stat_tracker.lowest_home_team
  end

  def test_it_can_get_lowest_scoring_visitor_team
    # skip
    assert_equal "San Jose Earthquakes", @stat_tracker.lowest_visitor_team
  end

  def test_highest_scores
    # skip
    assert_equal 11, @stat_tracker.highest_total_score
  end

  def test_lowest_scores
    # skip
    assert_equal 0, @stat_tracker.lowest_total_score
  end

  def test_percentage_home_wins
    # skip
    assert_equal 0.44, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    # skip
    assert_equal 0.36, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties
    # skip
    assert_equal 0.20, @stat_tracker.percentage_ties
  end

  def test_it_can_display_team_info
    expected = {
      "team_id"=>"18",
      "franchise_id"=>"34",
      "team_name"=>"Minnesota United FC",
      "abbreviation"=>"MIN",
      "link"=>"/api/v1/teams/18"
    }

    assert_equal expected, @stat_tracker.team_info(18)
  end

  def test_count_of_games_by_season
    # skip
    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_it_can_display_best_season
    assert_equal "20132014", @stat_tracker.best_season(6)
  end

  def test_it_can_display_worst_season
    assert_equal "20142015", @stat_tracker.worst_season(6)
  end

  def test_it_can_display_average_win_percentage
    # skip
    assert_equal 0.49, @stat_tracker.average_win_percentage(6)
  end

  def test_it_can_display_most_goals_scored
    assert_equal 7, @stat_tracker.most_goals_scored(18)
  end

  def test_it_can_display_fewest_goals_scored
    assert_equal 0, @stat_tracker.fewest_goals_scored(18)
  end

  def test_it_can_display_favorite_opponent
    assert_equal "DC United", @stat_tracker.favorite_opponent(18)
  end

  def test_it_can_display_rival
    assert_equal "LA Galaxy", @stat_tracker.rival(18)
  end

  def test_it_can_get_lowest_scoring_home_team
    # skip
    assert_equal "Utah Royals FC", @stat_tracker.lowest_home_team
  end


  def test_it_can_display_winningest_coach

    assert_equal "Claude Julien", @stat_tracker.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @stat_tracker.winningest_coach("20142015")
  end

  def test_it_can_display_worst_coach

    assert_equal "Peter Laviolette", @stat_tracker.worst_coach("20132014")
    assert_equal "Ted Nolan", @stat_tracker.worst_coach("20142015")
  end

  def test_it_can_display_most_accurate_team

    assert_equal "Real Salt Lake", @stat_tracker.most_accurate_team("20132014")
    assert_equal "Toronto FC", @stat_tracker.most_accurate_team("20142015")
  end

  def test_it_can_display_least_accurate_team

    assert_equal "New York City FC", @stat_tracker.least_accurate_team("20132014")
    assert_equal "Columbus Crew SC", @stat_tracker.least_accurate_team("20142015")
  end

  def test_it_can_display_most_tackles

    assert_equal "FC Cincinnati", @stat_tracker.most_tackles("20132014")
    assert_equal "Seattle Sounders FC", @stat_tracker.most_tackles("20142015")
  end

  def test_it_can_display_fewest_tackles

    assert_equal "Atlanta United", @stat_tracker.fewest_tackles("20132014")
    assert_equal "Orlando City SC", @stat_tracker.fewest_tackles("20142015")
  end

  def test_it_can_collect_goals

    hash = {"20122013"=>[1, 2, 3]
    }
    expected = {"20122013"=>4.0}
    assert_equal 14882, @stat_tracker.game_manager.collect_all_goals.length
    assert_equal Array, @stat_tracker.game_manager.collect_all_goals.class
    assert_equal 6, @stat_tracker.game_manager.collect_goals_by_season.length
    assert_equal Array, @stat_tracker.game_manager.collect_all_goals.class
    assert_equal 6, @stat_tracker.game_manager.average_goals_per_game([1, 2, 3])
    assert_equal expected, @stat_tracker.game_manager.average_goals_by_season(hash)
  end

  def test_it_can_get_average_goals
   total_goals = @stat_tracker.game_manager.collect_all_goals
   @stat_tracker.game_manager.average_goals_per_game(total_goals)

   assert_equal 4.22, @stat_tracker.average_goals_per_game1

   expected = {"20122013"=>4.12, "20162017"=>4.23, "20142015"=>4.14, "20152016"=>4.16, "20132014"=>4.19, "20172018"=>4.44}
   season_goals = @stat_tracker.game_manager.collect_goals_by_season
   @stat_tracker.game_manager.average_goals_by_season(season_goals)
   assert_equal expected, @stat_tracker.average_goals_by_season1
 end
end
