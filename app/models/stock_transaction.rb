class StockTransaction < ApplicationRecord
  belongs_to :stock
  belongs_to :wallet

  before_save :assign_price, :check_quantity, :check_balance, :check_stock

  after_save :update_wallet_balance

  enum transaction_type: { buy: 1, sell: 2 }

  scope :buy, -> { where(transaction_type: :buy) }
  scope :sell, -> { where(transaction_type: :sell) }

  def assign_price
    self.price = stock.last_price * quantity
  end

  def check_quantity
    raise CustomErrors::InvalidQuantity if quantity <= 0
  end

  def check_balance
    return unless transaction_type == "buy"

    raise CustomErrors::InvalidBalance if wallet.balance < price
  end

  def check_stock
    return unless transaction_type == "sell"

    bought_amount = wallet.stock_transactions.buy.where(stock_id: stock_id).sum(:quantity)
    sold_amount = wallet.stock_transactions.sell.where(stock_id: stock_id).sum(:quantity)
    raise CustomErrors::InvalidStockAmount if bought_amount - sold_amount < quantity
  end

  def update_wallet_balance
    if transaction_type == "buy"
      wallet.update(balance: wallet.balance - price)
    else
      wallet.update(balance: wallet.balance + price)
    end
  end
end
