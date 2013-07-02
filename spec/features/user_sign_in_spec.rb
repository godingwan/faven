require 'spec_helper'

feature 'user sign in page' do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'user is able to sign in with email' do
    visit '/users/sign_in'

    fill_in "Login", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"

    expect(page).to have_content("Signed in")
  end

  scenario 'user is able to sign in with username' do
    visit '/users/sign_in'

    fill_in "Login", :with => user.username
    fill_in "Password", :with => user.password
    click_button "Sign in"

    expect(page). to have_content("Signed in")
  end

  scenario 'user puts in an invalid account' do
    visit '/users/sign_in'

    fill_in "Login", :with => "not_valid_email"
    fill_in "Password", :with => "short"
    click_button "Sign in"

    expect(page).to have_content("Invalid")
  end

  scenario 'must not see a sign in form if already signed in' do
    sign_in_as(user)

    expect(page).to_not have_content("Sign in")
  end
end
