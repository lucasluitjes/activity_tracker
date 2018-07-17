class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :name
      t.decimal :hours_per_cycle

      t.timestamps
    end
  end
end
