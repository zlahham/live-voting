class Question < ActiveRecord::Base
  belongs_to :event
  has_many :choices, dependent: :destroy

  validates :event, :content, presence: true
end
