class Bot::NotificationsView
  def notify_new_player(room)
    new_player = room.players.last

    room.players[0..-2].each do |player|
      Bot.deliver({
        recipient: {
          id: player.messenger_id
        },
        message: {
          text: "#{new_player.first_name} est entré dans le jeu"
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
            text: "Le groupe est complet, tu peux lancer une partie",
            buttons: [
              {
                type: 'postback',
                title: 'Je lance la partie !',
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
    game.teams.each do |team|
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
            text: "Le signe de ton équipe est : #{team.sign.description}.\nAs-tu reconnu ton coéquipier ?",
            quick_replies: quick_replies
          }},
          access_token: ENV['ACCESS_TOKEN']
        )
      end
    end
  end

  def notify_players(game, params = {})
    forfeit = game.forfeit.description
    scores = game.players.order(score: :desc).map { |player| "- #{player.first_name} - #{player.score}"}.join("\n")

    game.teams.each do |team|
      if team.winner?
        team.players.each do |player|
          Bot.deliver({
            recipient: {
              id: player.messenger_id
            },
            message: {
              text: "#{params[:player].first_name} a désigné #{params[:designated_player].first_name}, tu as gagné !\nGage pour les perdants : #{forfeit}\nScore :\n#{scores}",
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
              text: "#{params[:player].first_name} a désigné #{params[:designated_player].first_name}, tu as perdu !\nTon gage : #{forfeit}\nScore :\n#{scores}",
            }},
            access_token: ENV['ACCESS_TOKEN']
          )
        end
      end
    end
  end
end
