class RecurringTasksController < ApplicationController
  before_action :set_recurring_task, only: [:show, :edit, :update, :destroy, :complete]

  # GET /recurring_tasks
  # GET /recurring_tasks.json
  def index
    @recurring_tasks = RecurringTask.all
  end

  # GET /recurring_tasks/1
  # GET /recurring_tasks/1.json
  def show
  end

  # GET /recurring_tasks/new
  def new
    @recurring_task = RecurringTask.new
  end

  # GET /recurring_tasks/1/edit
  def edit
  end

  # POST /recurring_tasks
  # POST /recurring_tasks.json
  def create
    @recurring_task = RecurringTask.new(recurring_task_params)

    respond_to do |format|
      if @recurring_task.save
        format.html { redirect_to @recurring_task, notice: 'Recurring task was successfully created.' }
        format.json { render :show, status: :created, location: @recurring_task }
      else
        format.html { render :new }
        format.json { render json: @recurring_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recurring_tasks/1
  # PATCH/PUT /recurring_tasks/1.json
  def update
    respond_to do |format|
      if @recurring_task.update(recurring_task_params)
        format.html { redirect_to @recurring_task, notice: 'Recurring task was successfully updated.' }
        format.json { render :show, status: :ok, location: @recurring_task }
      else
        format.html { render :edit }
        format.json { render json: @recurring_task.errors, status: :unprocessable_entity }
      end
    end
  end

  def complete
    @recurring_task.update(completed_at: Time.now)
    redirect_to @recurring_task, notice: 'Recurring task was successfully updated.' 
  end
  # DELETE /recurring_tasks/1
  # DELETE /recurring_tasks/1.json
  def destroy
    @recurring_task.destroy
    respond_to do |format|
      format.html { redirect_to recurring_tasks_url, notice: 'Recurring task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recurring_task
      @recurring_task = RecurringTask.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recurring_task_params
      params.require(:recurring_task).permit(:name, :completed_at)
    end
end
