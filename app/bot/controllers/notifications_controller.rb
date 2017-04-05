class Bot::NotificationsController
  def initialize
    @view = Bot::NotificationsView.new
  end

  def notify_new_player(room)
    view.notify_new_player(room)
  end

  def start_game(room)
    room_creator = room.players.first
    view.start_game(room_creator)
  end

  def notify_sign(game)
    view.notify_sign(game)
  end

  def notify_players(game, params = {})
    view.notify_players(game, params)
  end

  private

  attr_reader :view
end
