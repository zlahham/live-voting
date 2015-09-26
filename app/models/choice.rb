class Choice < ActiveRecord::Base
  belongs_to :question
  has_many :votes, dependent: :destroy
  validates :question, presence: true
end
