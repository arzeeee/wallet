module Transactions
  class DepositService
    def initialize(user:, amount:)
      @user = user
      @user_wallet = @user.wallet
      @amount = amount.to_f
    end

    def perform
      check_for_amount
      deposit
    end

    private

    def check_for_amount
      raise CustomErrors::AmountMustBePositive if @amount <= 0
    end

    def deposit
      ActiveRecord::Base.transaction do
        add_to_user
        create_debit_transaction
      end
    end

    def add_to_user
      @user_wallet.update(balance: @user_wallet.balance + @amount)
    end

    def create_debit_transaction
      @user.user_transactions.create(debit_transaction_params)
    end

    def debit_transaction_params
      {
        transaction_type: :deposit,
        balance: @amount
      }
    end
  end
end
