FactoryGirl.define do
  factory :list_item do
    sequence(:title) { |n| "item title #{n}"}
    list
  end
end
