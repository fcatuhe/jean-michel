class Bot::FindUser
  def initialize(message)
    @user = User.find_by(messenger_id: message.sender['id'])
    unless @user
      user_data_json = RestClient.get("https://graph.facebook.com/v2.8/#{message.sender['id']}?access_token=#{ENV['ACCESS_TOKEN']}")
      user_data = JSON.parse user_data_json
      @user = User.create({
        email: "#{message.sender['id']}@messenger.com",
        password: Devise.friendly_token[0,20],
        first_name: user_data['first_name'],
        last_name: user_data['last_name'],
        messenger_id: message.sender['id'],
        profile_pic_url: user_data['profile_pic'],
        messenger_locale: user_data['locale'],
        gender: user_data['gender']
      })
    end
    I18n.locale = @user.messenger_locale.first(2).to_sym
  end

  def call
    @user
  end
end
