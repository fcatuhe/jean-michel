class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :players
  has_many :rooms, through: :players

  def dude
    gender == 'male' ? I18n.t('models.user.he_dude') : I18n.t('models.user.she_dude')
  end

  def player
    players.last
  end
end
