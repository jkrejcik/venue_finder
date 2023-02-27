class Venue < ApplicationRecord
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
