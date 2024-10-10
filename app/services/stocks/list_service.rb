module Stocks
  class ListService
    def initialize(user:)
      @user = user
    end

    def perform
      get_stocks
    end

    private
    def get_stocks
      @user.wallet.stock_transactions.group_by(&:stock_id).map do |stock_id, transactions|
        stock = Stock.find(stock_id)
        @transactions = transactions
        {
          id: stock.id,
          stock: stock.identifier,
          symbol: stock.symbol,
          quantity: quantity_bought_stocks - quantity_sold_stocks,
          balance: balance_bought_stocks - balance_sold_stocks
        }
      end
    end

    def quantity_bought_stocks
      @transactions.select { |trx| trx.transaction_type == "buy" }.sum(&:quantity)
    end

    def quantity_sold_stocks
      @transactions.select { |trx| trx.transaction_type == "sell" }.sum(&:quantity)
    end

    def balance_bought_stocks
      @transactions.select { |trx| trx.transaction_type == "buy" }.sum(&:price)
    end

    def balance_sold_stocks
      @transactions.select { |trx| trx.transaction_type == "sell" }.sum(&:price)
    end
  end
end
