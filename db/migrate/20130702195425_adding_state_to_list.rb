class AddingStateToList < ActiveRecord::Migration
  def change
    add_column :lists, :state, :string, :null => false, :default => "drafted"
  end
end
