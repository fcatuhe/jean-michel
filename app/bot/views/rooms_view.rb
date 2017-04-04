class Bot::RoomsView
  def initialize(message, user)
    @message = message
    @user = user
  end

  def hello(options = {})
    keyword = (options[:keyword]&.capitalize || 'Salut')
    message.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: "#{keyword} c'est Jean-Michel !\nDémarre le jeu ou attends l'invitation de ton pote.",
          buttons: [
            {
              type: 'postback',
              title: 'Démarrer le jeu',
              payload: 'create_room'
            }
          ]
        }
      }
    )
  end

  def default_message
    message.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: "T'es trop bourré mec, j'ai rien compris !\nDémarre le jeu ou attends l'invitation de ton pote.",
          buttons: [
            {
              type: 'postback',
              title: 'Démarrer le jeu',
              payload: 'create_room'
            }
          ]
        }
      }
    )
  end

  def invite(room)
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

  def entered(room)
    users = room.users.map { |user| "- #{user.first_name}" }.join("\n")
    message.reply(
      {
        text: "Bienvenue, les joueurs sont :\n#{users}"
      }
    )
  end

  def room_full
    message.reply(
      {
        text: "Désolé, le jeu est complet."
      }
    )
  end

  def play_again
    message.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: "Tu relances une partie ?",
          buttons: [
            {
              type: 'postback',
              title: 'Lancer une partie',
              payload: 'create_game'
            }
          ]
        }
      }
    )
  end

  private

  attr_reader :message, :user
end
