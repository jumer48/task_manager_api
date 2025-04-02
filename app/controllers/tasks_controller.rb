class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [ :show, :update, :destroy, :complete ]

  def index
    @tasks = current_user.tasks
    render json: @tasks, status: :ok
  end

  def show
    @task = current_user.tasks.find(params[:id]) 
    render json: @task
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Task not found" }, status: :not_found
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      render json: @task, status: :created
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    # Ensure that the task belongs to the current user
    if @task.user != current_user
      render json: { error: "You are not authorized to update this task" }, status: :forbidden
      return
    end

    if @task.update(task_params)
      render json: @task, status: :ok
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def complete
    # If it's a single task:
    if @task
      if @task.completed
        render json: { message: "Task is already completed" }, status: :ok
      else
        @task.update(completed: true)
        render json: { message: "Task marked as completed", task: @task }, status: :ok
      end
    elsif @tasks.present?  # If it's a list of tasks
      # Check each task in @tasks and mark them as completed
      @tasks.each do |task|
        unless task.completed
          task.update(completed: true)
        end
      end
      render json: { message: "Tasks marked as completed", tasks: @tasks }, status: :ok
    else
      render json: { error: "Tasks not found" }, status: :not_found
    end
  end

  def destroy
    if @task.user != current_user
      render json: { error: "You are not authorized to delete this task" }, status: :forbidden
      return
    end

    @task.destroy
    render json: { message: "Task deleted successfully" }, status: :ok
  rescue StandardError => e
    render json: { error: "Failed to delete task: #{e.message}" }, status: :unprocessable_entity
  end

  private

  def set_task
    if params[:task_ids].present?
      # Handle multiple tasks when task_ids are provided
      @tasks = current_user.tasks.where(id: params[:task_ids])
      if @tasks.empty?
        render json: { error: "Tasks not found" }, status: :not_found
      end
    else
      # Handle single task by ID
      @task = current_user.tasks.find_by(id: params[:id])
      unless @task
        render json: { error: "Task not found" }, status: :not_found
      end
    end
  end


  def task_params
    params.require(:task).permit(:title, :description, :due_date, :completed)
  end
end
