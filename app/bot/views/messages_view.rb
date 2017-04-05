class Bot::MessagesView
  def initialize(message, user)
    @message = message
    @user = user
  end

  def hello(keywords = {})
    greeting = (keywords[:greeting]&.capitalize || 'Salut')
    message.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: "#{greeting} c'est Jean-Michel !\nOuvre le jeu ou attends l'invitation de ton pote",
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

  def share
    message.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'generic',
          image_aspect_ratio: 'square',
          elements: [
            {
              title: "👊 Checke Jean-Michel pour ambiancer tes soirées !",
              # image_url: ,
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
                            title: "👊 Checke Jean-Michel pour ambiancer tes soirées !",
                            # image_url: ,
                            buttons: [
                              {
                                type: 'web_url',
                                title: "👊 Jean-Michel",
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
