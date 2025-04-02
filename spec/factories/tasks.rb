FactoryBot.define do
    factory :task do
      title { "Complete project" }
      description { "All backend tasks" }
      due_date { Date.tomorrow }
      completed { false }
      association :user
    end
  end