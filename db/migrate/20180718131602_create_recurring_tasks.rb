class CreateRecurringTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :recurring_tasks do |t|
      t.string :name
      t.datetime :completed_at

      t.timestamps
    end
  end
end
