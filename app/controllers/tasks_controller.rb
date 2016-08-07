class TasksController < ApplicationController
  before_action :logged_in_user

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.create(task_params)
    if @task.save
      redirect_to root_path
    else
      flash[:danger] = '失败了，检查后重试......'
      redirect_to new_task_path
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to root_path, status: 303
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to root_path
    else
      flash[:danger] = '失败了，检查后重试......'
      redirect_to edit_task_path(@task)
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def check
    @task = Task.find(params[:id])
    @task.checked = !@task.checked
    if @task.save
      redirect_to root_path, status:303
    end
  end


  private
    def task_params
      params.require(:task).permit(:title, :note, :completed, :status)
    end

end
