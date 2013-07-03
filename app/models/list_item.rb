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
end
