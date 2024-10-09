class CreateStockTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :stock_transactions do |t|
      t.integer :quantity, null: false, default: 0
      t.float :price, null: false, default: 0.0
      t.references :stock, null: false, foreign_key: true
      t.references :wallet, null: false, foreign_key: true
      t.timestamps
    end
  end
end
