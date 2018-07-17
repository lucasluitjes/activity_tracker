class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.references :activity, foreign_key: true
      t.decimal :hours_spent

      t.timestamps
    end
  end
end
