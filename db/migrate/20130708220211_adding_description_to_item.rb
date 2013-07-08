class AddingDescriptionToItem < ActiveRecord::Migration
  def change
    add_column :list_items, :description, :text
  end
end
