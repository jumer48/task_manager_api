class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [ :show, :update, :destroy, :complete ]

  def index
    @tasks = current_user.tasks
    render json: @tasks, status: :ok
  end

  def show
    render json: @task
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def complete
    @task.update(completed: true)
    render json: @task
  end

  def destroy
    @task.destroy
    head :no_content
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Task not found" }, status: :not_found
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :completed)
  end
end
