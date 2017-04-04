class Bot::NotificationsView
  def notify_ready(order, user)
    Bot.deliver({
      recipient: {
        id: user.messenger_id
      },
      message: {
        text: I18n.t('bot.order.notify_ready', user_first_name: user.first_name,restaurant_name: order.restaurant.name)
      }},
      access_token: ENV['YVON_ACCESS_TOKEN']
    )
  end

  def notify_delivered(order, user)
    Bot.deliver({
      recipient: {
        id: user.messenger_id
      },
      message: {
        attachment: {
          type: 'template',
          payload: {
            template_type: 'button',
            text: I18n.t('bot.order.notify_delivered', user_first_name: user.first_name,restaurant_name: order.restaurant.name),
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
                          title: I18n.t('bot.order.share'),
                          image_url: cl_image_path("yvon_messenger_code.png", width: 400, height: 400, crop: :fill),
                          buttons: [
                            {
                              type: 'web_url',
                              title: "Hello Yvon",
                              url: "http://m.me/HelloYvon?ref=shared"
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
        }
      }},
      access_token: ENV['YVON_ACCESS_TOKEN']
    )
  end
end
