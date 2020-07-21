class ReadFiles

  def read(data)
    @data = data
    @game_team_rows = CSV.parse(File.read(@data[:game_teams]), headers: true)
    @game_rows = CSV.parse(File.read(@data[:games]))
    @seasons = CSV.parse(File.read(@data[:games]), headers: true).map do |col|
      col[1]
    end.uniq.sort!
    @body = File.read(@data[:teams])
    @body1 = CSV.parse(File.read(@data[:teams]), headers: false)
  end
end
