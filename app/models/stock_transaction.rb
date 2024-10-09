class StockTransaction < ApplicationRecord
  belongs_to :stock
  belongs_to :wallet
end
