require 'spec_helper'

feature 'adding items to a list', %q{
As a user
I want to be able to add an item to my favorites list
So that I can change my list

Acceptance Criteria
* I need to be logged in to add items to my list
* I must be able to see a field to add the title of the item
* I must provide a title to save the item to the list
} do
  context 'as a user' do
    scenario 'item appears on show page after save' do
      user = FactoryGirl.create(:user)
      list = FactoryGirl.create(:list, user: user)

      sign_in_as(user)

      visit list_path(list)

      fill_in "List item", :with => "item 1"
      click_button "Add item"

      expect(page).to have_content("item 1")
    end
  end
end
