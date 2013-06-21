class ListItem < ActiveRecord::Base

  attr_accessible :title

  validates_presence_of :title, :list

  belongs_to :list
end
