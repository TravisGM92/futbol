require 'CSV'

class StatTracker

  attr_reader :data


  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(data)
    @data = data
  end

  def data_by_row
    CSV.parse(File.read(self.data), headers: true).by_row
  end

  def goals_by_game_id
    result = Hash.new{|hash,key| hash[key] = []}
    data_by_row.each do |game|
      result[game[0]] << game[6].to_i
    end
    result
  end

  def game_total_score
    goals_by_game_id.transform_values! {|score| score.sum}
  end

##### Need to return team name
  def highest_total_score
    game_total_score.values.max
  end

  ##### Need to return team name
  def lowest_total_score
    game_total_score.values.min
  end

##### Have to break out by key in Self
  def percentage_home_wins(team)
    data_by_row = CSV.parse(File.read(self.data), headers: true).by_row
  end


end
