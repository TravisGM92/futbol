require "./test/test_helper.rb"
class StatTrackerTest < MiniTest::Test

  def test_it_exists
<<<<<<< HEAD
    # skip
=======
>>>>>>> 746d621fbeb42d16602993e442ace0c93877bc8e
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
<<<<<<< HEAD
    stattracker1 = StatTracker.from_csv(locations)


    assert_instance_of StatTracker, stattracker1
  end

  def test_it_can_display_team_name_with_team_ID
    # skip
=======

    stat_tracker = StatTracker.from_csv(locations)
    assert_instance_of StatTracker, stat_tracker
  end

  def test_it_has_attributes
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)
    assert_equal './data/games.csv', stat_tracker.games_data
    assert_equal './data/game_teams.csv', stat_tracker.game_teams_data
    assert_equal './data/teams.csv', stat_tracker.teams_data
    assert_equal Hash, stat_tracker.games.class
    assert_equal Hash, stat_tracker.game_stats.class
    assert_equal Hash, stat_tracker.teams.class

  end

  def test_it_can_generate_games
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)
    stat_tracker.generate_games
    assert_equal 7441, stat_tracker.games.count
  end

  def test_it_can_generate_teams
>>>>>>> 746d621fbeb42d16602993e442ace0c93877bc8e
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)
<<<<<<< HEAD
    expected = {"team_id"=>"2", "franchiseId"=>"22", "teamName"=>"Seattle Sounders FC", "abbreviation"=>"SEA", "Stadium"=>"Centruy Link Field", "link"=>"/api/v1/teams/2"}
    assert_equal stat_tracker.team_info(2), expected
  end

  def test_it_can_display_best_season_for_team_3
    # skip
=======
    stat_tracker.generate_teams
    assert_equal 32, stat_tracker.teams.count
  end

  def test_it_can_generate_game_stats
>>>>>>> 746d621fbeb42d16602993e442ace0c93877bc8e
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
<<<<<<< HEAD
    stat_tracker = StatTracker.from_csv(locations)


    assert_equal stat_tracker.best_season(3), "20142015"
  end

  def test_it_can_display_best_season_20132014
    # skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)


    assert_equal "20132014", stat_tracker.best_season(27)
  end

  def test_it_can_display_best_season_20152016
    # skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)


    assert_equal "20152016", stat_tracker.best_season(19)
  end

  def test_it_can_display_best_season_20162017
    # skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)


    assert_equal "20162017", stat_tracker.best_season(9)
  end

  def test_it_can_display_best_season_20122013
    # skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)


    assert_equal "20122013", stat_tracker.best_season(11)
  end

  def test_it_can_display_best_season_20172018
    # skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)


    assert_equal "20172018", stat_tracker.best_season(12)
  end

  def test_it_can_display_worst_season_20142015
    # skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "20142015", stat_tracker.worst_season(6)
  end

  def test_it_can_display_worst_season_20122013
    # skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "20122013", stat_tracker.worst_season(11)
  end

  def test_it_can_display_worst_season_20132014
    # skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "20132014", stat_tracker.worst_season(13)
  end

  def test_it_can_display_worst_season_20152016
    # skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "20152016", stat_tracker.worst_season(19)
  end

  def test_it_can_display_worst_season_20162017
    # skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "20162017", stat_tracker.worst_season(21)
  end

  def test_it_can_display_worst_season_20172018
    # skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "20172018", stat_tracker.worst_season(54)
  end

  def test_it_can_calculate_win_percentage
    # skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    assert_equal 0.49, stat_tracker.average_win_percentage(6)
  end

  def test_it_can_display_highest_goals
    # skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    assert_equal 7, stat_tracker.most_goals_scored(18)
  end

  def test_it_can_display_lowest_goals
    # skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    assert_equal 0, stat_tracker.fewest_goals_scored(18)
  end

  def test_it_can_display_favorite_opponent
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "DC United", stat_tracker.favorite_opponent(18)
  end

  def test_it_can_display_rival
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "Houston Dash", stat_tracker.rival(18)
  end


=======

    stat_tracker = StatTracker.from_csv(locations)
    stat_tracker.generate_game_stats
    require "pry"; binding.pry
    assert_equal 7441, stat_tracker.game_stats.count
  end
>>>>>>> 746d621fbeb42d16602993e442ace0c93877bc8e

end
