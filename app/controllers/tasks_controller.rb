class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :check_post_user, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    
    if @task.save
      flash[:success] = 'タスクは正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが投稿されませんでした'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_url
  end


  private
  
  # 存在しないidのtaskにアクセスした場合/tasksにリダイレクトする
  def set_task
    if Task.find_by(id: params[:id])
      @task = Task.find_by(id: params[:id])
    else
      redirect_to tasks_url
    end
  end
  
  # 現在ログインしているユーザーのtaskでは無い場合loginページにリダイレクトする
  def check_post_user
    unless current_user.id == @task.user_id
      redirect_to tasks_url
    end
  end

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status, :user_id)
  end
end