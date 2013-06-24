require 'spec_helper'

feature 'user on own index page' do
  context 'signed in' do
    let(:active_user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    let!(:active_user_list) { FactoryGirl.create(:list, user: active_user) }
    let!(:other_user_list) { FactoryGirl.create(:list, user: other_user) }
    before(:each) do
      sign_in_as(active_user)

      click_link "Go to Lists"
    end

    scenario 'should only see own list' do
      expect(page).to have_content(active_user_list.title)
    end

    scenario "should not see other user's list" do
      expect(page).to_not have_content(other_user_list.title)
    end
  end
end
