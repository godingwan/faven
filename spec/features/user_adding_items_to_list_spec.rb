require 'spec_helper'

feature 'adding items to a list', %q{
As a user
I want to be able to add an item to my favorites list
So that I can change my list
} do

#   Acceptance Criteria
# * I need to be logged in to add items to my list
# * I must be able to see a field to add the title of the item
# * I must provide a title to save the item to the list

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

    pending 'cannot add items to someone elses list' do
      active_user = FactoryGirl.create(:user)

      other_user = FactoryGirl.create(:user)
      other_list = FactoryGirl.create(:list, user: other_user)

      sign_in_as(active_user)

      visit list_path(other_list)
      expect(page).to_not have_button('Add item')
    end

    scenario 'manually clicking list title to go to the list' do
      user = FactoryGirl.create(:user)
      list1 = FactoryGirl.create(:list, user: user)

      sign_in_as(user)

      click_link "Go to Lists"
      click_link "awesome movie list"
      fill_in "List item", :with => "item 1"
      click_button "Add item"

      expect(page).to have_content("item 1")
    end
  end
end
