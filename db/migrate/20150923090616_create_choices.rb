class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.text :content

      t.timestamps null: false
    end
  end
end
