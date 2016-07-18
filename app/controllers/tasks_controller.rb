class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource # add this line

  # GET /tasks
  # GET /tasks.json
  def index
    if !current_user.nil? && current_user.has_role?(:teacher)
      @cohorts = Cohort.all.order(:name).reverse
      @students_without_cohorts = User.with_role(:student).where(cohort: nil)
    else
      flash[:alert] = 'You are not authorized to view this page'
      redirect_to '/user/index'
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @user_createdby = User.find(@task.createdby_id)
  end

  # GET /tasks/new
  def new
    if !current_user.nil? && current_user.has_role?(:teacher)
      @task = Task.new
    else
      flash[:alert] = 'You are not authorized to view this page'
      redirect_to '/user/index'
    end
  end

  # GET /tasks/1/edit
  def edit
    if current_user.nil? || !current_user.has_role?(:teacher)
      flash[:alert] = 'You are not authorized to view this page'
      redirect_to '/user/index'
    end
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.createdby_id = current_user.id

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def mark_complete
    @task = Task.find(params[:task_id])
    @task.completed = true
    @task.save
    redirect_to :back
  end

  def mark_incomplete
    @task = Task.find(params[:task_id])
    @task.completed = false
    @task.save
    redirect_to :back
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create_for_cohort
    if !params[:title].empty?
      cohort = Cohort.find(params[:cohort_id])
      cohort.users.each do |student|
        new_task = Task.new
        new_task.title = params[:title]
        new_task.description = params[:description]
        new_task.user = student
        new_task.createdby_id = @current_user.id
        new_task.save
      end
      redirect_to '/tasks'
    else
      flash[:alert] = 'Tasks must have a title'
      redirect_to :back
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :description, :completed, :user_id)
    end
end
