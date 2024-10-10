module Transactions
  class TransferService
    def initialize(user:, amount:, username:)
      @sender = user
      @sender_wallet = @sender.wallet
      @receiver = User.find_by(username: username)&.tap { |receiver| @receiver_wallet = receiver&.wallet }
      @amount = amount.to_f
    end

    def perform
      check_amount
      check_receiver
      check_balance
      transfer
    end

    private

    def check_amount
      raise CustomErrors::AmountMustBePositive if @amount <= 0
    end

    def check_balance
      raise CustomErrors::BalanceNotEnough if (@sender_wallet.balance - @amount).negative?
    end

    def check_receiver
      raise CustomErrors::SameUserTransfer if @receiver == @sender
      raise CustomErrors::UserNotFound if @receiver.nil?
    end

    def transfer
      ActiveRecord::Base.transaction do
        add_to_receiver
        deduct_from_sender
        create_transaction(@receiver, debit_transaction_params)
        create_transaction(@sender, credit_transaction_params)
      end
    end

    def add_to_receiver
      @receiver_wallet.update(balance: @receiver_wallet.balance + @amount)
    end

    def deduct_from_sender
      @sender_wallet.update(balance: @sender_wallet.balance - @amount)
    end

    def create_transaction(user, params)
      user.user_transactions.create(params)
    end

    def credit_transaction_params
      {
        transaction_type: :transfer,
        balance: @amount
      }
    end

    def debit_transaction_params
      {
        transaction_type: :receive,
        balance: @amount
      }
    end
  end
end
