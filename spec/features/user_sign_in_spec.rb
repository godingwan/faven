require 'spec_helper'

feature 'user sign in page' do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'user is able to sign in' do
    visit '/'

    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"

    expect(page).to have_content("Signed in")
  end

  scenario 'user puts in an invalid account' do
    visit '/'

    fill_in "Email", :with => "not_valid_email"
    fill_in "Password", :with => "short"
    click_button "Sign in"

    expect(page).to have_content("Invalid")
  end

  scenario 'must not see a sign in form if already signed in' do
    sign_in_as(user)

    expect(page).to_not have_content("Sign in")
  end
end
