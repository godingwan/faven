require 'spec_helper'

feature 'user adding a description to a list', %q{
  As a user
  I want to be able to add a description to my list
  So that I can share why that is my favorite list
  }do

  let(:list) { FactoryGirl.create(:list) }

  scenario 'must see a link to add description' do
    sign_in_as(list.user)
    click_link list.title

    expect(page).to have_button("Change description")
  end

  scenario 'must see descrition on list#show page' do
    sign_in_as(list.user)
    click_link list.title
    fill_in "Description", :with => "My description"
    click_button "Change description"
    click_link list.title

    expect(page).to have_content("My description")
  end
end
