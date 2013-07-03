require 'spec_helper'

feature 'removing a list deletes items' do

  let(:user) { FactoryGirl.create(:user) }

  scenario 'deleting a list also deletes its items' do
    list = FactoryGirl.create(:list, user: user)
    FactoryGirl.create_list(:list_item, 3, list: list)

    List.should have(1).record
    ListItem.should have(3).records

    sign_in_as user

    visit user_lists_path(user)

    click_link 'Delete list'

    List.should have(0).records
    ListItem.should have(0).records
  end
end
