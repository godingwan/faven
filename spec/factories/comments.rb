FactoryGirl.define do
  factory :comment do
    body "This is a comment"
    list_item
    user
  end
end
