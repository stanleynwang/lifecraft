class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :email
      t.string  :nickname
      t.integer :experience
      t.integer :level
      t.timestamps
    end
  end
end
