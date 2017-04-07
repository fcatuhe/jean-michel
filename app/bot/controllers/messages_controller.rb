class Bot::MessagesController
  def initialize(message, user)
    @user = user
    @view = Bot::MessagesView.new(message, user)
  end

  def hello(keywords = {})
    view.hello(keywords)
  end

  def share
    view.share
  end

  def scores
    top_10 = User.order(score: :desc).limit(10).map { |user| user.human_score }.join("\n")
    view.scores(top_10)
  end

  def default
    view.default
  end

  private

  attr_reader :view
end
