require 'CSV'

class StatTracker

  attr_reader :data
  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(data)
    @data = data
  end

  def team_info(id)
    hash = {}
    CSV.parse(File.read(@data[:teams]),
    headers: true).select{ |col| col[0] == "#{id}"}.flat_map do
      |row| hash[id] = [row[1], row[2], row[3], row[-1]]
    end
    hash
  end

end
