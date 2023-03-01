class Venue < ApplicationRecord
  # Searching option for index ation in /venues
  include PgSearch::Model

  pg_search_scope :search_by_name_address_description,
                  against: %i[name address description city country],
                  using: {
                    tsearch: { prefix: true }
                  }

  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many_attached :photos

  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :description, length: { minimum: 6 }
  validates :capacity, presence: true, numericality: { greater_than_or_equal_to: 10 }
  validates :price, presence: true
  # validates :available_dates, presence: true
end
