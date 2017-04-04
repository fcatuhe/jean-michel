class Team < ApplicationRecord
  belongs_to :game
  belongs_to :sign
  has_many :team_members
  has_many :opponents, through: :team_members
end
