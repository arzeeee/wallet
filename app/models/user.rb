class User < ApplicationRecord
  has_one :wallet
  has_many :stock_transactions
end
