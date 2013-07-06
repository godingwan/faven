class AddingDescriptionToList < ActiveRecord::Migration
  def change
    add_column :lists, :description, :text
  end
end
