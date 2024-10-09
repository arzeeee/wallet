class Wallet < ApplicationRecord
  belongs_to :walletable, polymorphic: true
  has_many :stock_transactions
end
