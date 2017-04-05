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
