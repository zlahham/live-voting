class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|

      t.timestamps null: false
    end
  end
end
