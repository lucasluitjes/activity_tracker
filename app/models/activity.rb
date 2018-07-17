class Activity < ApplicationRecord
  has_many :records, dependent: :destroy

  validates :name, presence: true
  validates :hours_per_cycle, presence: true

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
    (current_cycle - Activity.lowest_cycle) * 100
  end

  def cycle_completion_hours
    (cycle_completion_percentage / 100) * hours_per_cycle
  end
end
