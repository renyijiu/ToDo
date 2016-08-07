class PagesController < ApplicationController
  before_action :logged_in_user

  def index
    @tasks = current_user.tasks
    respond_to do |format|
      format.html { render 'index' }
      format.js { render 'remove_task'}
      format.json { render json: @tasks }
    end
  end
end
