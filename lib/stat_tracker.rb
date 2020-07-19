require 'CSV'

class StatTracker

  attr_reader :data, :seasons, :game_team_rows, :game_rows, :team_rows, :team_cols, :body
  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(data)
    @data = data
    @game_team_rows = CSV.parse(File.read(@data[:game_teams]))
    @game_rows = CSV.parse(File.read(@data[:games]))
    @seasons = CSV.parse(File.read(@data[:games]), headers: true).map do |col|
      col[1]
    end.uniq.sort!
    @headers = CSV.parse(File.read(@data[:teams]),
      headers: false)[0]
    @body = File.read(@data[:teams])
    @team_cols = CSV.parse(File.read(@data[:teams]), headers: false)
  end

  def team_info(id)
    hash = {}
    csv = CSV.new(@body, :headers => true, :header_converters => :symbol)
    teams_hash = csv.to_a.map{ |row| row.to_hash}
    teams_hash.find{ |hash| hash[:team_id] == "#{id}"}
  end
end
