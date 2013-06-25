FactoryGirl.define do
  factory :list do
    user_id 1
    sequence(:title) { |n| "list title #{n}"}
  end
end
