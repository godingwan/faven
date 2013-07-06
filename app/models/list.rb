class List < ActiveRecord::Base
  attr_accessible :title, :state_event, :description

  state_machine :state, :initial => :drafted do

    event :publish do
      transition :drafted => :published
    end

    event :unpublish do
      transition :published => :drafted
    end

    state :drafted
    state :published
  end

  validates_presence_of :user, :title
  validate :cannot_be_over_7, on: :create

  belongs_to :user, :inverse_of => :lists
  has_many :list_items, :inverse_of => :list, dependent: :destroy

  def cannot_be_over_7
    unless user.nil? or user.lists.count < 7
      errors.add(:title, "You can only have seven lists.")
    end
  end

  def self.viewable_by(user)
    if user.nil?
      where("state = ?", 'published')
    else
      where("state = ? OR user_id = ?", 'published', user.id)
    end
  end
end
