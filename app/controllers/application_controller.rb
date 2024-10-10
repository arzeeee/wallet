class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def logged_in?
    redirect_to dashboard_path, alert: "Already logged in" unless session[:user_id].nil?
  end

  def require_login
    if session[:user_id].nil?
      return redirect_to login_path, alert: "Must be logged in"
    end
    @current_user = User.find_by(id: session[:user_id])
  end

  def sucess_redirect_with_notice(format, path, msg = nil)
    format.html { redirect_to path, notice: msg }
    format.json { render json: { status: 200, notice: msg }, status: :ok }
  end

  def error_redirect_with_alert(format, path, msg = nil)
    format.html { redirect_to path, alert: msg }
    format.json { render json: { status: 422, alert: msg }, status: :unprocessable_entity }
  end
end
