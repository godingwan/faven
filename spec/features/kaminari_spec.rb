require 'spec_helper'

feature 'kaminari paginates pages' do
  scenario 'unless if there is less than 8 items' do
    FactoryGirl.create_list(:list, 7)

    visit lists_path

    expect(page).to_not have_link("Next")
  end

  scenario 'with 2 pages if there are more than 8 items' do
    FactoryGirl.create_list(:list, 8)

    visit lists_path

    expect(page).to have_link("Next")
  end
end
