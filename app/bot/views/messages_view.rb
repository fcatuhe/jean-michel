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
    puts image_url('messenger_code_400.png')
    message.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'generic',
          image_aspect_ratio: 'square',
          elements: [
            {
              title: I18n.t('bot.messages.share.title'),
              image_url: "https://jean-michel.herokuapp.com#{image_url('messenger_code_400.png')}",
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
                            image_url: "https://jean-michel.herokuapp.com#{image_url('messenger_code_400.png')}",
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

  def default
    message.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: "T'es trop bourré #{user.dude}, j'ai rien compris !\nOuvre le jeu ou attends l'invitation de ton pote",
          buttons: [
            {
              type: 'postback',
              title: "J'ouvre le jeu !",
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
