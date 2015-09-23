class CreateVoters < ActiveRecord::Migration
  def change
    create_table :voters do |t|

      t.timestamps null: false
    end
  end
end
