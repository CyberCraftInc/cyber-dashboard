FactoryBot.define do
  factory :user do
    last_name { 'Last_Name' }
    first_name { 'First_Name' }
    sequence(:email) { |n| "user#{n}@example.org" }
    sequence(:phone) { rand(10**9..10**10) }
    password { 'secret' }
    password_confirmation { password }
    association :project, factory: :project
  end
end
