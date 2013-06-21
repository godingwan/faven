class List < ActiveRecord::Base
  attr_accessible :title, :user

  validates_presence_of :user, :title

  belongs_to :user
  has_many :list_items
end
