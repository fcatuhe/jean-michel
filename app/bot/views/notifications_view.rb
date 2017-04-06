class Bot::NotificationsView
  def notify_new_player(room)
    new_player = room.players.last

    room.players[0..-2].each do |player|
      Bot.deliver({
        recipient: {
          id: player.messenger_id
        },
        message: {
          text: I18n.t('bot.notifications.notify_new_player', new_player: new_player.first_name)
        }},
        access_token: ENV['ACCESS_TOKEN']
      )
    end
  end

  def start_game(room_creator)
    Bot.deliver({
      recipient: {
        id: room_creator.messenger_id
      },
      message: {
        attachment: {
          type: 'template',
          payload: {
            template_type: 'button',
            text: I18n.t('bot.notifications.start_game.text'),
            buttons: [
              {
                type: 'postback',
                title: I18n.t('bot.notifications.start_game.button'),
                payload: 'game_create'
              }
            ]
          }
        }
      }},
      access_token: ENV['ACCESS_TOKEN']
    )
  end

  def notify_sign(game)
    game.teams.includes(:players).each do |team|
      team.players.each do |player|
        quick_replies = []
        player_index = game.players.index(player)
        3.times do |i|
          iteration_player = game.players[(player_index + i + 1) % 4]
          quick_replies << {
            content_type: 'text',
            title: "#{iteration_player.first_name}",
            payload: "game_#{game.id}_player_#{iteration_player.id}"
          }
        end

        Bot.deliver({
          recipient: {
            id: player.messenger_id
          },
          message: {
            text: I18n.t('bot.notifications.notify_sign', sign: team.sign.description),
            quick_replies: quick_replies
          }},
          access_token: ENV['ACCESS_TOKEN']
        )
      end
    end
  end

  def notify_players(game, params = {})
    forfeit = game.forfeit.description
    teams = game.teams.map { |team| "- #{team.players.map { |player| player.first_name }.join(' & ')}" }.join("\n")
    scores = game.players.order(score: :desc).map { |player| "- #{player.first_name} : #{player.score}"}.join("\n")

    game.teams.includes(:players).each do |team|
      if team.winner?
        team.players.each do |player|
          Bot.deliver({
            recipient: {
              id: player.messenger_id
            },
            message: {
              text: I18n.t('bot.notifications.notify_players.winners', player: params[:player].first_name, designated_player: params[:designated_player].first_name, teams: teams, forfeit: forfeit, scores: scores),
            }},
            access_token: ENV['ACCESS_TOKEN']
          )
        end
      else
        team.players.each do |player|
          Bot.deliver({
            recipient: {
              id: player.messenger_id
            },
            message: {
              text: I18n.t('bot.notifications.notify_players.loosers', player: params[:player].first_name, designated_player: params[:designated_player].first_name, teams: teams, forfeit: forfeit, scores: scores),
            }},
            access_token: ENV['ACCESS_TOKEN']
          )
        end
      end
    end
  end
end
