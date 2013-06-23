require 'spec_helper'

feature 'deleting items from list', %q{
As a user
I want to be able to delete items from a list
So that if I can take it off my list
  } do

  # Acceptance Criteria
  # I must see a delete item option
  # I must see a warning before I delete an item
  # I must be able to delete an item if it exists
  # I must not be able to delete an item if it doesn't exist
  # I must not be able to delete another user's list item

  context 'when on own list' do
      let(:user) { FactoryGirl.create(:user) }
      let(:list) { FactoryGirl.create(:list, user: user) }
      let!(:item) { FactoryGirl.create(:list_item, list: list) }
      before(:each) do
        sign_in_as(user)

        visit list_path(list)
      end

    scenario 'I must see a delete link' do
      expect(page).to have_button("Delete item")
    end

    pending 'I must see a warning before it deletes' do
      click_button "Delete item"

      expect(page).to have_content("Are you sure?")
    end

    scenario 'after I delete an item it should not be there anymore' do
      click_button "Delete item"

      expect(page).to_not have_content(item.title)
    end
  end
end
