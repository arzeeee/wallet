class UsersController < ApplicationController
  before_action :logged_in?, only: :new
  before_action :require_login, only: :stocks

  def new
    @user = User.new
  end

  def create
    respond_to do |format|
      begin
        @user = Auth::RegisterService.new(params: params[:user]).perform
        sucess_redirect_with_notice(format, login_path, "User was successfully created. Please log in")
      rescue => e
        error_redirect_with_alert(format, register_path, e.message)
      end
    end
  end

  def index
    @users = User.all
  end

  def stocks
    @stocks = Stocks::ListService.new(user: @current_user).perform
    paginated_stocks = paginate(@stocks, params)
    @pagination = paginated_stocks[:pagination]
  end
end
