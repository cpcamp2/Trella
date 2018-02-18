class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only:[:edit, :update, :show, :destroy, :change]

  def index
    @to_do = current_user.tasks.where(state: 'to_do')
    @doing = current_user.tasks.where(state: 'doing')
    @done = current_user.tasks.where(state: 'done')
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.new(tasks_params)
    if @task.save
      flash[:notice] = "Successfully saved task!"
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def update
    if @task.update(tasks_params)
      flash[:notice] = "Successfully updated task"
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @task.destroy
    flash[:notice] = "Task was Successfully Deleted!"
    redirect_to tasks_path
  end

  def change
    @task.update_attributes(state: params[:state])
    flash[:notice] = "Task status was successfully updated"
    redirect_to tasks_path
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def tasks_params
      params.require(:task).permit(:content, :state)
    end
end
