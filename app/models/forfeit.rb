class Forfeit < ApplicationRecord
  include Mobility
  translates :description, type: :string, locale_accessors: true

  validates :description, presence: true
end
