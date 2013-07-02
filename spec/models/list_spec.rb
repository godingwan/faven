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

  describe 'viewable_by' do
    let(:user) { FactoryGirl.create(:user) }

    it 'returns published lists' do
      list = FactoryGirl.create(:list, state: 'published')

      List.viewable_by(user).should include(list)
    end

    it 'excludes drafted lists' do
      list = FactoryGirl.create(:list, state: 'drafted')

      List.viewable_by(user).should_not include(list)
    end

    it 'returns all lists of the owner' do
      published_list = FactoryGirl.create(:list, state: 'published', user: user)
      drafted_list = FactoryGirl.create(:list, state: 'drafted', user: user)

      List.viewable_by(user).should include(published_list)
      List.viewable_by(user).should include(drafted_list)
    end
  end
end
