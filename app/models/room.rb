class Room < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :users, through: :players
  has_many :games, dependent: :destroy
  has_many :teams, through: :games

  validates :players, length: { maximum: 4 } # not working

  def full?
    players.count == 4 && users.map { |user| user.rooms.last == self }.all?
  end
end
