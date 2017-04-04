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
      handle_referral
    end
  end

  private

  attr_reader :message, :postback, :user, :rooms_controller

  def handle_message
    case message.text
    when /hello/i, /bonjour/i, /bonsoir/i, /coucou/i, /salut/i
      messages_controller.hello(keyword: $LAST_MATCH_INFO[0])
    end
  end

  def handle_postback
    case postback.payload
    when 'start'
      messages_controller.hello
    when /\Arestaurant_(?<id>\d+)\z/
      restaurant_id = $LAST_MATCH_INFO['id'].to_i
      orders_controller.update(restaurant_id: restaurant_id)
      restaurants_controller.show(restaurant_id)
    end
  end
end
