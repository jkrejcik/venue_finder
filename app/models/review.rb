class Review < ApplicationRecord
  belongs_to :venue
  belongs_to :booking

  has_one :user, through: :booking
end
