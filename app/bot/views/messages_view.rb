class Bot::MessagesView
  def initialize(message, user)
    @message = message
    @user = user
  end

  def hello(keywords = {})
    greeting = (keywords[:greeting]&.capitalize || I18n.t('bot.messages.greeting'))
    message.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: I18n.t('bot.messages.hello.text', greeting: greeting),
          buttons: [
            {
              type: 'postback',
              title: I18n.t('bot.messages.hello.button'),
              payload: 'room_create'
            }
          ]
        }
      }
    )
  end

  def share
    message.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'generic',
          image_aspect_ratio: 'square',
          elements: [
            {
              title: I18n.t('bot.messages.share.title'),
              image_url: cl_image_path('messenger_code', width: 400, crop: :scale),
              buttons: [
                {
                  type: 'element_share',
                  share_contents: {
                    attachment: {
                      type: 'template',
                      payload: {
                        template_type: 'generic',
                        image_aspect_ratio: 'square',
                        elements: [
                          {
                            title: I18n.t('bot.messages.share.title'),
                            image_url: cl_image_path('messenger_code', width: 400, crop: :scale),
                            buttons: [
                              {
                                type: 'web_url',
                                title: I18n.t('bot.messages.share.element_button'),
                                url: "http://m.me/#{ENV['PAGE_ID']}"
                              }
                            ]
                          }
                        ]
                      }
                    }
                  }
                }
              ]
            }
          ]
        }
      }
    )
  end

  def scores(top_10)
    message.reply(
      text: top_10
    )
  end

  def default
    message.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: I18n.t('bot.messages.default.text', dude: user.dude),
          buttons: [
            {
              type: 'postback',
              title: I18n.t('bot.messages.default.button'),
              payload: 'room_create'
            }
          ]
        }
      }
    )
  end

  private

  attr_reader :message, :user
end
