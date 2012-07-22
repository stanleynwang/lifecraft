class CreateQuest < ActiveRecord::Migration
  def change
    create_table :quests do |t|
      t.integer :user_id
      t.integer :activity_id
    end
  end
end
