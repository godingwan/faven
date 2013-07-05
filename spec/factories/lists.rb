FactoryGirl.define do
  factory :list do
    user
    sequence(:title) { |n| "list title #{n}"}
    state "published"
  end
end
