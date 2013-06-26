require 'spec_helper'

feature 'user creating list' do
  context 'when signed in' do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in_as(user)

      click_link "Go to Lists"
      click_link "Add a list"
    end

    scenario 'must be able to create a list if all fields are filled' do
      fill_in "Title", :with => "Title 1"

      click_button "Create List"

      expect(page).to have_content("Title 1")
    end

    scenario 'must show successfully created message when list is created' do
      fill_in "Title", :with => "Title 1"

      click_button "Create List"

      expect(page).to have_content("List created successfully")
    end

    scenario 'must not create the list if a title is not provided' do
      click_button "Create List"

      expect(page).to have_content("Titlecan't be blank")
    end
  end

  context 'as a guest' do

    scenario 'redirects to login page' do
      visit new_list_path
      expect(page).to have_content('You need to sign in or sign up before continuing')
    end
  end
end
