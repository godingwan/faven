require 'spec_helper'

feature 'user visiting wiki page' do
  scenario 'clicking link must bring me to wiki page' do
    user = FactoryGirl.create(:user)
    list = FactoryGirl.create(:list, user: user)
    item = FactoryGirl.create(:list_item, list: list)

    sign_in_as(user)

    visit list_path(list)
    click_link "Wiki"

    expect(page).to have_content("Wikipedia")
  end
end
