FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "John#{n}" }
    sequence(:last_name)  { |n| "Doe#{n}" }
    sequence(:email)      { |n| "user#{n}@example.org" }
    sequence(:phone)      { |n| (380_000_000_000 + n).to_s }
    password              { 'secret' }
    birthday              { '01 Jan 1990' }
    password_confirmation { password }
    confirmed_at { Time.zone.now }
    association :project, factory: :project
    role { 'employee' }
    factory :admin do
      role { 'admin' }
    end
  end
end
