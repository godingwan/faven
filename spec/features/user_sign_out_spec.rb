require 'spec_helper'

feature 'user signing out' do
  let(:user) { FactoryGirl.create(:user) }

  scenario 'must see a sign out link' do
    sign_in_as(user)

    expect(page).to have_content("Sign out")
  end

  scenario 'must not see sign out if already signed out' do
    sign_in_as(user)

    click_link "Sign out"

    expect(page).to_not have_content("Sign out")
  end
end
