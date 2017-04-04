class Bot::RoomsController
  def initialize(message, user)
    @user = user
    @view = Bot::RoomsView.new(message, user)
  end

  def hello(options = {})
    view.hello(options)
  end

  def default_message
    view.default_message
  end

  def create
    room = user.rooms.create
    view.invite(room)
  end

  def add_user_to(room_id)
    room = Room.find(room_id)
    if room.opponents.size < 4 && room.opponents.create(user: user) # first condition because validation not working
      view.entered(room)
      Bot::NotificationsController.new.notify_new_opponent(room)
      if room.opponents.size == 4
        Bot::NotificationsController.new.start_game(room)
      end
    else
      view.room_full
    end
  end

  def create_game
    game = user.rooms.last.games.create(forfeit: Forfeit.order('random()').first)
    Sign.order('random()').limit(2).each_with_index do |sign, index|
      if index < 1
        first_team = game.teams.create(sign: sign)
      else
        second_team = game.teams.create(sign: sign)
      end
    end
    game.room.opponents.order('random()').each_with_index do |opponent, index|
      if index < 2
        first_team.team_members.create(opponent: opponent)
      else
        second_team.team_members.create(opponent: opponent)
      end
    end
    Bot::NotificationsController.new.notify_sign(game)
  end

  def compare(opponent_id)
    opponent = Opponent.find(opponent_id)
    if user.opponents.last.teams.last.opponents.include?(opponent)
      Bot::NotificationsController.new.notify_winners(user, opponent)
    else
      Bot::NotificationsController.new.notify_loosers(user, opponent)
    end
    view.play_again
  end

  private

  attr_reader :view, :user
end
