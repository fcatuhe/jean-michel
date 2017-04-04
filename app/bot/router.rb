class Bot::Router
  def initialize(message)
    @user = Bot::FindUser.new(message).call

    @rooms_controller = Bot::RoomsController.new(message, @user)

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

  attr_reader :message, :postback, :referral, :user, :rooms_controller

  def handle_message
    case message.quick_reply
    when /\Aopponent_(?<id>\d+)\z/
      opponent_id = $LAST_MATCH_INFO['id']
      rooms_controller.compare(opponent_id)
      return
    end

    case message.text
    when /hello/i, /bonjour/i, /bonsoir/i, /coucou/i, /salut/i, /wesh/i
      rooms_controller.hello(keyword: $LAST_MATCH_INFO[0])
    else
      rooms_controller.default_message
    end
  end

  def handle_postback
    case postback.payload
    when 'start'
      rooms_controller.hello
    when 'create_room'
      rooms_controller.create
    when 'create_game'
      rooms_controller.create_game
    end
  end

  def handle_referral
    case referral.ref
    when /\Aroom_(?<id>\d+)\z/
      room_id = $LAST_MATCH_INFO['id']
      rooms_controller.add_user_to(room_id)
    end
  end
end
