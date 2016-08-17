class TasksController < ApplicationController
  before_action :logged_in_user

  def index
    @tasks = current_user.tasks
    respond_to do |format|
      format.html { render 'index' }
      format.js { render 'hide_form'}
    end
  end

  def new
    @task = Task.new
    render 'show_form'
  end

  def create
    @task = current_user.tasks.create(task_params)
    if @task.save
      @tasks = current_user.tasks
      render 'hide_form'
    else
      render 'show_form'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    @tasks = current_user.tasks
    render 'hide_form'
  end

  def edit
    @task = Task.find(params[:id])
    render 'show_form'
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      @tasks = current_user.tasks
      render 'hide_form'
    else
      render 'show_form'
    end
  end

  def check
    @task = Task.find(params[:id])
    @task.checked = !@task.checked
    if @task.save
      @tasks = current_user.tasks
      render 'hide_form'
    end
  end


  private
    def task_params
      params.require(:task).permit(:title, :note, :completed, :status)
    end

end
