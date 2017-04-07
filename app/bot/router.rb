class Bot::Router
  def initialize(message)
    @user = Bot::FindUser.new(message).call

    @messages_controller = Bot::MessagesController.new(message, @user)
    @rooms_controller = Bot::RoomsController.new(message, @user)
    @games_controller = Bot::GamesController.new(message, @user)

    case message
    when Facebook::Messenger::Incoming::Message
      @message = message
      handle_message
    when Facebook::Messenger::Incoming::Postback
      @postback = message
      handle_postback
    when Facebook::Messenger::Incoming::Referral
      @referral = message
      handle_referral
    end
  end

  private

  attr_reader :message, :postback, :referral, :user, :messages_controller, :rooms_controller, :games_controller

  def handle_message
    case message.quick_reply
    when /\Agame_(?<game_id>\d+)_player_(?<id>\d+)\z/
      game_id = $LAST_MATCH_INFO['game_id']
      player_id = $LAST_MATCH_INFO['id']
      games_controller.referee(game_id, player_id)
      return
    end

    case message.text
    when /hello/i, /bonjour/i, /bonsoir/i, /coucou/i, /salut/i, /wesh/i
      messages_controller.hello(greeting: $LAST_MATCH_INFO[0])
    else
      messages_controller.default
    end
  end

  def handle_postback
    case postback&.referral&.ref
    when /\Aroom_(?<id>\d+)\z/
      room_id = $LAST_MATCH_INFO['id']
      rooms_controller.add_player(room_id)
      return
    end

    case postback.payload
    when 'start'
      messages_controller.hello
    when 'share'
      messages_controller.share
    when 'scores'
      messages_controller.scores
    when 'room_create'
      rooms_controller.create
    when 'game_create'
      games_controller.create
    end
  end

  def handle_referral
    case referral.ref
    when /\Aroom_(?<id>\d+)\z/
      room_id = $LAST_MATCH_INFO['id']
      rooms_controller.add_player(room_id)
    end
  end
end
