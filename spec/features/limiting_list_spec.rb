require 'spec_helper'

feature 'limiting lists' do
  scenario 'user has seven lists' do
    user = FactoryGirl.create(:user)
    FactoryGirl.create_list(:list, 7, user: user)

    sign_in_as(user)

    visit user_lists_path(user)
    click_link "Add a list"
    fill_in "Title", :with => "Over the limit"
    click_button "Create List"

    expect(page).to_not have_content("Over the limit")
  end
end
