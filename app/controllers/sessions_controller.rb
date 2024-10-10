class SessionsController < ApplicationController
  def new
    redirect_to dashboard_path unless session[:user_id].nil?
  end

  def create
    respond_to do |format|
      @user = User.find_by(username: params[:user][:username])
      if @user && user_authenticated?
        session[:user_id] = @user.id
        sucess_redirect_with_notice(format, dashboard_path, "Signed in successfully")
      else
        error_redirect_with_alert(format, login_path, "Invalid username or password")
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Signed out"
  end

  private

  def user_authenticated?
    @user.password_digest == Digest::SHA2.hexdigest(params[:user][:password])
  end
end
