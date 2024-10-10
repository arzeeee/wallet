class UserTransaction < ApplicationRecord
  belongs_to :user

  validates :balance, presence: true
  validates :transaction_type, presence: true
  enum transaction_type: { withdraw: 1, deposit: 2, transfer: 3, receive: 4 }

  scope :debit, -> { where(transaction_type: [ :deposit, :receive ]) }
  scope :credit, -> { where(transaction_type: [ :withdraw, :transfer ]) }
end
