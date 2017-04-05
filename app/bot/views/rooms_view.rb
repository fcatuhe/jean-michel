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
          text: 'Invite tes 3 potes :',
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
                        title: 'Rejoins-moi chez Jean-Michel',
                        # image_url: ,
                        buttons: [
                          {
                            type: 'web_url',
                            title: "J'arrive !",
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
        text: "Bienvenue, les joueurs sont :\n#{players}"
      }
    )
  end

  def full
    message.reply(
      {
        text: "Désolé, le jeu est complet"
      }
    )
  end

  private

  attr_reader :message, :user
end
