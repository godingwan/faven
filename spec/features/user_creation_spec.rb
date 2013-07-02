require 'spec_helper'

feature 'user creating an account' do
  scenario 'can click on the Sign Up link' do
    visit '/users/sign_up'

    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
  end

  scenario 'must provide all info to create an account' do
    visit '/users/sign_up'

    fill_in "Username", :with => "username"
    fill_in "Email", :with => 'blah@email.com'
    fill_in "Password", :with => "abc123456"
    fill_in "Password confirmation", :with => "abc123456"
    click_button "Sign up"

    expect(page).to have_content("signed up successfully.")
  end

  scenario 'receive error message if info is not filled out' do
    visit '/users/sign_up'

    click_button "Sign up"

    expect(page).to have_content("Username can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end

  scenario 'must not see a sign out button if not signed in' do
    visit '/'

    expect(page).to_not have_content("Sign out")
  end

  scenario 'must see a sign out button if signed in' do
    user = FactoryGirl.create(:user)

    sign_in_as(user)

    expect(page).to have_content("Sign out")
  end
end
