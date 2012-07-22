class AddDefaultsToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :experience
    remove_column :users, :level
    change_table :users do |t|
      t.integer :experience, :null => false, :default => 0
      t.integer :level, :null => false, :default => 1
    end
  end
end
