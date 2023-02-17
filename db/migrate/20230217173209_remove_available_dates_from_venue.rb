class RemoveAvailableDatesFromVenue < ActiveRecord::Migration[7.0]
  def change
    remove_column :venues, :available_dates, :date
  end
end
