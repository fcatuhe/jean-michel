class Game < ApplicationRecord
  belongs_to :room
  belongs_to :forfeit
end
