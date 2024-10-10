module Transactions
  class WithdrawService
    def initialize(user:, amount:)
      @user = user
      @user_wallet = @user.wallet
      @amount = amount.to_f
    end

    def perform
      check_for_amount
      check_for_balance
      withdraw
    end

    private

    def check_for_amount
      raise CustomErrors::AmountMustBePositive if @amount <= 0
    end

    def check_for_balance
      raise CustomErrors::BalanceNotEnough if (@user_wallet.balance - @amount).negative?
    end

    def withdraw
      ActiveRecord::Base.transaction do
        deduct_from_user
        create_credit_transaction
      end
    end

    def deduct_from_user
      @user_wallet.update(balance: @user_wallet.balance - @amount)
    end

    def create_credit_transaction
      @user.user_transactions.create(credit_transaction_params)
    end

    def credit_transaction_params
      {
        transaction_type: :withdraw,
        balance: @amount
      }
    end
  end
end
