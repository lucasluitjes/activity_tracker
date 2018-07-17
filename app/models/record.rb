class Record < ApplicationRecord
  validates :hours_spent, presence: true
  belongs_to :activity
end
