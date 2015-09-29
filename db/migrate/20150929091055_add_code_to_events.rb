class AddCodeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :code, :string, index: true
  end
end