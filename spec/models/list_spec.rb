require 'spec_helper'

describe List do
  it 'must provide user_id to be saved' do
    previous_count = List.count

    list = FactoryGirl.build(:list, user_id: nil)
    list.save

    expect(List.count).to eql(previous_count)
  end

  it 'must provide a title to be saved' do
    previous_count = List.count

    list = FactoryGirl.build(:list, title: '')
    list.save

    expect(List.count).to eql(previous_count)
  end

  it { should belong_to(:user) }
end
