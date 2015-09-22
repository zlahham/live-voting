class AddEventIdToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :event, index: true, foreign_key: true
  end
end
