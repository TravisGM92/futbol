require 'CSV'

class StatTracker

  attr_reader :data
  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(data)
    @data = data
  end

  def team_names_and_ID

  end
  

end
