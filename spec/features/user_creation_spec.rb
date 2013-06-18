require 'spec_helper'

feature 'user creating an account' do
  scenario 'can click on the Sign Up link' do
    visit '/users/sign_up'

    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
  end

  scenario 'must provide all info to create an account' do
    visit '/users/sign_up'

    fill_in "Email", :with => 'blah@email.com'
    fill_in "Password", :with => "abc123456"
    fill_in "Password confirmation", :with => "abc123456"
    click_button "Sign up"

    expect(page).to have_content("signed up successfully.")
  end

  scenario 'must provide all info to create an account' do
    visit '/users/sign_up'

    click_button "Sign up"

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end

  scenario 'must not see a sign out button if not signed in' do
    pending "write test"
  end

  scenario 'must see a sign out button if signed in' do
    pending 'write test'
  end
end
