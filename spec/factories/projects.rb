FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "ProjectName#{n}" }
    desc { 'ProjectDescription' }
  end
end
