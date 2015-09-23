class Vote < ActiveRecord::Base
	belongs_to :choice
	validates :choice, presence: true
end
