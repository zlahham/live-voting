class Choice < ActiveRecord::Base
  belongs_to :question
  has_many :votes, dependent: :destroy

  validates :content, presence: true
end
