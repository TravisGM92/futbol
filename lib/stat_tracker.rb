require 'CSV'

class StatTracker

  attr_reader :data


  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(data)
    @data = data
  end

  def game_total_score
    games_table = CSV.parse(File.read(self.data), headers: true).by_row
    result = Hash.new{|hash,key| hash[key] = []}
    games_table.each do |game|
        result[game[0]] << game[6].to_i
    end
    result.transform_values! {|score| score.sum}
  end

  def highest_total_score
    game_total_score.values.max
  end

  def lowest_total_score
    game_total_score.values.min
  end


end
