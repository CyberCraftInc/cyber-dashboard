FactoryBot.define do
  factory :event do
    sequence(:description) { |n| "Description to event#{n}" }
    start_date { Time.current }
    finish_date { start_date + (30 * 60 * 60 * 24) }
    sequence(:comments) { |n| "Comment to event#{n}" }
    sequence(:summary) { |n| "Summary to event#{n}" }
    status { 'scheduled' }
    association :user, factory: :user
  end
end
