# frozen_string_literal: true

module LatestStockPrice
  class PriceAll
    def initialize(params:)
      @params = params
    end

    def perform
      get_stock_price
    end

    private
    def get_stock_price
      LatestStockPrice::DataFetcher.new(data_type: "any", params: @params).perform
    end
  end
end
