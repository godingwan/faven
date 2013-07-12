class AddingItemId < ActiveRecord::Migration
  def change
    add_column :comments, :list_item_id, :integer, :null => false
  end
end
