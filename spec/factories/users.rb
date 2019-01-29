FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "John#{n}" }
    sequence(:last_name)  { |n| "Doe#{n}" }
    sequence(:email)      { |n| "user#{n}@example.org" }
    sequence(:phone)      { |n| (1_000_000_000 + n).to_s }
    password              { 'secret' }
    password_confirmation { password }
    association :project, factory: :project
    role { nil }
  end
end
