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
    signs = Sign.order('random()').limit(2)
    first_team = game.teams.create(sign: signs.first)
    second_team = game.teams.create(sign: signs.last)
    opponents = game.room.opponents.order('random()')
    opponents.first(2).each { |opponent| first_team.team_members.create(opponent: opponent) }
    opponents.last(2).each { |opponent| second_team.team_members.create(opponent: opponent) }
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
