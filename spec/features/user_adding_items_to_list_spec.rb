require 'spec_helper'

feature 'adding items to a list', %q{
As a user
I want to be able to add an item to my favorites list
So that I can change my list
} do

#   Acceptance Criteria
# * I need to be logged in to add items to my list
# * I must provide a title to save the item to the list

  context 'not signed in' do
    scenario 'must be signed in' do
      visit new_list_path

      expect(page).to have_content("You need to sign in or sign up before continuing")
    end
  end

  context 'on own list' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:list) { FactoryGirl.create(:list, user: user) }
    before(:each) do
      sign_in_as(user)
    end

    scenario 'item appears on show page after save' do
      visit list_path(list)

      fill_in "List item", :with => "item 1"
      click_button "Add item"

      expect(page).to have_content("item 1")
    end

    scenario 'manually clicking list title to go to the list' do
      click_link "Go to Lists"
      click_link list.title
      fill_in "List item", :with => "item 1"
      click_button "Add item"

      expect(page).to have_content("item 1")
    end

    scenario 'must see an error if I do not provide an item title' do
      visit list_path(list)

      click_button "Add item"

      expect(page).to have_content("Item title cannot be blank.")
    end
  end

  context 'on another list' do
    scenario 'cannot add items' do
      malicious_user = FactoryGirl.create(:user)
      other_user = FactoryGirl.create(:user)
      other_list = FactoryGirl.create(:list, user: other_user)

      sign_in_as(malicious_user)

      visit list_path(other_list)

      expect(page).to_not have_button('Add item')
    end
  end
end
