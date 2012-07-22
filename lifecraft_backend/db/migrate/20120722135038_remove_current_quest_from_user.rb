class RemoveCurrentQuestFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :current_quest_id
  end
end
