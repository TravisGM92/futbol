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
    stat_tracker1 = StatTracker.new('./data/dummy_data.csv')


    assert_equal stat_tracker1.team_names_and_ID, 3
  end




end
