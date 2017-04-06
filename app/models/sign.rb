class Sign < ApplicationRecord
  include Mobility
  translates :description, type: :string

  validates :description, presence: true
end
