class Event < ActiveRecord::Base
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :voters

	accepts_nested_attributes_for :questions

  validates :user, :title, presence: true
end
