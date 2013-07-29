require 'spec_helper'

feature 'deleting a comment', %q{
  As a user
  I want to be able to delete a comment
  In case, my opinions change
  } do
  scenario 'as the comment owner' do
    comment = FactoryGirl.create(:comment)

    sign_in_as(comment.user)
    visit list_item_path(comment.list_item)
    click_link "Delete"

    expect(page).to_not have_content("This is a comment")
  end
end
