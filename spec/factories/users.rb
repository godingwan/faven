FactoryGirl.define do
  factory :user do
    email "e@mail.com"
    password "abc123456"
    password_confirmation "abc123456"
  end

  factory :list do
    user_id 1
    title 'awesome movie list'
  end
end
