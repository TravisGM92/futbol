require './lib/game_manager'
require './lib/team_manager'
require './lib/game_teams_manager'

class StatTracker

  game_path = './data/games.csv'
  team_path = './data/teams.csv'
  game_teams_path = './data/game_teams.csv'

  locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
  }
  attr_reader :game_teams, :games, :teams, :seasons
  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(locations)
    @game_teams = []
    CSV.foreach(locations[:game_teams], headers: true) do |row|
      @game_teams << GameTeam.new(row)
    end
    @games = []
    CSV.foreach(locations[:games], headers: true) do |row|
      @games << Game.new(row)
    end
    @teams = []
    CSV.foreach(locations[:teams], headers: true) do |row|
      @teams << Team.new(row)
    end
    @seasons = {}
    generate_seasons
  end

  def generate_seasons
    seasons_list = @games.map {|game| game.season}.uniq.sort
    seasons_list.each {|season| @seasons[season] = []}
    @games.each {|game| @seasons[game.season] << game}
  end

  # def games_coached(season)
  #   coaches = []
  #   @seasons[season].each do |season_game|
  #     @game_teams.each do |game|
  #       if season_game.game_id == game.game_id
  #         coaches << game.head_coach
  #       end
  #     end
  #   end
  #   games_coached = Hash.new(0)
  #   coaches.each {|coach| games_coached[coach] += 1}
  #   games_coached
  # end

end

#########HOW I ORIGINALLY SET UP STATTRACKER AND WINNINGEST_COACH############
#########UGLY AS HECK BUT FAST##############


# require 'CSV'
#
# class StatTracker
#
#   attr_reader :games_data,
#               :teams_data,
#               :game_teams_data,
#               :games,
#               :teams,
#               :game_stats,
#               :yearly_games_won,
#               :yearly_games_lost,
#               :yearly_games_tied,
#               :yearly_games_total
#   def self.from_csv(data)
#     StatTracker.new(data)
#   end
#
#   def initialize(data)
#     @games_data = data[:games]
#     @teams_data = data[:teams]
#     @game_teams_data = data[:game_teams]
#     @games = {}
#     @teams = {}
#     @game_stats = Hash.new{|hash, key| hash[key] = {} }
#     @yearly_games_won = {}
#     @yearly_games_lost = {}
#     @yearly_games_tied = {}
#     @yearly_games_total = {}
#   end
#
#   def generate_games
#     CSV.foreach(@games_data, headers: true, header_converters: :symbol) do |row|
#       @games[row[:game_id]] = Game.new(row)
#     end
#   end
#
#   def generate_teams
#     CSV.foreach(@teams_data, headers: true, header_converters: :symbol) do |row|
#       @teams[row[:team_id]] = Team.new(row)
#     end
#   end
#
#   def generate_game_stats
#     CSV.foreach(@game_teams_data, headers: true, header_converters: :symbol) do |row|
#       @game_stats[row[:game_id]].store row[:hoa], GameTeam.new(row)
#     end
#   end
#
#   def generate_coach_results(season_id)
#     coached_games = []
#     season_id_games = @games.values.find_all {|value| value.season == season_id}
#     season_id_games.each do |game|
#       if @game_stats.keys.include?(game.game_id)
#         coached_games << @game_stats[game.game_id]
#       end
#     end
#     coached_games_won = Hash.new(0)
#     coached_games_lost = Hash.new(0)
#     coached_games_tied = Hash.new(0)
#     coached_games_total = Hash.new(0)
#     coached_games.each do |pair|
#       pair.values.each do |value|
#         if value.result == "WIN"
#           coached_games_won[value.head_coach] += 1
#         elsif value.result == "LOSS"
#           coached_games_lost[value.head_coach] += 1
#         elsif value.result == "TIE"
#           coached_games_tied[value.head_coach] += 1
#         end
#       end
#     end
#     @yearly_games_won[season_id] = coached_games_won
#     @yearly_games_lost[season_id] = coached_games_lost
#     @yearly_games_tied[season_id] = coached_games_tied
#     coaches = [@yearly_games_won[season_id].keys, @yearly_games_lost[season_id].keys, @yearly_games_tied[season_id].keys].flatten.uniq
#     coaches.each {|name| coached_games_total[name] = (@yearly_games_won[season_id][name]) + (@yearly_games_lost[season_id][name]) + (@yearly_games_tied[season_id][name])}
#     @yearly_games_total[season_id] = coached_games_total
#   end
#
#   def winning_percentage(season_id)
#     generate_coach_results(season_id)
#     coach_winning_percentage = Hash.new(0)
#     @yearly_games_won[season_id].each do |won_key, won_value|
#       @yearly_games_total[season_id].each do |coached_key, coached_value|
#         if @yearly_games_won[season_id].keys.include?(coached_key)
#           if won_key == coached_key
#             coach_winning_percentage[won_key] = (won_value.to_f / coached_value).round(3)
#           end
#         else
#           coach_winning_percentage[coached_key] = 0
#         end
#       end
#     end
#     coach_winning_percentage
#   end
#
#   def winningest_coach(season_id)
#     high_win_percentage = winning_percentage(season_id).max_by {|coach, percentage| percentage}
#     high_win_percentage[0]
#   end
#
#   def worst_coach(season_id)
#     low_win_percentage = winning_percentage(season_id).min_by {|coach, percentage| percentage}
#     low_win_percentage[0]
#   end
#
# end
