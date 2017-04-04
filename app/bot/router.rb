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
    # when Facebook::Messenger::Incoming::Referral
    #   handle_referral
    end
  end

  private

  attr_reader :message, :postback, :user, :rooms_controller

  def handle_message
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
    when /\Arestaurant_(?<id>\d+)\z/
    end
  end
end
