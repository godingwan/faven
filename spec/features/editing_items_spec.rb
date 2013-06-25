require 'spec_helper'

feature 'editing items', %q{
As a user
I want to be able to edit an item
so that I can update info
} do
  # Acceptance Criteria
  # I must see an edit item link
  # After editing an item, I must see the change
  # If I am on another user's list, I should not be able to see an edit link

  context 'when on own list' do
    let(:user) { FactoryGirl.create(:user) }
    let(:list) { FactoryGirl.create(:list, user: user) }
    let!(:item) { FactoryGirl.create(:list_item, list: list) }
    before(:each) do
      sign_in_as(user)

      visit list_path(list)
    end

    scenario 'I must see an edit item link' do
      expect(page).to have_content("Edit item")
    end

    scenario 'I must see the change' do
      click_link "Edit item"
      fill_in "Title", :with => "new title"
      click_button "Update List item"

      expect(page).to have_content("new title")
    end
  end

  context 'when on other list' do
    scenario 'I must not see an edit item link' do
      malicious_user = FactoryGirl.create(:user)
      other_user = FactoryGirl.create(:user)
      other_user_list = FactoryGirl.create(:list, user: other_user)
      other_user_list_item = FactoryGirl.create(:list_item, list: other_user_list)

      sign_in_as(malicious_user)

      visit list_path(other_user_list)

      expect(page).to_not have_content("Edit item")
    end
  end
end
