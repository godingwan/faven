require 'spec_helper'

describe Comment do
  it { should belong_to :list_item }
  it { should validate_presence_of :body }
  it { should belong_to :user }

  it 'must save if a comment is supplied' do
    comment = Comment.new
    comment.body = "New comment"
    comment.list_item_id = 1
    comment.user_id = 1

    expect(comment.save).to eq(true)
  end

  it 'must not save if no comment is provided' do
    comment = Comment.new

    expect(comment.save).to eq(false)
  end
end
