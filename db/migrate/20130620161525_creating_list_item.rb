class CreatingListItem < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.integer :list_id, :null => false
      t.string  :title,   :null => false
      t.timestamps
    end
  end
end
