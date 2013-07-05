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

  it 'must be limited to seven items' do
    list = FactoryGirl.create(:list)
    FactoryGirl.create_list(:list_item, 7, list: list)

    over_limit_item = FactoryGirl.build(:list_item, list: list)

    expect(over_limit_item.save).to eq(false)
  end

  describe "wiki_safe" do
    it 'must replace space character with an underscore' do
      item = FactoryGirl.create(:list_item, title: "test string")

      expect(item.wiki_url).to eq("http://www.en.wikipedia.org/wiki/Test_String")
    end

    it 'must get rid of commas' do
      item = FactoryGirl.create(:list_item, title: "Seoul, South Korea")

      expect(item.wiki_url).to eq("http://www.en.wikipedia.org/wiki/Seoul_South_Korea")
    end
  end
end
