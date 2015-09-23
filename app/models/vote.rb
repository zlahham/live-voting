class Vote < ActiveRecord::Base
	belongs_to :choice
	belongs_to :voter
	validates :choice, presence: true
end
