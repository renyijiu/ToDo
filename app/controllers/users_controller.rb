require "open-uri"
class UsersController < ApplicationController
  before_action :logged_in_user, only: :show
  def new
    @user = User.new
  end

  def show
    num = rand(5001)
    while true
      @picture = run(num)
      if @picture
        break
      else
        num = rand(5001)
      end
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                    :password_confirmation)
    end

    def run(num)
      base_url = "https://500px.com/photo/"
      page_url = base_url + num.to_s
      begin
        text = open(page_url).read
        pattern = /<meta content='(.*?)' property='og:image'>/
        picture_url = pattern.match(text)[1]
        if picture_url
          return picture_url
        else
          return false
        end
      rescue
        return false
      end
    end
end
