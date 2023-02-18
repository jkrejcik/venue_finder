class AddColumnsToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :booking_start_date, :date
    add_column :bookings, :booking_end_date, :date
  end
end
