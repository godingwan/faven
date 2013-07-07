require 'spec_helper'

feature 'I must be able to view all published lists', %q{
  As a user
  I want to be able to view all published lists
  So that I can view other people's list
  } do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:other_user) { FactoryGirl.create(:user) }
  let!(:pub_list) { FactoryGirl.create(:list, user: user) }
  let!(:unpub_list) { FactoryGirl.create(:list, user: user,
    state: "drafted") }
  let!(:other_user_pub_list) { FactoryGirl.create(:list,
    user: other_user) }
  let!(:other_user_unpub_list) { FactoryGirl.create(:list,
    user: other_user, state: "drafted") }

  scenario 'as a signed in user' do
    sign_in_as(user)
    visit lists_path

    expect(page).to have_link(pub_list.title)
    expect(page).to have_link(other_user_pub_list.title)
    expect(page).to_not have_content(unpub_list.title)
    expect(page).to_not have_content(other_user_unpub_list.title)
  end

  scenario 'as not a signed in user' do
    visit lists_path

    expect(page).to have_link(pub_list.title)
    expect(page).to have_link(other_user_pub_list.title)
    expect(page).to_not have_content(unpub_list.title)
    expect(page).to_not have_content(other_user_unpub_list.title)
    expect(page).to_not have_link("Edit list")
    expect(page).to_not have_link("Delete list")
  end
end
