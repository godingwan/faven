require 'spec_helper'

feature 'editing an existing list' do
  context 'on own list' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:list) { FactoryGirl.create(:list, user: user) }
    before(:each) do
      sign_in_as(user)

      visit user_lists_path(user)
    end

    scenario 'must see an edit link' do
      expect(page).to have_link("Edit list")
    end

    scenario 'must see the changes after editing a list' do
      click_link "Edit list"

      fill_in "Title", :with => "New title"
      click_button "Update List"

      expect(page).to have_content("New title")
    end
  end

  context 'on another list' do
    scenario 'must not see an edit link' do
      malicious_user = FactoryGirl.create(:user)
      other_user = FactoryGirl.create(:user)
      other_user_list = FactoryGirl.create(:list, user: other_user)

      sign_in_as(malicious_user)

      visit user_lists_path(other_user)

      expect(page).to_not have_link("Edit list")
    end
  end
end
