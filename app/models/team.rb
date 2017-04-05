class Team < ApplicationRecord
  belongs_to :game
  belongs_to :sign
  has_many :team_members
  has_many :players, through: :team_members

  enum result: [:looser, :winner]
end
