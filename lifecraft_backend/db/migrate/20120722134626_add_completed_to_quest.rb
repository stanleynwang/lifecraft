class AddCompletedToQuest < ActiveRecord::Migration
  def change
    change_table :quests do |t|
      t.boolean :completed, :null => false, :default => false
    end
  end
end
