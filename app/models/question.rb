class Question < ActiveRecord::Base
  belongs_to :event

  validates :event, :content, presence: true
end
