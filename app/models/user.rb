class User < ApplicationRecord
  has_one :wallet
  has_many :stock_transactions
  has_many :user_transactions

  attr_accessor :password

  before_save :digest_password
  before_save :assign_wallet

  INITIAL_BALANCE = 50_000

  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def digest_password
    self.password_digest = Digest::SHA2.hexdigest(password)
  end

  def assign_wallet
    return unless new_record?

    self.user_transactions.build({
      transaction_type: :receive,
      balance: INITIAL_BALANCE
    })
    self.build_wallet(balance: INITIAL_BALANCE)
  end

  def wallet_balance
    wallet.balance
  end
end
