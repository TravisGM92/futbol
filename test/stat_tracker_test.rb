require "./test/test_helper.rb"
### Refactor/remove
class StatTrackerTest < MiniTest::Test


  def setup
    ################## Pulled from Runner.rb
    game_path = './data/games_sample.csv'
    team_path = './data/teams_sample.csv'
    game_teams_path = './data/game_teams_sample.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    #######################
  end

  def test_it_exists
    stattracker1 = StatTracker.new(@locations)
    assert_instance_of StatTracker, stattracker1
  end

  def test_highest_total_score
    stattracker1 = StatTracker.new(@locations)
    assert_equal 5, stattracker1.highest_total_score
  end

  def test_lowest_total_score
    stattracker1 = StatTracker.new(@locations)
    assert_equal 3, stattracker1.lowest_total_score
  end

  def test_percentage_home_wins
    stattracker1 = StatTracker.new(@locations)
    assert_equal = 66.67, stattracker1.percentage_home_wins('FC Dallas')
  end

  #
  # game_path = './data/games_sample.csv'
  # team_path = './data/teams_sample.csv'
  # game_teams_path = './data/game_teams_sample.csv'
  #
  # @locations = {
  #   games: game_path,
  #   teams: team_path,
  #   game_teams: game_teams_path
  # }
  # stattracker1 = StatTracker.new(@locations)
  # puts stattracker1.percentage_home_wins('FC Dallas')


end
