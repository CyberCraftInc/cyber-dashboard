FactoryBot.define do
  factory :event do
    sequence(:description) { |n| "Desc#{n}" }
    start_date { '2019-01-15' }
    finish_date { '2019-01-15' }
    comments { 'MyText' }
    summary { 'MyText' }
    association :user, factory: :user
  end
end
