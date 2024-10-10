class TransactionsController < ApplicationController
  before_action :require_login

  def withdraw
    respond_to do |format|
      Transactions::WithdrawService.new(user: @current_user, amount: params[:amount]).perform
      sucess_redirect_with_notice(format, dashboard_path, "Withdraw Success")
    rescue => e
      error_redirect_with_alert(format, dashboard_path, e.message)
    end
  end

  def deposit
    respond_to do |format|
      Transactions::DepositService.new(user: @current_user, amount: params[:amount]).perform
      sucess_redirect_with_notice(format, dashboard_path, "Deposit Success")
    rescue => e
      error_redirect_with_alert(format, dashboard_path, e.message)
    end
  end

  def transfer
    respond_to do |format|
      Transactions::TransferService.new(user: @current_user, amount: params[:amount],
                                        username: params[:username]).perform
      sucess_redirect_with_notice(format, dashboard_path, "Transfer Success")
    rescue => e
      error_redirect_with_alert(format, dashboard_path, e.message)
    end
  end
end
