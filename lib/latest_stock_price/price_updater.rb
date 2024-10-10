# frozen_string_literal: true

module LatestStockPrice
  class PriceUpdater
    def perform
      update_all_prices
    end

    private
    def update_all_prices
      stocks = LatestStockPrice::PriceAll.new(params: {}).perform
      stocks.map! { |x| x.slice("identifier", "dayHigh", "change", "dayHigh", "dayLow", "lastPrice", "symbol", "lastUpdateTime").transform_keys(&:underscore) }
      Stock.upsert_all(stocks, unique_by: :identifier)
    end
  end
end
