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
    scenario 'list is published' do
      list = FactoryGirl.create(:list)
      item = FactoryGirl.create(:list_item, list: list)
      wiki_url = item.wiki_url

      visit list_path(list)

      expect(page.has_link?("Wiki", href: wiki_url)).to eq(true)
    end
  end
end
