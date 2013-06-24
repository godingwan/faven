require 'spec_helper'

feature 'deleting list', %q{
  As a user
  I want to be able to delete a list
  so that I can remove an old list
} do

  # Acceptance Criteria
  # I must see a delete option for a list
  # Upon clicking the delete option, the list must be gone
  # I must not see a delete option on another user's list
  # I must see a confirmation warning before deleting a list
  # I must not be able to delete another person's list

  context 'when on own list' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:list) { FactoryGirl.create(:list, user: user) }
    before(:each) do
      sign_in_as(user)

      visit user_lists_path(user)
    end

    scenario 'I must see a delete button' do
      expect(page).to have_button("Delete list")
    end

    scenario 'I must not see the list after I delete it' do
      click_button "Delete list"

      expect(page).to_not have_content(list.title)
    end
  end

end
