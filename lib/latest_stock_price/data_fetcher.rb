# frozen_string_literal: true

module LatestStockPrice
  class DataFetcher
    def initialize(data_type:, params:)
      @data_type = data_type
      @params = params || {}
    end
    
    def perform
      fetch_data
    end
    
    private
    
    def fetch_data
      @url = ENV['BaseURL'] + @data_type
      add_params

      http = Net::HTTP.new(URI(@url).host, URI(@url).port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(@url)
      request["X-RapidAPI-Key"] = ENV['RapidAPIKey']
      request["X-RapidAPI-Host"] = ENV['RapidAPIHost']

      response = http.request(request)
      JSON.parse(response.read_body)
    end
    
    def add_params
      if @params.present?
        @url += '?'
        @params.each do |key, value|
          next if key.in? ['page', 'per_page', 'controller', 'action']
          @url += "#{key}=#{value}&"
        end
      end
    end
  end
end
