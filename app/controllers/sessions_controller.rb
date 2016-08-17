class SessionsController < ApplicationController
  def new
    render 'new'
  end

  def create
    if email_or_username?
      @user = User.find_by(email: params[:session][:username].downcase)
    else
      temp_username = params[:session][:username].strip.gsub(/\s+/, '')
      @user = User.find_by(name: temp_username)
    end

    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to root_path
    else
      flash[:danger] = '邮箱或者密码不正确'
      render 'new'
      flash.clear
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end

  private
  def email_or_username?
    temp_name = params[:session][:username]
    if temp_name.match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
      return true
    else
      return false
    end
  end
end
