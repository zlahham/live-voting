class Choice < ActiveRecord::Base
  belongs_to :question, :inverse_of => :choices
  has_many :votes, dependent: :destroy

  validates :content, :question, presence: true
end
