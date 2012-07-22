class AddCurrentQuestToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :current_quest_id
    end
  end
end
