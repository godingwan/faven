FactoryGirl.define do
  factory :list_item do
    sequence(:title) { |n| "item title #{n}"}
    list_id 1
  end
end
