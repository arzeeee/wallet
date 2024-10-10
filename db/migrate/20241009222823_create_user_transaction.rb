class CreateUserTransaction < ActiveRecord::Migration[7.2]
  def change
    create_table :user_transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.float :balance
      t.string :transaction_type
      t.timestamps
    end
  end
end
