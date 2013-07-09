require 'spec_helper'

feature 'search on public lists page' do
  let!(:list_1) { FactoryGirl.create(:list, title: "A") }
  let!(:list_2) { FactoryGirl.create(:list, title: "B") }

  scenario 'returns only searched terms' do
    visit lists_path
    fill_in "Title contains", :with => "a"
    click_button "Search"

    expect(page).to have_content("A")
    expect(page).to_not have_content("B")
  end

  scenario 'returns everything if nothing is placed in search term' do
    visit lists_path
    click_button "Search"

    expect(page).to have_content("A")
    expect(page).to have_content("B")
  end

  scenario 'returns nothing if there are no matches' do
    visit lists_path
    fill_in "Title contains", :with => "C"
    click_button "Search"

    expect(page).to_not have_content("A")
    expect(page).to_not have_content("B")
  end
end
