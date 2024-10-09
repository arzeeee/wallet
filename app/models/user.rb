class User < ApplicationRecord
  has_one :wallet
  has_many :stock_transactions

  attr_accessor :password

  before_save :digest_password

  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_digest, presence: true

  def digest_password
    self.password_digest = Digest::SHA2.hexdigest(password)
  end
end
