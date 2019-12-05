class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all.sort_by {|n| n.cycle_completion_percentage }
    @recurring_tasks = RecurringTask.order(name: :asc).all
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to activities_url, notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def cycle_duration
    @total = Activity.all.map(&:hours_per_cycle).inject(0){|m,n|m+n}
  end

  def past_weeks
    @today = get_records(Date.today,Date.today + 1).sum(:hours_spent)
    @past_week = get_records(1.week.ago, Date.today + 1).sum(:hours_spent) # 8 days
    @two_weeks_ago = get_records(2.weeks.ago, 1.week.ago).sum(:hours_spent)
    @three_weeks_ago = get_records(3.weeks.ago, 2.weeks.ago).sum(:hours_spent)
    @four_weeks_ago = get_records(4.weeks.ago, 3.weeks.ago).sum(:hours_spent)
    @last_month = get_records(1.month.ago, Date.today).sum(:hours_spent)
    @two_months_ago = get_records(2.months.ago, 1.month.ago).sum(:hours_spent)
    @monday = get_day_records("Monday").sum(:hours_spent)
    @tuesday = get_day_records("Tuesday").sum(:hours_spent) 
    @wednesday = get_day_records("Wednesday").sum(:hours_spent)
    @thursday = get_day_records("Thursday").sum(:hours_spent)
    @friday = get_day_records("Friday").sum(:hours_spent)
    @saturday = get_day_records("Saturday").sum(:hours_spent)
    @sunday = get_day_records("Sunday").sum(:hours_spent)
  end

  def delete_all
    Record.delete_all
    redirect_to activities_url
  end

  def archive_old
    activities = Activity.all.map do |activity|
      [activity, activity.cycle_completion_hours]
    end
    activities.each do |activity, hours|
      activity.archive_old_records! hours
    end
    redirect_to activities_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:name, :hours_per_cycle)
    end

    def date_of_last(day)
      date  = Date.parse(day)
      delta = date < Date.today ? 0 : 7
      date - delta
    end

    def make_date_time(day, time)
      t = Time.parse(time)
      dt = DateTime.new(day.year, day.month, day.day, t.hour, t.min, t.sec)
    end

    def get_records(start, finish)
      Record.all.where(:created_at => start..finish)
    end

    def get_day_records(day)
      get_records(make_date_time(date_of_last(day), "00:00"), make_date_time(date_of_last(day), "23:59"))
    end
end
