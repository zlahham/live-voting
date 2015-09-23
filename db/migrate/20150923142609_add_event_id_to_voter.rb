class AddEventIdToVoter < ActiveRecord::Migration
  def change
    add_reference :voters, :event, index: true, foreign_key: true
  end
end
