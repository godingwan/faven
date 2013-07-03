require 'spec_helper'

feature 'viewing lists as unregistered user' do
  let(:user) { FactoryGirl.create(:user) }
  let(:list) { FactoryGirl.create(:list, user: user, state: "published") }

  scenario 'user lists must all be present' do
    list
    visit user_lists_path(user)

    expect(page).to have_content(list.title)
  end

  scenario 'specific list must all be present' do
    item = FactoryGirl.create(:list_item, list: list)

    visit list_path(list)

    expect(page).to have_content(item.title)
  end
end
