FactoryBot.define do
  factory :target do
    sequence(:description) { |n| "Desc#{n}" }
    association :event, factory: :event
    achieved { false }
  end
end
