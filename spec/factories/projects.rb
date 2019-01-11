FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "ProjectName#{n}" }
    sequence(:desc) { |n| "ProjectDescription#{n}" }
  end
end
