class AddVoterIdToVotes < ActiveRecord::Migration
  def change
    add_reference :votes, :voter, index: true, foreign_key: true
  end
end
