class Room < ApplicationRecord
  has_many :opponents
  has_many :users, through: :opponents
  has_many :games

  validates :opponents, length: { maximum: 4 } # not working
end
