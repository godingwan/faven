FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "e#{n}@mail.com" }
    password "abc123456"
    password_confirmation "abc123456"
  end
end
