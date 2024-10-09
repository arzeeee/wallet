class SessionsController < ApplicationController
  def new;end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && user_authenticated?
      session[:user_id] = user.id
      redirect_to root_path, notice: "Signed in successfully"
    else
      flash[:alert] = "Invalid username or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed out"
  end

  private
  
  def user_authenticated?
    @user.password_digest == Digest::SHA2.hexdigest(params[:session][:password])
  end
end
