class Question < ActiveRecord::Base
  belongs_to :event
  has_many :choices, dependent: :destroy, :inverse_of => :question

  accepts_nested_attributes_for :choices, reject_if: :all_blank, allow_destroy: true

  validates :event, :content, presence: true
end
