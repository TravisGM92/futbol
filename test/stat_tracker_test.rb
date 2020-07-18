require "./test/test_helper.rb"
class StatTrackerTest < MiniTest::Test

  def test_it_exists
    stattracker1 = StatTracker.new('./data/dummy_data.csv')
    assert_instance_of StatTracker, stattracker1
  end

  def test_it_can_display_data
    stat_tracker1 = StatTracker.new('./data/dummy_data.csv')

    expected = "./data/dummy_data.csv"
    assert_equal stat_tracker1.data, expected
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
    expected = {2=>["22", "Seattle Sounders FC", "SEA", "/api/v1/teams/2"]}


    assert_equal stat_tracker.team_info(2), expected
  end

end
