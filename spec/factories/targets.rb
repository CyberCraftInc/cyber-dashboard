FactoryBot.define do
  factory :target do
    sequence(:description) { |n| "Description of target#{n}" }
    association :event, factory: :event
    achieved { false }
  end
end
