class AddAddressColumnsToVenue < ActiveRecord::Migration[7.0]
  def change
    add_column :venues, :city, :string
    add_column :venues, :zip, :string
    add_column :venues, :street, :string
    add_column :venues, :country, :string
    add_column :venues, :building, :string
  end
end
