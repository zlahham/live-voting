class Question < ActiveRecord::Base
  belongs_to :event
  has_many :choices, dependent: :destroy, :inverse_of => :question

  accepts_nested_attributes_for :choices

  validates :event, :content, presence: true
end
