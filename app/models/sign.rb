class Sign < ApplicationRecord
  validates :description, presence: true
end
