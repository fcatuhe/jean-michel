class Opponent < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :team_members
  has_many :teams, through: :team_members
end
