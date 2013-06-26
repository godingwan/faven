require 'spec_helper'

describe List do

  it { should have_many :list_items }
  it { should belong_to(:user) }

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

  it 'must be limited to seven lists' do
    user = FactoryGirl.create(:user)
    FactoryGirl.create_list(:list, 7, user: user)

    over_limit_list = FactoryGirl.build(:list, user: user)

    expect(over_limit_list.save).to eq(false)
  end
end
