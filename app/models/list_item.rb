class ListItem < ActiveRecord::Base
  attr_accessible :title

  validates_presence_of :title, :list
  validate :cannot_be_over_7, on: :create

  belongs_to :list, :inverse_of => :list_items

  def cannot_be_over_7
    unless list.nil? or list.list_items.count < 7
      errors.add(:title, "You can only have seven items.")
    end
  end

  def wiki_url
    "http://www.en.wikipedia.org/wiki/#{wiki_safe_title}"
  end

  private
  def wiki_safe_title
    # This gets rid of all unsafe link characters
    edited_title = title.tr("^A-Za-z0-9 ", '')
    # Then combines the words with an underscore
    final_title = edited_title.split.map{|s| s.capitalize}.join("_")
  end
end
