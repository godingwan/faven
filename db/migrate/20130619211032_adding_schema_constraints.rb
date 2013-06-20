class AddingSchemaConstraints < ActiveRecord::Migration
  def up
    change_column :lists, :title, :string, :null => false
    change_column :lists, :user_id, :integer, :null => false
  end

  def down
    change_column :lists, :title, :string, :null => true
    change_column :lists, :user_id, :integer, :null => true
  end
end
