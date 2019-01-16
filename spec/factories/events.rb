FactoryBot.define do
  factory :event do
    sequence(:description) { |n| "Description to event#{n}" }
    start_date { '2019-01-15' }
    finish_date { '2019-01-15' }
    sequence(:comments) { |n| "Comment to event#{n}" }
    sequence(:summary) { |n| "Summary to event#{n}" }
    status { 'scheduled' }
    association :user, factory: :user
  end
end
