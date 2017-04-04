class Bot::NotificationsController
  def initialize
    @view = Bot::NotificationsView.new
  end

  def notify_new_opponent(room)
    view.notify_new_opponent(room)
  end

  def start_game(room)
    room_creator = room.users.first
    view.start_game(room_creator)
  end

  def notify_sign(game)
    view.notify_sign(game)
  end

  def notify_winners(user, opponent)
    view.notify_winners(user, opponent)
  end

  def notify_loosers(user, opponent)
    view.notify_loosers(user, opponent)
  end

  private

  attr_reader :view
end
