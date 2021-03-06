# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

activity1 = Activity.create(name:"activity1", hours_per_cycle: 20)
activity2 = Activity.create(name:"activity2", hours_per_cycle: 15)
activity3 = Activity.create(name:"activity3", hours_per_cycle: 2)

Record.create(hours_spent: 10, activity: activity1)
Record.create(hours_spent: 10, activity: activity2)
Record.create(hours_spent: 10, activity: activity3)

[activity1, activity2, activity3].each do |activity|
  (1..60).to_a.each do |i|
    Record.create(hours_spent: rand(3)+1, activity: activity, created_at: i.days.ago, updated_at: i.days.ago)
  end
end