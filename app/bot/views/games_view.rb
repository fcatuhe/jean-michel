class Bot::GamesView
  def initialize(message, user)
    @message = message
    @user = user
  end

  def no_room
    message.reply(
      {
        text: "Désolé, tu n'as plus de jeu en cours"
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
              title: 'Je relance !',
              payload: 'game_create'
            }
          ]
        }
      }
    )
  end

  private

  attr_reader :message, :user
end
