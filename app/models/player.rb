class Player < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :games, through: :room
  has_many :team_members
  has_many :teams, through: :team_members

  delegate :first_name, :messenger_id, to: :user

  def current_room
    room if room.full?
  end
end
