FactoryBot.define do
  factory :target do
    sequence(:desc) { |n| "Desc#{n}" }
    association :event, factory: :event
    status { false }
  end
end
