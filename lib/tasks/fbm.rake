namespace :fbm do
  desc "Greeting Text"
  task greeting: :environment do
    success =  Facebook::Messenger::Profile.set({
      greeting:[
        {
          locale: "default",
          text: "Hello it's Jean-Michel !\nPlay with 3 buddies to heat-up the party"
        },
        {
          locale: "fr_FR",
          text: "Salut c'est Jean-Michel !\nJoue avec 3 de tes potes pour vous chauffer en soirée"
        }
      ]
    }, access_token: ENV['ACCESS_TOKEN'])

    if success
      puts 'Greeting Text set :'
      puts RestClient.get("https://graph.facebook.com/v2.8/me/messenger_profile?fields=greeting&access_token=#{ENV['ACCESS_TOKEN']}")
    else
      puts 'Failure'
    end
  end

  desc "Get Started Button"
  task start: :environment do
    success =  Facebook::Messenger::Profile.set({
      get_started: {
        payload: "start"
      }
    }, access_token: ENV['ACCESS_TOKEN'])

    if success
      puts 'Get Started Button set :'
      puts RestClient.get("https://graph.facebook.com/v2.8/me/messenger_profile?fields=get_started&access_token=#{ENV['ACCESS_TOKEN']}")
    else
      puts 'Failure'
    end
  end

  desc "Persistent Menu"
  task menu: :environment do
    success =  Facebook::Messenger::Profile.set({
      persistent_menu:[
        {
          locale: "default",
          composer_input_disabled: false,
          call_to_actions: [
            {
              type: "postback",
              title: "🍻 Restart game",
              payload: "start",
            },
            {
              type: "postback",
              title: "🏆 TOP 10 worldwide",
              payload: "scores",
            },
            {
              type: "postback",
              title: "🤘 Share with your buddies",
              payload: "share",
            }
          ]
        },
        {
          locale: "fr_FR",
          composer_input_disabled: false,
          call_to_actions: [
            {
              type: "postback",
              title: "🍻 Redémarre le jeu",
              payload: "start",
            },
            {
              type: "postback",
              title: "🏆 TOP 10 monde",
              payload: "scores",
            },
            {
              type: "postback",
              title: "🤘 Partage avec tes potes",
              payload: "share",
            }
          ]
        }
      ]
    }, access_token: ENV['ACCESS_TOKEN'])

    if success
      puts 'Persistent Menu set :'
      puts RestClient.get("https://graph.facebook.com/v2.8/me/messenger_profile?fields=persistent_menu&access_token=#{ENV['ACCESS_TOKEN']}")
    else
      puts 'Failure'
    end
  end

  desc "Messenger Code"
  task code: :environment do
    data = {
      type: "standard",
      image_size: 2000
    }
    puts RestClient.post("https://graph.facebook.com/v2.8/me/messenger_codes?access_token=#{ENV['ACCESS_TOKEN']}", data.to_json, {content_type: :json, accept: :json})
  end
end
