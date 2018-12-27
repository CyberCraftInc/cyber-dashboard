FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "John#{n}" }
    sequence(:last_name)  { |n| "Doe#{n}" }
    sequence(:email)      { |n| "user#{n}@example.org" }
    sequence(:phone)      { |n| "+38000000000#{n}" }
    password              { 'secret' }
    password_confirmation { password }
    association :project, factory: :project
  end
end
