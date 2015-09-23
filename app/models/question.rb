class Question < ActiveRecord::Base
  belongs_to :event
  has_many :choices

  validates :event, :content, presence: true
end
