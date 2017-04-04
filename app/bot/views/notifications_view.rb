class Bot::NotificationsView
  def notify_new_opponent(room)
    new_user = room.users.last

    room.users[0..-2].each do |user|
      Bot.deliver({
        recipient: {
          id: user.messenger_id
        },
        message: {
          text: "#{new_user.first_name} est entré dans le jeu"
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
            text: "Le groupe est complet, tu peux lancer une partie :",
            buttons: [
              {
                type: 'postback',
                title: 'Lancer une partie',
                payload: 'create_game'
              }
            ]
          }
        }
      }},
      access_token: ENV['ACCESS_TOKEN']
    )
  end

  def notify_sign(game)
    game.room.opponents.each do |opponent|
      quick_replies = []
      opponent_index = game.room.opponents.index(opponent)
      3.times do |i|
        iterated_opponent = game.room.opponents[(opponent_index + i) % 4]
        quick_replies << {
          content_type: 'text',
          title: "#{iterated_opponent.user.first_name}",
          payload: "opponent_#{iterated_opponent.id}"
        }
      end

      Bot.deliver({
        recipient: {
          id: opponent.user.messenger_id
        },
        message: {
          text: "Le signe de ton équipe est : #{opponent.teams.last.sign.description}.\nAs-tu reconnu ton coéquipier ?",
          quick_replies: quick_replies
        }},
        access_token: ENV['ACCESS_TOKEN']
      )
    end
  end

  def notify_winners(player_user, opponent)
    forfeit = player_user.rooms.last.games.last.forfeit.description
    player_user.rooms.last.users.each do |user|
      Bot.deliver({
        recipient: {
          id: user.messenger_id
        },
        message: {
          text: "#{player_user.first_name} a désigné #{opponent.user.first_name}, ils ont gagné !\nGage pour les perdants : #{forfeit}",
        }},
        access_token: ENV['ACCESS_TOKEN']
      )
    end
  end

  def notify_loosers(player_user, opponent)
    forfeit = player_user.rooms.last.games.last.forfeit.description
    player_user.rooms.last.users.each do |user|
      Bot.deliver({
        recipient: {
          id: user.messenger_id
        },
        message: {
          text: "#{player_user.first_name} a désigné #{opponent.user.first_name}, c'est perdu pour son équipe !\nGage pour les perdants : #{forfeit}",
        }},
        access_token: ENV['ACCESS_TOKEN']
      )
    end
  end
end
