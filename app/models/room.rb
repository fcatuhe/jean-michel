class Room < ApplicationRecord
  has_many :players, -> { order(:id) }, dependent: :destroy
  has_many :users, through: :players
  has_many :games, dependent: :destroy
  has_many :teams, through: :games

  validates :players, length: { maximum: 4 } # not working

  def full?
    players.count == 4 && users.map { |user| user.player.room == self }.all?
  end
end
