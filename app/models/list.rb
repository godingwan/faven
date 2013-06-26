class List < ActiveRecord::Base
  attr_accessible :title, :user

  validates_presence_of :user, :title
  validate :cannot_be_over_7, on: :create

  belongs_to :user
  has_many :list_items

  def cannot_be_over_7
    unless user.nil? or user.lists.count < 7
      errors.add(:title, "You can only have seven lists.")
    end
  end
end
