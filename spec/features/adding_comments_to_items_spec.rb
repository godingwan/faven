require 'spec_helper'

feature 'item contains comment option', %q{
  As a user
  I want to be able to leave comments on items
  So that I can start a discussion
  } do

  context 'as a sign in user' do
    scenario 'I must be able to add a comment to an item' do
      list = FactoryGirl.create(:list)
      item = FactoryGirl.create(:list_item, list: list)

      sign_in_as(list.user)
      visit list_item_path(item)
      fill_in "Comment", :with => "Owner comment"
      click_button "Create Comment"

      expect(page).to have_content("Owner comment")
    end
  end

  context 'as not a signed in user' do
    scenario 'I must not be able to add a comment' do
      list = FactoryGirl.create(:list)
      item = FactoryGirl.create(:list_item, list: list)

      visit list_item_path(item)

      expect(page).to_not have_button("Create Comment")
    end
  end
end
