# frozen_string_literal: true

class StocksController < ApplicationController
  before_action :require_login
  before_action :get_stock_data, only: :prices
  before_action :assign_user_stock, only: :sell
  before_action :assign_stock, only: :purchase

  def price_all
    @stocks = Stock.all
  end

  def prices
    paginated_stocks = paginate(@stocks, params)
    @pagination = paginated_stocks[:pagination]
    @data = paginated_stocks[:data]
  end

  def update_prices
    LatestStockPrice::PriceUpdater.new.perform
    redirect_to stocks_price_all_path, notice: "Prices updated"
  end

  def purchase
    redirect_to stocks_prices_path, notice: "Stock not found" unless @stock

    @transaction = StockTransaction.new(wallet_id: @current_user.wallet.id, stock_id: @stock.id)
  end

  def buy_stock
    @transaction = StockTransaction.new(stock_transaction_params)
    @transaction.wallet_id = @current_user.wallet.id
    @transaction.transaction_type = :buy

    respond_to do |format|
      @transaction.save
      sucess_redirect_with_notice(format, dashboard_path, "Buy Stock Success")
    rescue => e
      error_redirect_with_alert(format, stocks_purchase_path(stock_id: @transaction.stock_id), e.message)
    end
  end

  def sell
    redirect_to stocks_prices_path, notice: "Stock not found" unless @stock

    @transaction = StockTransaction.new(wallet_id: @current_user.wallet.id, stock_id: @stock[:id])
  end

  def sell_stock
    @transaction = StockTransaction.new(stock_transaction_params)
    @transaction.wallet_id = @current_user.wallet.id
    @transaction.transaction_type = :sell

    respond_to do |format|
      @transaction.save
      sucess_redirect_with_notice(format, dashboard_path, "Sell Stock Success")
    rescue => e
      error_redirect_with_alert(format, stocks_sell_path(stock: @transaction.stock.identifier), e.message)
    end
  end



  private

  def get_stock_data
    @stocks = Stock.all
    search_query = params[:stock]
    @stocks = @stocks.where("identifier LIKE ? OR symbol LIKE ?", "%#{search_query}%", "%#{search_query}%") if search_query.present?
  end

  def assign_stock
    @stock = Stock.find_by(id: params[:stock_id])
  end

  def assign_user_stock
    stocks = Stocks::ListService.new(user: @current_user).perform
    @stock = stocks.select { |s| s[:stock] == params[:stock] }.first
    redirect_to users_stocks_path, notice: "Stock not found" unless @stock
  end

  def stock_transaction_params
    params.require(:stock_transaction).permit(:stock_id, :quantity)
  end
end
