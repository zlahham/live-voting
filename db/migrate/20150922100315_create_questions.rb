class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :content

      t.timestamps null: false
    end
  end
end
