#Rough description of the activity tracker
#
#We'll have 2 tables: activities and records.
#
#Activity: a string name and a bigdecimal hours_per_cycle.
#Record: a foreign key activity ID, a bigdecimal hours_spent, and a created_at datetime field.
#
#Then the web app itself will be protected with basic authentication, grabbing creds from ENV.
#
#Next: we'll add scaffold's for records and activities.
#
#The activity scaffold index screen can also serve as the dashboard: it should show how far along each activity is in the current cycle. We can have a little horizontal bar showing percent completed (range from 0 percent to 200 percent, so we can show if an activity is beyond the current cycle. But we should definitely also show the amount of hours completed for this cycle, not just the percentage.
#
#The following pseudocode shows how to calculate the completion percentage per activity for a given cycle:

class Activity  < Model
  def self.lowest_cycle
    all.map(&:current_cycle).min.to_i
  end

  def total_hours_spent
    records.map(&:hours_spent).inject(0) { |n, m| n + m }
  end

  def current_cycle
    total_hours_spent / hours_per_cycle
  end

  def cycle_completion_percentage
    (current_cycle - self.lowest_cycle) * 100
  end

  def cycle_completion_hours
    (cycle_completion_percentage / 100) * hours_per_cycle
  end
end


