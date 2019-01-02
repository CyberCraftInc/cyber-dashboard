FactoryBot.define do
  factory :user do
    last_name { 'Last_Name' }
    first_name { 'First_Name' }
    email { 'user@example.org' }
    phone { '+380000000000' }
    password { 'secret' }
    password_confirmation { password }
    project_id { 1 }
  end
end
