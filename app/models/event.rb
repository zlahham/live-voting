class Event < ActiveRecord::Base
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :voters

  validates :user, :title, presence: true
end
