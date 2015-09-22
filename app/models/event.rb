class Event < ActiveRecord::Base

  belongs_to :user
  has_many :questions
  validates :user, presence: true

end
