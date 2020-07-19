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

  def test_it_can_display_best_season
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

end
