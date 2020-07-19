require "./test/test_helper.rb"
class StatTrackerTest < MiniTest::Test

  def test_it_exists
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stattracker1 = StatTracker.from_csv(locations)


    assert_instance_of StatTracker, stattracker1
  end

  def test_it_can_display_team_name_with_team_ID
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)
    expected = {:team_id=>"2", :franchiseid=>"22", :teamname=>"Seattle Sounders FC", :abbreviation=>"SEA", :stadium=>"Centruy Link Field", :link=>"/api/v1/teams/2"}

    assert_equal stat_tracker.team_info(2), expected
  end

  def test_it_can_display_best_season_for_team_3
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)


    assert_equal stat_tracker.best_season(3), "20142015"
  end

  def test_it_can_display_best_season_20132014
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

end
