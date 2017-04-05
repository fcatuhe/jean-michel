class Bot::MessagesController
  def initialize(message, user)
    @user = user
    @view = Bot::MessagesView.new(message, user)
  end

  def hello(keywords = {})
    view.hello(keywords)
  end

  def default
    view.default
  end

  private

  attr_reader :view
end
