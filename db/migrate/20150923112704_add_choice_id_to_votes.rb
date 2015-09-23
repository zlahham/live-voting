class AddChoiceIdToVotes < ActiveRecord::Migration
  def change
  	add_reference :votes, :choice, index: true, foreign_key: true
  end
end
