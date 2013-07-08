require 'spec_helper'

feature "user viewing an item's show page", %q{
  As a user
  I want to be able to get more info on an item
  So that I can see more details
  } do

  let(:list) { FactoryGirl.create(:list) }
  let(:item) { FactoryGirl.create(:list_item, list: list) }

  scenario 'must see a description field' do
    sign_in_as(list.user)
    visit list_item_path(item)

    expect(page).to have_button("Change info")
  end

  scenario 'filled out description must show' do
    sign_in_as(list.user)
    visit list_item_path(item)

    fill_in "Description", :with => "my description"
    click_button("Change info")

    expect(page).to have_content("my description")
  end
end
