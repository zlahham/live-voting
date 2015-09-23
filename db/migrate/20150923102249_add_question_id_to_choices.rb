class AddQuestionIdToChoices < ActiveRecord::Migration
  def change
    add_reference :choices, :question, index: true, foreign_key: true
  end
end
