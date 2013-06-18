require 'spec_helper'

feature 'user sign in page' do
  scenario 'user is able to sign in' do
    FactoryGirl.create(:user)

    visit '/'

    fill_in "Email", :with => "e@mail.com"
    fill_in "Password", :with => "abc123456"
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
    pending 'put code here'
  end
end