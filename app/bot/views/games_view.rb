class Bot::GamesView
  def initialize(message, user)
    @message = message
    @user = user
  end

  def no_room
    message.reply(
      {
        text: I18n.t('bot.games.no_room')
      }
    )
  end

  def play_again
    message.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: I18n.t('bot.games.play_again.text'),
          buttons: [
            {
              type: 'postback',
              title: I18n.t('bot.games.play_again.button'),
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
