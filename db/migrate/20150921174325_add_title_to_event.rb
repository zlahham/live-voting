class AddTitleToEvent < ActiveRecord::Migration
  def change
    add_column :events,  :string
  end
end
