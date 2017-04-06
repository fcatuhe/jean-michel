class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :players
  has_many :rooms, through: :players

  def dude
    gender == 'male' ? 'mec' : 'meuf'
  end

  def player
    players.last
  end
end
