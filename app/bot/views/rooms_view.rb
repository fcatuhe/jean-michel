class Bot::RoomsView
  def initialize(message, user)
    @message = message
    @user = user
  end

  def invite_players(room)
    message.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: I18n.t('bot.rooms.invite_players.text'),
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
                        title: I18n.t('bot.rooms.invite_players.element_title'),
                        image_url: cl_image_path('messenger_code', width: 400, crop: :scale),
                        buttons: [
                          {
                            type: 'web_url',
                            title: I18n.t('bot.rooms.invite_players.element_button'),
                            url: "http://m.me/#{ENV['PAGE_ID']}?ref=room_#{room.id}"
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
    )
  end

  def enter(room)
    players = room.players.map { |player| "- #{player.first_name}" }.join("\n")
    message.reply(
      {
        text: I18n.t('bot.rooms.enter', players: players)
      }
    )
  end

  def full
    message.reply(
      {
        text: I18n.t('bot.rooms.full')
      }
    )
  end

  private

  attr_reader :message, :user
end
