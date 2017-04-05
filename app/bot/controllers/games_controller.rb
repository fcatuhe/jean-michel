class Bot::GamesController
  def initialize(message, user)
    @user = user
    @view = Bot::GamesView.new(message, user)
  end

  def create
    if room = user.player.current_room
      game = room.games.create(forfeit: Forfeit.order('random()').first)
      first_team = nil
      second_team = nil
      Sign.order('random()').limit(2).each_with_index do |sign, index|
        if index < 1
          first_team = game.teams.create(sign: sign)
        else
          second_team = game.teams.create(sign: sign)
        end
      end
      game.players.order('random()').each_with_index do |player, index|
        if index < 2
          first_team.team_members.create(player: player)
        else
          second_team.team_members.create(player: player)
        end
      end
      Bot::NotificationsController.new.notify_sign(game)
    else
      view.no_room
    end
  end

  def referee(game_id, player_id)
    game = Game.find(game_id)
    player = Player.find(player_id)

    game.referee(user.player, player)

    Bot::NotificationsController.new.notify_players(game, player: user.player, designated_player: player)

    view.play_again
  end

  private

  attr_reader :view, :user
end
