class Bot::RoomsController
  def initialize(message, user)
    @user = user
    @view = Bot::RoomsView.new(message, user)
  end

  def create
    room = user.rooms.create
    view.invite_players(room)
  end

  def add_player(room_id)
    room = Room.find(room_id)
    if room.players.size < 4 && room.players.create(user: user) # first condition because validation not working
      view.enter(room)
      Bot::NotificationsController.new.notify_new_player(room)
      if room.players.size == 4
        Bot::NotificationsController.new.start_game(room)
      end
    else
      view.full
    end
  end

  private

  attr_reader :view, :user
end
