class Team < ApplicationRecord
  belongs_to :game
  belongs_to :sign
end
