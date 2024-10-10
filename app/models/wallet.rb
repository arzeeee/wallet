class Wallet < ApplicationRecord
  belongs_to :user
  has_many :stock_transactions

  before_save :round_balance

  def round_balance
    self.balance = balance.round(2)
  end
end
