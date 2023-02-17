class CreateVenues < ActiveRecord::Migration[7.0]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :address
      t.text :description
      t.integer :capacity
      t.integer :price
      t.date :available_dates
      t.string :picture_url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
