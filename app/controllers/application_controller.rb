class ApplicationController < ActionController::Base
  # protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.include? 'application/json' }
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  def logged_in_user
    if logged_in?
      return true
    else
      flash[:danger] = "请登录！"
      redirect_to login_path
      flash.clear
    end
  end

end
