class PagesController < ApplicationController
  before_action :require_login, only: :dashboard
  before_action :logged_in?, only: :home

  def dashboard
    @transaction  = @current_user.user_transactions.new
    @debit = @current_user.user_transactions.debit.sum(&:balance).round(2)
    @credit = @current_user.user_transactions.credit.sum(&:balance).round(2)
    @stocks = Stocks::ListService.new(user: @current_user).perform
  end

  def home;end
end
