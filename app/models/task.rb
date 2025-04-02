class Task < ApplicationRecord
    belongs_to :user

    # validate presence of title and due_date on the tasks
    validates :title, presence: true
    validates :due_date, presence: true
end
