class CreateStocks < ActiveRecord::Migration[7.2]
  def change
    create_table :stocks do |t|
      t.string :identifier, null: false
      t.float :change, null: false
      t.float :day_high, null: false
      t.float :day_low, null: false
      t.float :last_price, null: false
      t.timestamps
    end
  end
end
