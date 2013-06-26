require 'spec_helper'

feature 'limiting lists' do
  context 'user has seven lists' do
    scenario 'must not be able to create anymore lists' do
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

  context 'user has seven items on a list' do
    scenario 'must not be able to add anymore items' do
      user = FactoryGirl.create(:user)
      list = FactoryGirl.create(:list, user: user)
      FactoryGirl.create_list(:list_item, 7, list: list)

      sign_in_as(user)

      visit list_path(list)
      fill_in "List item", :with => "Over the limit"
      click_button "Create List item"

      expect(page).to_not have_content("Over the limit")
    end
  end
end
