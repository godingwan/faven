require 'spec_helper'

feature 'user visiting wiki page' do
  context 'user signed in' do
    scenario 'link must be to wikipedia page' do
      user = FactoryGirl.create(:user)
      list = FactoryGirl.create(:list, user: user)
      item = FactoryGirl.create(:list_item, list: list)
      wiki_url = item.wiki_url

      sign_in_as(user)
      visit list_path(list)

      expect(page.has_link?("Wiki", href: wiki_url)).to eq(true)
    end
  end

  context 'user not signed in' do
    let(:list) { FactoryGirl.create(:list) }
    let(:item) { FactoryGirl.create(:list_item, list: list)}

    scenario 'list is published' do
      wiki_url = item.wiki_url

      sign_in_as(list.user)
      visit list_path(list)
      click_button "Publish"
      click_link "Sign out"
      visit list_path(list)

      expect(page.has_link?("Wiki", href: wiki_url)).to eq(true)
    end

    scenario 'list is not published' do
      visit list_path(list)

      expect(page).to have_content("That list is not public")
    end
  end
end
