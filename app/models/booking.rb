class Booking < ApplicationRecord
  belongs_to :venue
  belongs_to :user

  validates :booking_start_date, :booking_end_date, presence: true
  validate :start_date_in_future
  validate :end_date_after_start_date

  private

  def start_date_in_future
    today = Date.today
    errors.add(:booking_start_date, "must be in the future") if today >= booking_start_date
  end

  def end_date_after_start_date
    return if booking_end_date.blank? || booking_start_date.blank?

    errors.add(:booking_end_date, "must be after the start date") if booking_end_date < booking_start_date
  end
end
