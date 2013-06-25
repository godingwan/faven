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
      let!(:item) { FactoryGirl.create(:list_item, title: "item_to_delete", list: list) }
      before(:each) do
        sign_in_as(user)

        visit list_path(list)
      end

    scenario 'I must see a delete link' do
      expect(page).to have_link("Delete item")
    end

    scenario 'after I delete an item it should not be there anymore' do
      click_link "Delete item"

      expect(page).to_not have_content(item.title)
    end
  end

  context 'when on another list' do
    scenario 'must not see a delete link' do
      malicious_user = FactoryGirl.create(:user)
      other_user = FactoryGirl.create(:user)
      other_user_list = FactoryGirl.create(:list, user: other_user)
      other_user_list_item = FactoryGirl.create(:list_item, list: other_user_list)

      sign_in_as(malicious_user)

      visit list_path(other_user_list)

      expect(page).to_not have_link("Delete item")
    end
  end
end
