class Comment < ActiveRecord::Base
  attr_accessible :body

  validates_presence_of :body

  belongs_to :list_item
  belongs_to :user
end
