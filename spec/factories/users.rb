FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "John#{n}" }
    sequence(:last_name)  { |n| "Doe#{n}" }
    sequence(:email)      { |n| "user#{n}@example.org" }
    sequence(:phone)      { |n| (380_000_000_000 + n).to_s }
    password              { 'secret' }
    position              { 'position' }
    start_in_company      { Time.current - (30 * 60 * 60 * 24) }
    birthday              { Time.current - (20 * 30 * 60 * 60 * 24) }
    password_confirmation { password }
    association :project, factory: :project
    role { 'employee' }
    factory :admin do
      role { 'admin' }
    end
  end
end
