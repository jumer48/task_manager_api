class Task < ApplicationRecord
    belongs_to :user
    validates :title, :due_date, presence: true
    validates :completed, inclusion: { in: [true, false] }
  end