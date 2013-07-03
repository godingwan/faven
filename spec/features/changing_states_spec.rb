require 'spec_helper'

feature 'list is hidden until published' do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

  before(:each) do
    sign_in_as(user)
    visit new_list_path
    fill_in "Title", :with => "list title"
    click_button "Create List"
  end

  scenario 'new list is not public initially' do
    click_link "Sign out"
    sign_in_as(other_user)
    visit user_lists_path(user)

    expect(page).to_not have_content('list title')
  end

  scenario "after published, list must be seen by everybody" do
    click_link "list title"
    click_button "Publish"
    click_link "Sign out"
    sign_in_as(other_user)
    visit user_lists_path(user)

    expect(page).to have_content('list title')
  end

  scenario "publish button must only be seen by list owner" do
    click_link "list title"

    expect(page).to have_button("Publish")
  end

  scenario "unpublish must be seen after publishing a list" do
    click_link "list title"
    click_button "Publish"
    click_link "list title"

    expect(page).to have_button ("Unpublish")
  end

  scenario "unpublish button must not be seen by another user" do
    click_link "list title"
    click_button "Publish"
    click_link "Sign out"
    sign_in_as(other_user)
    visit user_lists_path(user)
    click_link "list title"

    expect(page).to_not have_button("Unpublish")
  end
end
