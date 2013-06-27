FactoryGirl.define do
  factory :list do
    user
    sequence(:title) { |n| "list title #{n}"}
  end
end
