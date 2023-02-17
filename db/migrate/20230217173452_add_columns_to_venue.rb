class AddColumnsToVenue < ActiveRecord::Migration[7.0]
  def change
    add_column :venues, :available_start_date, :date
    add_column :venues, :available_end_date, :date
  end
end
