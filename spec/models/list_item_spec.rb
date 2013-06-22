require 'spec_helper'

describe ListItem do
  it { should belong_to :list }

  it { should validate_presence_of :title }
  it { should validate_presence_of :list }

  it 'does not get saved if title is not provided' do
    previous_count = ListItem.count
    item = ListItem.new

    item.list_id = 1
    item.save

    expect(ListItem.count).to eq(previous_count)
  end

  it 'does not get saved if list id is not provided' do
    previous_count = ListItem.count
    item = ListItem.new

    item.title = "title 1"
    item.save

    expect(ListItem.count).to eq(previous_count)
  end
end
